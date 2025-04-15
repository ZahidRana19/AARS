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

document.addEventListener('DOMContentLoaded', function() {
    var coll = document.getElementsByClassName("collapsible");
    for (var i = 0; i < coll.length; i++) {
        coll[i].addEventListener("click", function() {
            this.classList.toggle("active");
            var content = this.nextElementSibling;
            if (content.style.maxHeight) {
                content.style.maxHeight = null;
            } else {
                content.style.maxHeight = content.scrollHeight + "px";
            }
        });
    }

    loadAvailableCourses();
    loadSelectedCourses();
});

function loadAvailableCourses() {
    fetch('../php/Enroll/availableCourses.php')
        .then(response => response.json())
        .then(courses => {
            const courseList = document.getElementById('courseList');
            courseList.innerHTML = '';

            courses.forEach(course => {
                const courseItem = document.createElement('div');
                courseItem.className = 'course-item';
                
                const collapsible = document.createElement('button');
                collapsible.className = 'collapsible';
                collapsible.type = 'button';
                
                const courseCode = document.createElement('span');
                courseCode.className = 'course-code';
                courseCode.textContent = course.CourseCode;
                
                const courseName = document.createElement('span');
                courseName.className = 'course-name';
                courseName.textContent = course.CourseName;
                
                const chevron = document.createElement('i');
                chevron.className = 'fas fa-chevron-down';
                
                collapsible.appendChild(courseCode);
                collapsible.appendChild(courseName);
                collapsible.appendChild(chevron);
                
                const courseContent = document.createElement('div');
                courseContent.className = 'course-content';
                
                courseItem.appendChild(collapsible);
                courseItem.appendChild(courseContent);
                courseList.appendChild(courseItem);
                
                setupCollapsible(collapsible, courseContent);
                loadSectionsForCourse(course.CourseCode, courseContent);
            });
        })
        .catch(error => console.error('Error loading courses:', error));
}

function setupCollapsible(button, content) {
    button.addEventListener('click', function() {
        this.classList.toggle('active');
        const icon = this.querySelector('i');
        
        if (content.style.maxHeight) {
            content.style.maxHeight = null;
            icon.classList.remove('fa-chevron-up');
            icon.classList.add('fa-chevron-down');
        } else {
            content.style.maxHeight = content.scrollHeight + 'px';
            icon.classList.remove('fa-chevron-down');
            icon.classList.add('fa-chevron-up');
        }
    });
}

function loadSectionsForCourse(courseCode, container) {
    fetch(`../php/Enroll/courseSections.php?courseCode=${encodeURIComponent(courseCode)}`)
        .then(response => response.json())
        .then(sections => {
            container.innerHTML = '';
            
            if (sections.length === 0) {
                const noSections = document.createElement('p');
                noSections.textContent = 'No sections available';
                noSections.style.padding = '10px';
                noSections.style.color = '#666';
                container.appendChild(noSections);
                return;
            }
            
            sections.forEach(section => {
                const sectionItem = document.createElement('div');
                sectionItem.className = 'section-item';
                
                const sectionInfo = document.createElement('div');
                sectionInfo.className = 'section-info';
                
                const sectionCode = document.createElement('span');
                sectionCode.className = 'section-code';
                sectionCode.textContent = `${courseCode}.${section.SectionNo}`;
                
                const sectionTime = document.createElement('span');
                sectionTime.className = 'section-time';
                sectionTime.textContent = `${section.ClassDays} ${section.ClassStartTime}-${section.ClassEndTime}`;
                
                const sectionSeats = document.createElement('span');
                sectionSeats.className = 'section-seats';
                sectionSeats.textContent = `${section.SeatsTaken}/${section.TotalSeats}`;
                
                sectionInfo.appendChild(sectionCode);
                sectionInfo.appendChild(sectionTime);
                sectionInfo.appendChild(sectionSeats);
                
                const addButton = document.createElement('button');
                addButton.type = 'button';
                addButton.className = 'add-btn';
                addButton.textContent = 'Add';
                addButton.setAttribute('data-section-code', courseCode);
                addButton.setAttribute('data-section-no', section.SectionNo);
                
                sectionItem.appendChild(sectionInfo);
                sectionItem.appendChild(addButton);
                container.appendChild(sectionItem);
                
                addButton.addEventListener('click', handleAddSection);
            });
            
            const collapsible = container.previousElementSibling;
            if (collapsible.classList.contains('active')) {
                container.style.maxHeight = container.scrollHeight + 'px';
            }
        })
        .catch(error => {
            console.error(`Error loading sections for ${courseCode}:`, error);
            const errorMsg = document.createElement('p');
            errorMsg.textContent = 'Error loading sections';
            errorMsg.style.padding = '10px';
            errorMsg.style.color = 'red';
            container.appendChild(errorMsg);
        });
}

