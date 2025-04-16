let currentCourseToDrop = null;

document.addEventListener('DOMContentLoaded', () => {
    fetch('../html/navbar.html')
        .then(response => response.text())
        .then(html => {
            document.getElementById('navbar-container').innerHTML = html;
            if (typeof initializeNavbar === 'function') {
                initializeNavbar();
                const currentPage = window.location.pathname.split('/').pop();
                setActiveNavLink(currentPage);
            }
        })
        .catch(error => console.error('Error loading navbar:', error));

    const userRole = localStorage.getItem('userRole');
    initializePage(userRole);
    
    loadEnrolledCourses();
    
    document.getElementById('refresh-courses').addEventListener('click', loadEnrolledCourses);
    document.getElementById('confirm-drop').addEventListener('click', confirmDropCourse);
    document.getElementById('cancel-drop').addEventListener('click', closeModal);
    document.querySelector('.close-modal').addEventListener('click', closeModal);
});

function initializePage(userRole) {
    if (userRole === '2') {
        document.querySelectorAll('.credits-col, .instructor-col').forEach(el => {
            el.style.display = 'table-cell';
        });
    }
}

function loadEnrolledCourses() {
    const tableBody = document.getElementById('courses-table-body');
    const noCoursesMessage = document.querySelector('.no-courses-message');
    
    tableBody.innerHTML = `
        <tr class="loading-row">
            <td colspan="6">
                <div class="loading-spinner">
                    <i class="fas fa-spinner fa-spin"></i> Loading courses...
                </div>
            </td>
        </tr>
    `;
    
    fetch('../php/Courses/courses.php', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        },
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        if (data.status === 'success' && data.courses.length > 0) {
            renderCoursesTable(data.courses);
            noCoursesMessage.style.display = 'none';
        } else {
            tableBody.innerHTML = '';
            noCoursesMessage.style.display = 'block';
            document.getElementById('total-credits').textContent = 'Total Credits: 0';
        }
    })
    .catch(error => {
        console.error('Error loading courses:', error);
        tableBody.innerHTML = `
            <tr>
                <td colspan="6" style="color: #ff4444; text-align: center;">
                    <i class="fas fa-exclamation-circle"></i> Failed to load courses. Please try again.
                </td>
            </tr>
        `;
    });
}

function renderCoursesTable(courses) {
    const tableBody = document.getElementById('courses-table-body');
    tableBody.innerHTML = '';
    
    courses.forEach(course => {
        const row = document.createElement('tr');
        
        row.innerHTML = `
            <td>${course.CourseCode}</td>
            <td>${course.CourseName}</td>
            <td>${course.SectionNo}</td>
            <td class="credits-col">${course.Credits}</td>
            <td class="instructor-col">${course.InstructorName || 'TBA'}</td>
            <td>
                <button class="drop-btn" 
                        data-course-code="${course.CourseCode}" 
                        data-section-no="${course.SectionNo}">
                    <i class="fas fa-trash-alt"></i> Drop
                </button>
            </td>
        `;
        
        tableBody.appendChild(row);
    });
    
    document.querySelectorAll('.drop-btn').forEach(button => {
        button.addEventListener('click', (e) => {
            e.preventDefault();
            currentCourseToDrop = {
                courseCode: button.dataset.courseCode,
                sectionNo: button.dataset.sectionNo
            };
            
            document.getElementById('drop-confirmation-text').textContent = 
                `Are you sure you want to drop ${button.dataset.courseCode} - Section ${button.dataset.sectionNo}?`;
            document.getElementById('drop-course-modal').style.display = 'block';
        });
    });
}

function confirmDropCourse() {
    if (!currentCourseToDrop) return;
    
    const { courseCode, sectionNo } = currentCourseToDrop;
    
    fetch('../php/Courses/drop_course.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            courseCode: courseCode,
            sectionNo: sectionNo
        }),
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'success') {
            showNotification('Course dropped successfully!', 'success');
            loadEnrolledCourses();
        } else {
            showNotification(data.message || 'Failed to drop course', 'error');
        }
        closeModal();
    })
    .catch(error => {
        console.error('Error dropping course:', error);
        showNotification('Failed to drop course. Please try again.', 'error');
        closeModal();
    });
}

function closeModal() {
    document.getElementById('drop-course-modal').style.display = 'none';
    currentCourseToDrop = null;
}

function showNotification(message, type) {
    const notification = document.createElement('div');
    notification.className = `notification ${type}`;
    notification.textContent = message;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        notification.classList.add('fade-out');
        setTimeout(() => notification.remove(), 500);
    }, 3000);
}