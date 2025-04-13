async function fetchStudentData() {
    try {
        const response = await fetch('getStudentData.php');
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        const data = await response.json();
        
        if (data.success) {
            return data.student;
        } else {
            throw new Error(data.message || 'Failed to fetch student data');
        }
    } catch (error) {
        console.error('Error fetching student data:', error);
        alert('Failed to load student data. Please refresh the page or contact support.');
        return null;
    }
}
async function fetchCourseRecords() {
    try {
        const response = await fetch('getCourseRecords.php');
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        const data = await response.json();
        
        if (data.success) {
            return data.courses;
        } else {
            throw new Error(data.message || 'Failed to fetch course records');
        }
    } catch (error) {
        console.error('Error fetching course records:', error);
        return [];
    }
}

async function fetchSemesterGPA() {
    try {
        const response = await fetch('getSemesterGPA.php');
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        const data = await response.json();
        
        if (data.success) {
            return data.gpaData;
        } else {
            throw new Error(data.message || 'Failed to fetch GPA data');
        }
    } catch (error) {
        console.error('Error fetching GPA data:', error);
        return [];
    }
}

async function fetchDeadlines() {
    try {
        const response = await fetch('getDeadlines.php');
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        const data = await response.json();
        
        if (data.success) {
            return data.deadlines;
        } else {
            throw new Error(data.message || 'Failed to fetch deadlines');
        }
    } catch (error) {
        console.error('Error fetching deadlines:', error);
        return [];
    }
}


async function fetchAdvisorInfo() {
    try {
        const response = await fetch('getAdvisorInfo.php');
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        const data = await response.json();
        
        if (data.success) {
            return data.advisor;
        } else {
            throw new Error(data.message || 'Failed to fetch advisor information');
        }
    } catch (error) {
        console.error('Error fetching advisor information:', error);
        return null;
    }
}

function formatDate(dateString) {
    const options = { year: 'numeric', month: 'long', day: 'numeric' };
    return new Date(dateString).toLocaleDateString('en-US', options);
}

function getFullName(data) {
    if (!data) return 'Name not available';
    
    let fullName = data.FirstName || '';
    
    if (data.MiddleName) {
        fullName += ' ' + data.MiddleName;
    }
    
    if (data.LastName) {
        fullName += ' ' + data.LastName;
    }
    
    return fullName.trim() || 'Name not available';
}

function populateStudentProfile(data) {
    if (!data) {
        console.error('No student data available to populate profile');
        return;
    }

    const fullName = getFullName(data);
    
    const studentNameEl = document.getElementById('studentName');
    if (studentNameEl) studentNameEl.textContent = fullName;
    
    const studentIdEl = document.getElementById('studentId');
    if (studentIdEl) studentIdEl.textContent = `ID: ${data.PersonID || 'N/A'}`;
    
    const studentProgramEl = document.getElementById('studentProgram');
    if (studentProgramEl) studentProgramEl.textContent = `Program: ${data.program || 'N/A'}`;
    
    //profile pic
    const profilePic = data.profilePicture || 'assets/images/placeholder.jpg';
    
    const profilePictureEl = document.getElementById('profilePicture');
    if (profilePictureEl) profilePictureEl.src = profilePic;
    
    const mainProfilePictureEl = document.getElementById('mainProfilePicture');
    if (mainProfilePictureEl) mainProfilePictureEl.src = profilePic;

    const userNameEl = document.getElementById('userName');
    if (userNameEl) userNameEl.textContent = data.FirstName || 'User';
    
    const statusElement = document.getElementById('academicStatus');
    if (statusElement && data.academicStatus) {
        statusElement.textContent = data.academicStatus.charAt(0).toUpperCase() + data.academicStatus.slice(1);
        statusElement.classList.add(data.academicStatus.toLowerCase());
    }

    const cgpaEl = document.getElementById('cgpa');
    if (cgpaEl) cgpaEl.textContent = data.cgpa || 'N/A';
    
    const semesterEl = document.getElementById('semester');
    if (semesterEl) semesterEl.textContent = data.currentSemester || 'N/A';
    
    const creditsCompletedEl = document.getElementById('creditsCompleted');
    if (creditsCompletedEl) creditsCompletedEl.textContent = data.creditsCompleted || 'N/A';
    
    const creditsRemainingEl = document.getElementById('creditsRemaining');
    if (creditsRemainingEl) creditsRemainingEl.textContent = data.creditsRemaining || 'N/A';
  
    const emailEl = document.getElementById('email');
    if (emailEl) emailEl.textContent = data.Email || 'N/A';
    
    const phoneEl = document.getElementById('phone');
    if (phoneEl) phoneEl.textContent = formatPhoneNumber(data.PhoneNumber);
    
    const addressEl = document.getElementById('address');
    if (addressEl) addressEl.textContent = getFullAddress(data);
    
    const dobEl = document.getElementById('dob');
    if (dobEl) dobEl.textContent = data.DateOfBirth ? formatDate(data.DateOfBirth) : 'Not available';
    
    const nationalIdEl = document.getElementById('nationalId');
    if (nationalIdEl) nationalIdEl.textContent = data.NationalID || 'Not available';
    
    const nationalityEl = document.getElementById('nationality');
    if (nationalityEl) nationalityEl.textContent = data.Nationality || 'Not available';
}

