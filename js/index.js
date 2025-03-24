window.addEventListener('scroll', function() {
    const nav = document.querySelector('.nav-container');
    if (window.scrollY > 50) {
        nav.classList.add('nav-scrolled');
    } else {
        nav.classList.remove('nav-scrolled');
    }
});

const menuToggle = document.querySelector('.menu-toggle');
const mobileMenu = document.querySelector('.mobile-menu');
const closeMenu = document.querySelector('.close-menu');

menuToggle.addEventListener('click', function() {
    mobileMenu.classList.add('active');
});

closeMenu.addEventListener('click', function() {
    mobileMenu.classList.remove('active');
});

function animateCounter(elementId, target, duration) {
    const element = document.getElementById(elementId);
    const start = 0;
    const end = parseInt(target.replace(/\D/g, ''));
    const range = end - start;
    const increment = end > start ? 1 : -1;
    const stepTime = Math.abs(Math.floor(duration / range));
    let current = start;
    
    const timer = setInterval(function() {
        current += increment;
        element.textContent = current + '+';
        if (current === end) {
            clearInterval(timer);
            element.textContent = target;
        }
    }, stepTime);
}

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            animateCounter('studentCount', '15,000+', 2000);
            animateCounter('courseCount', '500+', 1500);
            animateCounter('facultyCount', '300+', 1500);
            animateCounter('satisfactionRate', '96%', 1000);
            observer.disconnect();
        }
    });
}, { threshold: 0.5 });

observer.observe(document.querySelector('.stats'));

const portalPreview = document.querySelector('.portal-preview');

document.addEventListener('mousemove', function(e) {
    if (window.innerWidth > 992) {
        const xAxis = (window.innerWidth / 2 - e.pageX) / 25;
        const yAxis = (window.innerHeight / 2 - e.pageY) / 25;
        portalPreview.style.transform = `perspective(1000px) rotateY(${xAxis}deg) rotateX(${yAxis}deg)`;
    }
});

portalPreview.addEventListener('mouseenter', function() {
    portalPreview.style.transition = 'none';
});

portalPreview.addEventListener('mouseleave', function() {
    portalPreview.style.transition = 'all 0.5s ease';
    portalPreview.style.transform = 'perspective(1000px) rotateY(-10deg) rotateX(5deg)';
});

const featureCards = document.querySelectorAll('.feature-card');

featureCards.forEach((card, index) => {
    card.style.opacity = '0';
    card.style.transform = 'translateY(50px)';
    card.style.transition = `all 0.5s ease ${index * 0.1}s`;
});

const featureObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, { threshold: 0.2 });

featureCards.forEach(card => {
    featureObserver.observe(card);
});
