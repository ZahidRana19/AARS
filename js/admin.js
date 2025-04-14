// Admin Dashboard Functionality

document.addEventListener('DOMContentLoaded', () => {
    // Mock data - Replace with actual API calls
    const pendingRequests = [
        {
            name: "Ayman Rafid",
            email: "ayman@northsouth.edu",
            role: "Student",
            department: "Computer Science"
        },
        {
            name: "Iqditer",
            email: "Iqditer@northsouth.edu",
            role: "Faculty",
            department: "Engineering"
        }
    ];

    const pendingList = document.querySelector('.pending-list');
    const pendingCount = document.querySelector('.pending-count');

    // Render pending requests
    function renderRequests() {
        pendingList.innerHTML = '';
        pendingCount.textContent = pendingRequests.length;
        
        pendingRequests.forEach((request, index) => {
            const li = document.createElement('li');
            li.className = 'pending-item';
            li.innerHTML = `
                <div>
                    <h3>${request.name}</h3>
                    <p>${request.email} · ${request.department}</p>
                </div>
                <div class="approval-actions">
                    <button class="auth-btn approve-btn" data-index="${index}">Approve</button>
                    <button class="auth-btn reject-btn" data-index="${index}">Reject</button>
                </div>
            `;
            pendingList.appendChild(li);
        });

        addButtonListeners();
    }

    // Handle approval actions
    function handleApproval(index, approved) {
        const request = pendingRequests[index];
        if(approved) {
            console.log('Approving:', request);
            // Add actual approval logic here
        } else {
            console.log('Rejecting:', request);
            // Add actual rejection logic here
        }
        
        pendingRequests.splice(index, 1);
        renderRequests();
    }

    // Add event listeners to buttons
    function addButtonListeners() {
        document.querySelectorAll('.approve-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                const index = btn.dataset.index;
                handleApproval(index, true);
            });
        });

        document.querySelectorAll('.reject-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                const index = btn.dataset.index;
                handleApproval(index, false);
            });
        });
    }

    // Initialize logout functionality from dashboard.js
    function initializeLogout() {
        const logoutBtn = document.querySelector('.logout-btn');
        if (logoutBtn) {
            logoutBtn.addEventListener('click', (e) => {
                e.preventDefault();
                localStorage.clear();
                window.location.href = 'login.html';
            });
        }
    }

    // Initial setup
    renderRequests();
    initializeLogout();
});