//function to populate course records table
function populateCourseRecords(courses) {
    const tableBody = document.getElementById('courseRecords');
    if (!tableBody) return;
    
    if (!courses || courses.length === 0) {
        tableBody.innerHTML = '<tr><td colspan="5">No course records available</td></tr>';
        return;
    }
    
    tableBody.innerHTML = '';
    
    courses.forEach(course => {
        const row = document.createElement('tr');
        
        const codeCell = document.createElement('td');
        codeCell.textContent = course.code || course.course_code || 'N/A';
        
        const nameCell = document.createElement('td');
        nameCell.textContent = course.name || course.course_name || 'N/A';
        
        const creditsCell = document.createElement('td');
        creditsCell.textContent = course.credits || 'N/A';
        
        const gradeCell = document.createElement('td');
        gradeCell.textContent = course.grade || 'N/A';
        
        const semesterCell = document.createElement('td');
        semesterCell.textContent = course.semester || 'N/A';
        
        row.appendChild(codeCell);
        row.appendChild(nameCell);
        row.appendChild(creditsCell);
        row.appendChild(gradeCell);
        row.appendChild(semesterCell);
        
        tableBody.appendChild(row);
    });
}

function populateSemesterSelect(courses) {
    const semesterSelect = document.getElementById('semesterSelect');
    if (!semesterSelect) return;
    
    if (!courses || courses.length === 0) {
        return;
    }
    
    while (semesterSelect.options.length > 1) {
        semesterSelect.remove(1);
    }
    
    const semesters = [...new Set(courses.map(course => course.semester))];
    
    semesters.sort((a, b) => a - b);
    
    semesters.forEach(semester => {
        const option = document.createElement('option');
        option.value = semester;
        option.textContent = `Semester ${semester}`;
        semesterSelect.appendChild(option);
    });
    
    //add event listener to filter courses by semester
    semesterSelect.addEventListener('change', () => {
        const selectedSemester = semesterSelect.value;
        
        if (selectedSemester === 'all') {
            populateCourseRecords(courses);
        } else {
            const filteredCourses = courses.filter(course => course.semester.toString() === selectedSemester);
            populateCourseRecords(filteredCourses);
        }
    });
}

function populateDeadlines(deadlines) {
    const deadlinesList = document.getElementById('deadlinesList');
    if (!deadlinesList) return;
    
    if (!deadlines || deadlines.length === 0) {
        deadlinesList.innerHTML = '<li>No upcoming deadlines</li>';
        return;
    }
    
    deadlinesList.innerHTML = '';
    
    deadlines.sort((a, b) => new Date(a.date) - new Date(b.date));
    
    deadlines.forEach(deadline => {
        const li = document.createElement('li');
        
        const dateSpan = document.createElement('div');
        dateSpan.className = 'deadline-date';
        dateSpan.textContent = formatDate(deadline.date);
        
        const titleSpan = document.createElement('div');
        titleSpan.className = 'deadline-title';
        titleSpan.textContent = deadline.title;
        
        const courseSpan = document.createElement('div');
        courseSpan.className = 'deadline-course';
        courseSpan.textContent = deadline.course;
        
        li.appendChild(dateSpan);
        li.appendChild(titleSpan);
        li.appendChild(courseSpan);
        
        deadlinesList.appendChild(li);
    });
}


function populateAdvisorInfo(advisor) {
    if (!advisor) return;
    
    const advisorNameEl = document.getElementById('advisorName');
    if (advisorNameEl) advisorNameEl.textContent = advisor.name || advisor.full_name || 'N/A';
    
    const advisorDepartmentEl = document.getElementById('advisorDepartment');
    if (advisorDepartmentEl) advisorDepartmentEl.textContent = advisor.department || 'N/A';
    
    const advisorEmailEl = document.getElementById('advisorEmail');
    if (advisorEmailEl) advisorEmailEl.textContent = advisor.email || 'N/A';
    
    const advisorOfficeEl = document.getElementById('advisorOffice');
    if (advisorOfficeEl) advisorOfficeEl.textContent = advisor.office || advisor.office_location || 'N/A';
    
    const advisorPictureEl = document.getElementById('advisorPicture');
    if (advisorPictureEl) advisorPictureEl.src = advisor.picture || advisor.profile_picture || 'assets/images/placeholder.jpg';
}

