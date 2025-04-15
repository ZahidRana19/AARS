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
    const pendingList = document.querySelector('.pending-list');
    const pendingCount = document.querySelector('.pending-count');
    const departmentFilter = document.getElementById('department-filter');

    // let debugMode = false;

    async function fetchDepartments() {
        try {
            const response = await fetch('../php/Request_Course/get_departments.php');
            if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
            return await response.json();
        } catch (error) {
            console.error('Error fetching departments:', error);
            if (debugMode) alert(`Department fetch error: ${error.message}`);
            return [];
        }
    }

    async function fetchCourseRequests(department = 'all') {
        try {
            const url = department === 'all' 
                ? '../php/Request_Course/get_pending_requests.php' 
                : `../php/Request_Course/get_pending_requests.php?department=${department}`;
            
            const response = await fetch(url);
            if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
            
            const data = await response.json();
            return data; 
            
        } catch (error) {
            console.error('Error fetching course requests:', error);
            if (debugMode) alert(`Request fetch error: ${error.message}`);
            return [];
        }
    }

    async function processRequestDecision(courseCode, sectionNo, teacherId, action) {
        try {
            const response = await fetch('../php/Request_Course/handle_admin_decision.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    decision: action,
                    course_code: courseCode,
                    section_no: sectionNo,
                    teacher_id: teacherId
                })
            });

            if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
            return await response.json();
        } catch (error) {
            console.error('Error processing request:', error);
            if (debugMode) alert(`Decision processing error: ${error.message}`);
            return { 
                status: 'error', 
                message: 'Failed to process request',
                error_details: error.message
            };
        }
    }

    async function renderRequests(filterDepartment = 'all') {
        pendingList.innerHTML = '<tr><td colspan="6"><div class="loading-spinner"></div> Loading requests...</td></tr>';
        
        try {
            const requests = await fetchCourseRequests(filterDepartment);
            
            if (requests.length === 0) {
                pendingList.innerHTML = '<tr><td colspan="6" class="no-requests">No pending requests found</td></tr>';
                pendingCount.textContent = '0';
                return;
            }
            
            pendingList.innerHTML = '';
            pendingCount.textContent = requests.length;
            
            requests.forEach(request => {
                const tr = document.createElement('tr');
                tr.dataset.course = request.course_code;
                tr.dataset.section = request.section_no;
                tr.dataset.teacher = request.teacher_id;
                
                tr.innerHTML = `
                    <td>${request.facultyName}</td>
                    <td>${request.course_code}</td>
                    <td>${request.course_title}</td>
                    <td>${request.department}</td>
                    <td>${request.section_no}</td>
                    <td>
                        <div class="action-buttons">
                            <button class="btn btn-approve" 
                                    data-id="${request.course_code}"
                                    data-section="${request.section_no}"
                                    data-teacher="${request.teacher_id}">
                                <i class="fas fa-check"></i> Approve
                            </button>
                            <button class="btn btn-reject"
                                    data-id="${request.course_code}"
                                    data-section="${request.section_no}"
                                    data-teacher="${request.teacher_id}">
                                <i class="fas fa-times"></i> Decline
                            </button>
                        </div>
                    </td>
                `;
                pendingList.appendChild(tr);
            });
            
            addButtonListeners();
        } catch (error) {
            pendingList.innerHTML = '<tr><td colspan="6" class="error-message">Error loading requests. Please try again.</td></tr>';
            console.error('Error:', error);
            if (debugMode) alert(`Render error: ${error.message}`);
        }
    }

    async function handleRequestAction(courseCode, sectionNo, teacherId, action) {
        const confirmation = confirm(`Are you sure you want to ${action} this request for ${courseCode} section ${sectionNo}?`);
        if (!confirmation) return;
        
        const buttons = document.querySelectorAll(`.btn-${action === 'approve' ? 'approve' : 'reject'}`);
        buttons.forEach(btn => {
            if (btn.dataset.id === courseCode && btn.dataset.section === sectionNo) {
                btn.disabled = true;
                btn.innerHTML = `<i class="fas fa-spinner fa-spin"></i> Processing...`;
            }
        });

        try {
            const result = await processRequestDecision(courseCode, sectionNo, teacherId, action);
            
            if (result.status === 'success') {
                const row = document.querySelector(`tr[data-course="${courseCode}"][data-section="${sectionNo}"]`);
                if (row) row.remove();
                
                pendingCount.textContent = parseInt(pendingCount.textContent) - 1;
                
                showNotification(`Request ${action}d successfully!`, 'success');
            } else {
                showNotification(`Failed to ${action} request: ${result.message || 'Unknown error'}`, 'error');
                console.error('Error details:', result.error_details || 'No details');
            }
        } catch (error) {
            console.error('Network error:', error);
            showNotification('An error occurred while processing the request', 'error');
        } finally {
            buttons.forEach(btn => {
                if (btn.dataset.id === courseCode && btn.dataset.section === sectionNo) {
                    btn.disabled = false;
                    btn.innerHTML = action === 'approve' 
                        ? '<i class="fas fa-check"></i> Approve' 
                        : '<i class="fas fa-times"></i> Decline';
                }
            });
        }
    }

    function addButtonListeners() {
        document.querySelectorAll('.btn-approve').forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.stopPropagation();
                const courseCode = btn.dataset.id;
                const sectionNo = btn.dataset.section;
                const teacherId = btn.dataset.teacher;
                handleRequestAction(courseCode, sectionNo, teacherId, 'approve');
            });
        });

        document.querySelectorAll('.btn-reject').forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.stopPropagation();
                const courseCode = btn.dataset.id;
                const sectionNo = btn.dataset.section;
                const teacherId = btn.dataset.teacher;
                handleRequestAction(courseCode, sectionNo, teacherId, 'decline');
            });
        });
    }

    function showNotification(message, type = 'info') {
        const notification = document.createElement('div');
        notification.className = `notification ${type}`;
        notification.textContent = message;
        document.body.appendChild(notification);
        
        setTimeout(() => {
            notification.classList.add('fade-out');
            setTimeout(() => notification.remove(), 500);
        }, 3000);
    }

    async function initDepartmentFilter() {
        try {
            const departments = await fetchDepartments();
            departmentFilter.innerHTML = '<option value="all">All Departments</option>';
            
            departments.forEach(dept => {
                const option = document.createElement('option');
                option.value = dept.DeptID;
                option.textContent = dept.DeptName;
                departmentFilter.appendChild(option);
            });
        } catch (error) {
            console.error('Error initializing department filter:', error);
            if (debugMode) alert(`Filter init error: ${error.message}`);
        }
    }

    departmentFilter.addEventListener('change', () => {
        renderRequests(departmentFilter.value);
    });

    window.toggleDebugMode = () => {
        debugMode = !debugMode;
        console.log(`Debug mode ${debugMode ? 'enabled' : 'disabled'}`);
    };

    (async function init() {
        await initDepartmentFilter();
        await renderRequests();
    })();
});