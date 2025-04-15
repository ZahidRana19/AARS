fetch('../html/navbar.html')
    .then(response => response.text())
    .then(html => {
        document.getElementById('navbar-container').innerHTML = html;
        if (typeof initializeNavbar === 'function') {
            initializeNavbar();
            const currentPage = window.location.pathname.split('/').pop();
            setActiveNavLink(currentPage);
        }
    });

document.addEventListener('DOMContentLoaded', () => {
    let userRole = localStorage.getItem('userRole');
    initializeDashboard(userRole);
});

function initializeDashboard(role) {
    const normalizedRole = role.toLowerCase();
    
    if (normalizedRole === 'teacher') {
        initializeTeacherDashboard();
    } else if (normalizedRole === 'student') {
        initializeStudentDashboard();
    } else {
        console.error('Unknown role:', role);
        redirectToLogin();
    }
}

function redirectToLogin() {
    localStorage.removeItem('userRole');
    localStorage.removeItem('userId');
    localStorage.removeItem('userName');
    
    window.location.href = '../html/login.html';
}

// Student Dashboard Functions
async function initializeStudentDashboard() {
    try {
        const response = await fetch('../php/Dashboard/student_dashboard.php', {
            credentials: 'same-origin'
        });
        
        if (!response.ok) throw new Error('Network response failed');
        
        const { success, userData, message } = await response.json();
        
        if (!success) throw new Error(message || 'Failed to load student data');
        
        updateStudentDashboard(userData);
        localStorage.setItem('userName', userData.name);
        
    } catch (error) {
        console.error('Student dashboard error:', error);
        showErrorState('student');
    }
}

function updateStudentDashboard(data) {
    document.querySelectorAll('.user-name').forEach(el => {
        el.textContent = data.name;
    });
    
    const stats = [
        data.cgpa ? data.cgpa.toFixed(2) : 'Not Available',
        data.enrolledCourses || '0',
        'Not Available'
    ];
    
    document.querySelectorAll('.stat-value').forEach((el, i) => {
        el.textContent = stats[i];
    });

    const coursesSection = document.querySelector('.courses-section');
    const emptyState = coursesSection.querySelector('.empty-state');
    const courseGrid = document.createElement('div');
    courseGrid.className = 'course-grid';
    
    if (data.courses?.length > 0) {
        emptyState.style.display = 'none';
        
        courseGrid.innerHTML = data.courses.map(course => `
            <div class="course-card">
                <div class="course-header">
                    <h3>${course.CourseCode}</h3>
                    <span class="course-badge">Enrolled</span>
                </div>
                <p class="course-title">${course.CourseName}</p>
                <div class="course-meta">
                    <span><i class="fas fa-layer-group"></i> Section ${course.SectionNo}</span>
                    <span><i class="fas fa-credit-card"></i> ${course.Credits} Credits</span>
                </div>
            </div>
        `).join('');
    } else {
        emptyState.style.display = 'block';
    }
}

// Teacher Dashboard Functions
async function initializeTeacherDashboard() {
    try {
        const response = await fetch('../php/Dashboard/teacher_dashboard.php', {
            credentials: 'same-origin'
        });
        
        if (!response.ok) throw new Error('Network response failed');
        
        const { success, userData, message } = await response.json();
        
        if (!success) throw new Error(message || 'Failed to load teacher data');
        
        updateTeacherDashboard(userData);
        localStorage.setItem('userName', userData.name);
        
    } catch (error) {
        console.error('Teacher dashboard error:', error);
        showErrorState('teacher');
    }
}

function updateTeacherDashboard(data) {
    document.querySelectorAll('.user-name').forEach(el => {
        el.textContent = data.name;
    });
    
    const totalStudents = data.courses.reduce((sum, course) => sum + (course.StudentCount || 0), 0);
    const assignedCourses = data.courses?.length || 0;
    
    document.querySelectorAll('.stat-value').forEach((el, i) => {
        const stats = [
            totalStudents || 'Not Available',
            assignedCourses || '0',
            data.pendingRequests || '0'
        ];
        el.textContent = stats[i];
    });
    
    const coursesSection = document.querySelector('.courses-section');
    const emptyState = coursesSection.querySelector('.empty-state');
    const courseGrid = coursesSection.querySelector('.course-grid');
    
    courseGrid.innerHTML = '';
    
    if (data.courses?.length) {
        emptyState.style.display = 'none';
        courseGrid.style.display = 'grid';
        
        data.courses.forEach(course => {
            const courseCard = document.createElement('div');
            courseCard.className = 'course-card';
            courseCard.innerHTML = `
                <div class="course-header">
                    <h3>${course.CourseCode}</h3>
                    <span class="course-badge">${course.Status || 'Active'}</span>
                </div>
                <p class="course-title">${course.CourseName || course.CourseTitle}</p>
                <div class="course-meta">
                    <span><i class="fas fa-users"></i> ${course.StudentCount || 0} Students</span>
                    <span><i class="fas fa-clock"></i> Section ${course.SecID}</span>
                </div>
                <div class="course-actions">
                    <a href="#" class="btn btn-sm btn-primary"><i class="fas fa-list"></i> Roster</a>
                    <a href="#" class="btn btn-sm btn-secondary"><i class="fas fa-chart-bar"></i> Analytics</a>
                </div>
            `;
            courseGrid.appendChild(courseCard);
        });
    } else {
        emptyState.style.display = 'block';
        courseGrid.style.display = 'none';
    }
}

function showErrorState(role) {
    const errorMessage = role === 'teacher' 
        ? 'Error loading teaching data' 
        : 'Error loading student data';
    
    const errorElement = document.createElement('div');
    errorElement.className = 'alert alert-danger';
    errorElement.innerHTML = `
        <i class="fas fa-exclamation-triangle"></i>
        ${errorMessage}. Please try again later.
    `;
    
    document.querySelector('main').prepend(errorElement);
}