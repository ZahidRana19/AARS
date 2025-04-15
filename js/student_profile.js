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

let profileData;

async function fetchStudentData() {
    try {
        const response = await fetch('../php/Profile/student_profile.php');
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        const data = await response.json();
        
        if (data.success) {
            return data;
        } else {
            throw new Error(data.message || 'Failed to fetch student data');
        }
    } catch (error) {
        console.error('Error fetching student data:', error);
        alert('Failed to load student data. Please refresh the page or contact support.');
        return null;
    }
}

function populateStudentProfile(data) {
    if (!data || !data.student) {
        console.error('No student data available to populate profile');
        return;
    }

    profileData = data;

    // Personal Information
    document.getElementById('firstName').value = data.student.FirstName || 'N/A';
    document.getElementById('middleName').value = data.student.MiddleName || 'N/A';
    document.getElementById('lastName').value = data.student.LastName || 'N/A';
    document.getElementById('email').value = data.student.Email || 'N/A';
    document.getElementById('phone').value = data.student.PhoneNumber || 'N/A';
    
    // Address Information
    document.getElementById('houseNumber').value = data.student.HouseNumber || 'N/A';
    document.getElementById('streetNumber').value = data.student.StreetNumber || 'N/A';
    document.getElementById('streetName').value = data.student.StreetName || 'N/A';
    document.getElementById('postalCode').value = data.student.PostalCode || 'N/A';

    //City
    if (data.student.PostalCode) {
        const postalCode = parseInt(data.student?.PostalCode);
        
        if ((postalCode >= 1000 && postalCode < 3000) || (postalCode >= 7700 && postalCode < 8200)) {
            document.getElementById('city').value = 'Dhaka';
        } else if (postalCode >= 3000 && postalCode < 3400) {
            document.getElementById('city').value = 'Sylhet';
        } else if (postalCode >= 3400 && postalCode < 5000) {
            document.getElementById('city').value = 'Chittagong';
        } else if (postalCode >= 5000 && postalCode < 5800) {
            document.getElementById('city').value = 'Rangpur';
        } else if (postalCode >= 5800 && postalCode < 7000) {
            document.getElementById('city').value = 'Rajshahi';
        } else if ((postalCode >= 7000 && postalCode < 7700) || (postalCode >= 9000 && postalCode < 9500)) {
            document.getElementById('city').value = 'Khulna';
        } else if (postalCode >= 8200 && postalCode < 9000) {
            document.getElementById('city').value = 'Barisal';
        } else {
            document.getElementById('city').value = 'Unknown';
        }
    } else {
        document.getElementById('city').value = 'N/A';
    }
    
    // Academic Information
    document.getElementById('departmentDisplay').textContent = data.student.Department || 'N/A';
    document.getElementById('majorDisplay').textContent = data.student.Major || 'N/A';
    
    // Profile Summary
    document.getElementById('studentName').textContent = 
        `${data.student.FirstName || ''} ${data.student.MiddleName || ''} ${data.student.LastName || ''}`.trim() || 'N/A';
    document.getElementById('studentId').textContent = `ID: ${data.student.StudentID || 'N/A'}`;
    document.getElementById('studentMajor').textContent = `Major: ${data.student.Major || 'N/A'}`;
    document.getElementById('studentDept').textContent = `Department: ${data.student.Department || 'N/A'}`;
    
    // Academic Summary
    document.getElementById('cgpa').textContent = data.student.CGPA ? data.student.CGPA.toFixed(2) : 'N/A';
}

function toggleEditMode() {
    const editBtn = document.querySelector('.edit-btn');
    
    // Remove any existing event listeners to prevent duplicates
    const newEditBtn = editBtn.cloneNode(true);
    editBtn.parentNode.replaceChild(newEditBtn, editBtn);
    
    // Checks if already in edit mode
    const isEditing = document.querySelector('.edit-actions') !== null;
    
    if (isEditing) {
        disableEditing();
        newEditBtn.classList.remove('editing');
    } else {
        enableEditing();
        newEditBtn.classList.add('editing');
    }
    
    newEditBtn.addEventListener('click', toggleEditMode);
}