function setupProfilePictureUpload() {
    const editProfilePicture = document.querySelector('.edit-profile-picture');
    if (!editProfilePicture) return;
    
    editProfilePicture.addEventListener('click', () => {
        const fileInput = document.createElement('input');
        fileInput.type = 'file';
        fileInput.accept = 'image/*';
        
        fileInput.addEventListener('change', async (e) => {
            if (e.target.files.length > 0) {
                const file = e.target.files[0];
                
                if (file.size > 5 * 1024 * 1024) {
                    alert('File size exceeds 5MB. Please choose a smaller image.');
                    return;
                }
                
                const formData = new FormData();
                formData.append('profile_picture', file);
                
                try {
 
                    const profilePicture = document.getElementById('mainProfilePicture');
                    if (profilePicture) {
                        profilePicture.style.opacity = '0.5';
                    }
                    
                    const response = await fetch('uploadProfilePicture.php', {
                        method: 'POST',
                        body: formData
                    });
                    
                    const data = await response.json();
                    
                    if (data.success) {
                        document.querySelectorAll('#profilePicture, #mainProfilePicture').forEach(img => {
                            img.src = data.image_url + '?t=' + new Date().getTime(); // add timestamp to prevent caching
                        });
                        
                        alert('Profile picture updated successfully');
                    } else {
                        alert(data.message || 'Failed to upload profile picture');
                    }
                } catch (error) {
                    console.error('Error uploading profile picture:', error);
                    alert('An error occurred while uploading your profile picture');
                } finally {
                    //reset opacity
                    const profilePicture = document.getElementById('mainProfilePicture');
                    if (profilePicture) {
                        profilePicture.style.opacity = '1';
                    }
                }
            }
        });
        
        fileInput.click();
    });
}

function initializeGPAChart(semesterGPA) {
    const canvas = document.getElementById('gpaChart');
    if (!canvas) return;
    
    const ctx = canvas.getContext('2d');
    
    if (!semesterGPA || semesterGPA.length === 0) {
        const noDataText = 'No GPA data available';
        ctx.font = '16px Arial';
        ctx.fillStyle = '#888';
        ctx.textAlign = 'center';
        ctx.fillText(noDataText, canvas.width / 2, canvas.height / 2);
        return;
    }
    
    const labels = semesterGPA.map((_, index) => `Semester ${index + 1}`);
    
    if (window.gpaChartInstance) {
        window.gpaChartInstance.destroy();
    }
    
    window.gpaChartInstance = new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'GPA',
                data: semesterGPA,
                backgroundColor: 'rgba(26, 115, 232, 0.2)',
                borderColor: 'rgba(26, 115, 232, 1)',
                borderWidth: 2,
                pointBackgroundColor: 'rgba(26, 115, 232, 1)',
                pointRadius: 4,
                tension: 0.1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: false,
                    min: Math.min(...semesterGPA) - 0.5 < 0 ? 0 : Math.min(...semesterGPA) - 0.5,
                    max: 4.0,
                    ticks: {
                        stepSize: 0.5
                    }
                }
            },
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    callbacks: {
                        title: function(tooltipItems) {
                            return tooltipItems[0].label;
                        },
                        label: function(context) {
                            return `GPA: ${context.parsed.y.toFixed(2)}`;
                        }
                    }
                }
            }
        }
    });
}

document.addEventListener('DOMContentLoaded', async () => {
    try {

        document.querySelectorAll('.loading-placeholder').forEach(el => {
            el.style.display = 'block';
        });
        
        const [studentData, courses, semesterGPA, deadlines, advisor] = await Promise.all([
            fetchStudentData(),
            fetchCourseRecords(),
            fetchSemesterGPA(),
            fetchDeadlines(),
            fetchAdvisorInfo()
        ]);
        

        document.querySelectorAll('.loading-placeholder').forEach(el => {
            el.style.display = 'none';
        });
        
    
        if (studentData) {
            populateStudentProfile(studentData);
        }
        
        if (courses && courses.length > 0) {
            populateCourseRecords(courses);
            populateSemesterSelect(courses);
        }
        
        if (semesterGPA && semesterGPA.length > 0) {
            initializeGPAChart(semesterGPA);
        }
        
        if (deadlines && deadlines.length > 0) {
            populateDeadlines(deadlines);
        }
        
        if (advisor) {
            populateAdvisorInfo(advisor);
        }
        
   
        setupProfilePictureUpload();
        
        const editButton = document.querySelector('.personal-info .edit-btn');
        if (editButton) {
            editButton.addEventListener('click', () => {
                window.location.href = 'edit-profile.php';
            });
        }
        
        const downloadButton = document.querySelector('.profile-actions .secondary-btn');
        if (downloadButton) {
            downloadButton.addEventListener('click', () => {
                window.location.href = 'generate-transcript.php';
            });
        }
        
    } catch (error) {
        console.error('Error initializing profile:', error);
        alert('An error occurred while loading the profile. Please try again later.');
    }
});