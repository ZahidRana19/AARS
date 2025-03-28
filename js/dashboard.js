// dashboard.js - Universal Dashboard Functionality

document.addEventListener('DOMContentLoaded', () => {
    // Configuration 
    const userData = {
        role: localStorage.getItem('userRole') || 'student',
        name: localStorage.getItem('userName') || 'User',
        courses: JSON.parse(localStorage.getItem('courses')) || []
    };

    // Core Functions 
    const initializeDashboard = () => {
        // Common initialization
        setupAccessibility();
        initializeLogout();
        handleWelcomeMessage();
        setupStatsLoading();
        setupCourseInteractions();
        setupNavigation();

        // Role-specific initialization
        if (userData.role === 'teacher') {
            initializeTeacherFeatures();
        } else {
            initializeStudentFeatures();
        }

        setupPerformanceMonitoring();
    };

    //  Common Functionality 
    const setupAccessibility = () => {
        // Add aria-labels to interactive elements
        document.querySelectorAll('.course-card').forEach((card, index) => {
            card.setAttribute('aria-label', `Course ${index + 1} details`);
        });
    };

    const initializeLogout = () => {
        const logoutBtn = document.querySelector('.logout-btn');
        if (logoutBtn) {
            logoutBtn.addEventListener('click', (e) => {
                e.preventDefault();
                localStorage.clear();
                window.location.href = 'login.html';
            });
        }
    };

    const handleWelcomeMessage = () => {
        const welcomeHeading = document.querySelector('.welcome-section h1');
        if (welcomeHeading) {
            const rolePrefix = userData.role === 'teacher' ? 'Professor ' : '';
            welcomeHeading.textContent = `Welcome, ${rolePrefix}${userData.name}`;
            welcomeHeading.setAttribute('aria-label', `Welcome message for ${userData.name}`);
        }
    };

    const setupStatsLoading = () => {
        const loadingElements = document.querySelectorAll('.stat-card p');
        loadingElements.forEach(element => {
            if (element.textContent.toLowerCase().includes('loading')) {
                animateLoading(element);
            }
        });
    };

    const animateLoading = (element) => {
        let dots = 0;
        const interval = setInterval(() => {
            element.textContent = 'loading' + '.'.repeat(dots % 4);
            dots++;
            if (!element.textContent.toLowerCase().includes('loading')) {
                clearInterval(interval);
            }
        }, 500);
    };

    const setupCourseInteractions = () => {
        document.querySelectorAll('.course-card').forEach(card => {
            // Hover effects
            card.addEventListener('mouseenter', () => {
                card.style.transform = 'translateY(-5px)';
                card.style.boxShadow = '0 8px 20px rgba(0,0,0,0.15)';
            });

            card.addEventListener('mouseleave', () => {
                card.style.transform = 'translateY(0)';
                card.style.boxShadow = '0 4px 12px rgba(0,0,0,0.1)';
            });

            // Click handling
            card.addEventListener('click', function(e) {
                if (!e.target.closest('button')) {
                    this.classList.toggle('active');
                    const courseTitle = this.querySelector('h3').textContent;
                    console.log(`Toggled ${courseTitle} details`);
                }
            });
        });
    };

    const setupNavigation = () => {
        document.querySelectorAll('.nav-links a').forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                const page = link.textContent.toLowerCase();
                handleNavigation(page);
            });
        });
    };

    const handleNavigation = (page) => {
        console.log(`Navigating to: ${page}`);
        // Add actual navigation logic here
    };

    // Teacher-Specific Features 
    const initializeTeacherFeatures = () => {
        setupQuickActions();
        setupGradeSubmission();
        setupAttendanceReports();
    };

    const setupQuickActions = () => {
        document.querySelectorAll('.course-card button').forEach(button => {
            button.addEventListener('click', (e) => {
                e.stopPropagation();
                const card = e.target.closest('.course-card');
                const action = card.querySelector('h3').textContent;
                
                switch(action) {
                    case 'Post Announcement':
                        handleAnnouncement(card);
                        break;
                    case 'Grade Submission':
                        handleGradeSubmission(card);
                        break;
                    case 'Attendance Report':
                        generateAttendanceReport(card);
                        break;
                    default:
                        console.log(`Action triggered: ${action}`);
                }
            });
        });
    };

    const handleAnnouncement = (card) => {
        const courseId = card.querySelector('h3').textContent;
        console.log(`Posting announcement for ${courseId}`);
        // Implementation logic here
    };

    const handleGradeSubmission = (card) => {
        const courseId = card.querySelector('h3').textContent;
        console.log(`Submitting grades for ${courseId}`);
        // Implementation logic here
    };

    const generateAttendanceReport = (card) => {
        const courseId = card.querySelector('h3').textContent;
        console.log(`Generating report for ${courseId}`);
        // Implementation logic here
    };

    // ************** Student-Specific Features **************
    const initializeStudentFeatures = () => {
        setupCourseEnrollment();
        setupGradeTracking();
    };

    const setupCourseEnrollment = () => {
        // Add course enrollment logic here
    };

    const setupGradeTracking = () => {
        // Add grade tracking logic here
    };

    // Performance Monitoring 
    const setupPerformanceMonitoring = () => {
        window.addEventListener('load', () => {
            const loadTime = window.performance.timing.domContentLoadedEventEnd - 
                           window.performance.timing.navigationStart;
            console.log(`Dashboard loaded in ${loadTime}ms`);
        });

        window.addEventListener('beforeunload', () => {
            console.log('Dashboard unloading...');
        });
    };

    //  Initialize Dashboard 
    initializeDashboard();

    // Utility Functions
    function debounce(func, timeout = 300) {
        let timer;
        return (...args) => {
            clearTimeout(timer);
            timer = setTimeout(() => { func.apply(this, args); }, timeout);
        };
    }

    function throttle(func, limit = 100) {
        let lastFunc;
        let lastRan;
        return function(...args) {
            if (!lastRan) {
                func.apply(this, args);
                lastRan = Date.now();
            } else {
                clearTimeout(lastFunc);
                lastFunc = setTimeout(() => {
                    if ((Date.now() - lastRan) >= limit) {
                        func.apply(this, args);
                        lastRan = Date.now();
                    }
                }, limit - (Date.now() - lastRan));
            }
        };
    }

    // Window resize handler
    window.addEventListener('resize', debounce(() => {
        console.log('Window resized:', window.innerWidth, 'x', window.innerHeight);
    }));
});