function enableEditing() {
    const editableFields = [
        'phone', 'houseNumber', 'streetNumber', 'streetName', 'postalCode'
    ];
    
    editableFields.forEach(field => {
        const element = document.getElementById(field);
        if (element) {
            element.readOnly = false;
            element.classList.add('editable');
        }
    });
    
    // Dept Dropdown
    if (!profileData.student.Department && profileData.departments) {
        const dropdownHTML = `
            <select class="edit-input" id="departmentSelect">
                <option value="">Select Department</option>
                ${profileData.departments.map(dept => 
                    `<option value="${dept}">${dept}</option>`
                ).join('')}
            </select>
        `;
        document.getElementById('departmentDropdown').innerHTML = dropdownHTML;
        document.getElementById('departmentDropdown').style.display = 'block';
        document.getElementById('departmentDisplay').style.display = 'none';
        
        // Gets major after department is set
        document.getElementById('departmentSelect').addEventListener('change', async (e) => {
            const deptName = e.target.value;
            if (deptName) {
                try {
                    const response = await fetch(`../php/Profile/get_majors.php?department=${encodeURIComponent(deptName)}`);
                    const data = await response.json();
                    
                    if (data.success && data.majors.length > 0) {
                        const majorDropdown = document.getElementById('majorDropdown');
                        majorDropdown.innerHTML = `
                            <select class="edit-input" id="majorSelect">
                                <option value="">Select Major</option>
                                ${data.majors.map(major => 
                                    `<option value="${major}">${major}</option>`
                                ).join('')}
                            </select>
                        `;
                        majorDropdown.style.display = 'block';
                        document.getElementById('majorDisplay').style.display = 'none';
                    }
                } catch (error) {
                    console.error('Error fetching majors:', error);
                }
            }
        });
    }
    
    // Major dropdown
    if (profileData.student.Department && !profileData.student.Major && profileData.majors) {
        const dropdownHTML = `
            <select class="edit-input" id="majorSelect">
                <option value="">Select Major</option>
                ${profileData.majors.map(major => 
                    `<option value="${major}">${major}</option>`
                ).join('')}
            </select>
        `;
        document.getElementById('majorDropdown').innerHTML = dropdownHTML;
        document.getElementById('majorDropdown').style.display = 'block';
        document.getElementById('majorDisplay').style.display = 'none';
    }
    
    // save/cancel buttons
    const cardHeader = document.querySelector('.user-info .card-header');
    if (!document.querySelector('.edit-actions')) {
        cardHeader.innerHTML += `
            <div class="edit-actions">
                <button class="btn primary-btn small-btn" id="saveChanges">Save</button>
                <button class="btn secondary-btn small-btn" id="cancelChanges">Cancel</button>
            </div>
        `;
        
        document.getElementById('saveChanges').addEventListener('click', saveChanges);
        document.getElementById('cancelChanges').addEventListener('click', cancelChanges);
    }
}

function disableEditing() {
    const inputs = document.querySelectorAll('.info-value');
    inputs.forEach(input => {
        input.readOnly = true;
        input.classList.remove('editable');
    });
    
    document.getElementById('departmentDropdown').style.display = 'none';
    document.getElementById('departmentDisplay').style.display = 'block';
    document.getElementById('majorDropdown').style.display = 'none';
    document.getElementById('majorDisplay').style.display = 'block';
    
    const editActions = document.querySelector('.edit-actions');
    if (editActions) {
        editActions.remove();
    }
}

async function saveChanges() {
    try {
        const updates = {
            PhoneNumber: document.getElementById('phone').value,
            HouseNumber: document.getElementById('houseNumber').value,
            StreetNumber: document.getElementById('streetNumber').value,
            StreetName: document.getElementById('streetName').value,
            PostalCode: document.getElementById('postalCode').value
        };
        
        // Checks if department is already selected
        if (!profileData.student.Department) {
            const deptSelect = document.getElementById('departmentSelect');
            if (deptSelect) {
                updates.Department = deptSelect.value;
            }
        }
        
        // Checks if major is already selected
        if (profileData.student.Department && !profileData.student.Major) {
            const majorSelect = document.getElementById('majorSelect');
            if (majorSelect) {
                updates.Major = majorSelect.value;
            }
        }
        
        const response = await fetch('../php/Profile/edit_profile.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ updates })
        });
        
        const result = await response.json();
        
        if (result.success) {
            const newData = await fetchStudentData();
            populateStudentProfile(newData);
            toggleEditMode();
            alert('Profile updated successfully!');
        } else {
            if (result.message.includes('Phone number')) {
                document.getElementById('phone').classList.add('error-field');
                alert(result.message);
                throw new Error(result.message);
            } else {
                throw new Error(result.message || 'Failed to save changes');
            }
        }
    } catch (error) {
        console.error('Error saving changes:', error);
        alert('Failed to save changes: ' + error.message);
    }
}

function cancelChanges() {
    populateStudentProfile(profileData);
    disableEditing();
    
    const editBtn = document.querySelector('.edit-btn');
    editBtn.classList.remove('editing');
    
    editBtn.addEventListener('click', toggleEditMode);
}

document.addEventListener('DOMContentLoaded', async () => {
    try {
        const studentData = await fetchStudentData();
        if (studentData) {
            populateStudentProfile(studentData);
            
            const editBtn = document.querySelector('.edit-btn');
            if (editBtn) {
                editBtn.addEventListener('click', toggleEditMode);
            }
        }
        
        const downloadBtn = document.querySelector('.secondary-btn');
        if (downloadBtn) {
            downloadBtn.addEventListener('click', () => {
                window.location.href = '../php/Profile/generate_transcript.php';
            });
        }
        
    } catch (error) {
        console.error('Error initializing profile:', error);
        alert('An error occurred while loading the profile. Please try again later.');
    }
});