function loadSelectedCourses() {
    fetch('../php/Enroll/selectedSections.php')
        .then(response => response.json())
        .then(sections => {
            const selectedList = document.querySelector('.selected-courses-list');
            selectedList.innerHTML = '';
            
            sections.forEach(section => {
                const selectedItem = document.createElement('div');
                selectedItem.className = 'selected-item';
                
                const sectionInfo = document.createElement('div');
                sectionInfo.className = 'section-info';
                
                const sectionCode = document.createElement('span');
                sectionCode.className = 'section-code';
                sectionCode.textContent = `${section.CourseID}.${section.SectionNo}`;
                
                const sectionTime = document.createElement('span');
                sectionTime.className = 'section-time';
                sectionTime.textContent = `${section.ClassDays} ${section.ClassStartTime}-${section.ClassEndTime}`;
                
                const sectionSeats = document.createElement('span');
                sectionSeats.className = 'section-seats';
                sectionSeats.textContent = `${section.SeatsTaken}/${section.TotalSeats}`;
                
                sectionInfo.appendChild(sectionCode);
                sectionInfo.appendChild(sectionTime);
                sectionInfo.appendChild(sectionSeats);
                
                const removeButton = document.createElement('button');
                removeButton.type = 'button';
                removeButton.className = 'remove-btn';
                removeButton.textContent = 'Remove';
                removeButton.setAttribute('data-section-code', section.CourseID);
                removeButton.setAttribute('data-section-no', section.SectionNo);
                
                selectedItem.appendChild(sectionInfo);
                selectedItem.appendChild(removeButton);
                selectedList.appendChild(selectedItem);
                
                removeButton.addEventListener('click', handleRemoveSection);
            });
        })
        .catch(error => console.error('Error loading selected courses:', error));
}

function handleAddSection(event) {
    const button = event.currentTarget;
    const courseId = button.getAttribute('data-section-code');
    const sectionNo = button.getAttribute('data-section-no');
    
    button.disabled = true;
    button.textContent = 'Adding...';
    
    fetch('../php/Enroll/add_section.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            sectionCode: courseId,
            sectionNo: sectionNo,
        }),
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'success') {
            loadAvailableCourses();
            loadSelectedCourses();
        } else {
            alert(data.message);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred while adding the section.');
    })
    .finally(() => {
        button.disabled = false;
        button.textContent = 'Add';
    });
}

function handleRemoveSection(event) {
    const button = event.currentTarget;
    const courseId = button.getAttribute('data-section-code');
    const sectionNo = button.getAttribute('data-section-no');
    
    button.disabled = true;
    button.textContent = 'Removing...';
    
    fetch('../php/Enroll/remove_section.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            sectionCode: courseId,
            sectionNo: sectionNo,
        }),
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'success') {
            loadAvailableCourses();
            loadSelectedCourses();
        } else {
            alert(data.message);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred while removing the section.');
    })
    .finally(() => {
        button.disabled = false;
        button.textContent = 'Remove';
    });
}

document.getElementById('confirmBtn').addEventListener('click', function() {
    const confirmButton = this;
    
    confirmButton.disabled = true;
    confirmButton.textContent = 'Processing...';
    
    fetch('../php/Enroll/confirm_enrollment.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'success') {
            alert('Enrollment confirmed successfully!');
            loadAvailableCourses();
            loadSelectedCourses();
        } else {
            alert(`Error: ${data.message}`);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred while confirming enrollment.');
    })
    .finally(() => {
        confirmButton.disabled = false;
        confirmButton.textContent = 'Confirm Enrollment';
    });
});

// Search functionality
document.getElementById('search').addEventListener('input', function() {
    const query = this.value.toLowerCase();
    const courseItems = document.querySelectorAll('.course-item');
    
    courseItems.forEach(item => {
        const courseText = item.textContent.toLowerCase();
        item.style.display = (courseText.includes(query) || query === '') ? '' : 'none';
    });
});

// Sorting functionality
document.getElementById('sorting').addEventListener('change', function() {
    const sortOption = this.value;
    const courseList = document.getElementById('courseList');
    const courses = Array.from(courseList.querySelectorAll('.course-item'));
    
    const sortedCourses = courses.sort((a, b) => {
        const codeA = a.querySelector('.course-code').textContent.trim();
        const codeB = b.querySelector('.course-code').textContent.trim();
        const nameA = a.querySelector('.course-name').textContent.trim();
        const nameB = b.querySelector('.course-name').textContent.trim();
        
        switch (sortOption) {
            case 'code-asc': return codeA.localeCompare(codeB);
            case 'code-desc': return codeB.localeCompare(codeA);
            case 'name-asc': return nameA.localeCompare(nameB);
            case 'name-desc': return nameB.localeCompare(nameA);
            default: return 0;
        }
    });
    
    courseList.innerHTML = '';
    sortedCourses.forEach(course => courseList.appendChild(course));
    
    var coll = document.getElementsByClassName("collapsible");
    for (var i = 0; i < coll.length; i++) {
        coll[i].addEventListener("click", function() {
            this.classList.toggle("active");
            var content = this.nextElementSibling;
            if (content.style.maxHeight) {
                content.style.maxHeight = null;
            } else {
                content.style.maxHeight = content.scrollHeight + "px";
            }
        });
    }
});

function updateSelectedCoursesUI() {
    loadAvailableCourses();
    loadSelectedCourses();
}