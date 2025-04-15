document.addEventListener('DOMContentLoaded', () => {
    initializeNavbar();
});

function initializeNavbar() {
    const role = localStorage.getItem('userRole')?.toLowerCase();
    
    if (role === 'teacher') {
        document.querySelector('.teacher-nav').style.display = 'flex';
        setActiveNavLink('teacher-dashboard.html');
    } else if (role === 'student') {
        document.querySelector('.student-nav').style.display = 'flex';
        setActiveNavLink('dashboard.html');
    }
    
    const logoutBtn = document.querySelector('.logout-btn');
    if (logoutBtn) {
        logoutBtn.addEventListener('click', (e) => {
            e.preventDefault();
            localStorage.clear();
            window.location.href = 'login.html';
        });
    }
}

function setActiveNavLink(currentPage) {
    const navLinks = document.querySelectorAll('.nav-links a');
    const pageName = currentPage.split('/').pop() || currentPage;
    
    navLinks.forEach(link => {
        const linkPage = link.getAttribute('href').split('/').pop();
        if (pageName === linkPage) {
            link.classList.add('active');
        } else {
            link.classList.remove('active');
        }
    });
}