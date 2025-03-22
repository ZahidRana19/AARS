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

const searchInput = document.createElement('input');
searchInput.type = 'text';
searchInput.placeholder = 'Search for courses...';
searchInput.style.position = 'absolute';
searchInput.style.top = '50%';
searchInput.style.left = '50%';
searchInput.style.transform = 'translate(-50%, -50%)';
searchInput.style.padding = '1rem 2rem';
searchInput.style.width = '80%';
searchInput.style.maxWidth = '400px';
searchInput.style.borderRadius = '30px';
searchInput.style.border = 'none';
searchInput.style.boxShadow = '0 5px 20px rgba(0, 0, 0, 0.1)';
searchInput.style.fontSize = '1rem';
searchInput.style.display = 'none';
searchInput.style.zIndex = '10';

const searchResults = document.createElement('div');
searchResults.style.position = 'absolute';
searchResults.style.top = '60%';
searchResults.style.left = '50%';
searchResults.style.transform = 'translateX(-50%)';
searchResults.style.width = '80%';
searchResults.style.maxWidth = '400px';
searchResults.style.background = 'white';
searchResults.style.borderRadius = '10px';
searchResults.style.boxShadow = '0 10px 30px rgba(0, 0, 0, 0.15)';
searchResults.style.padding = '1rem';
searchResults.style.display = 'none';
searchResults.style.zIndex = '10';

document.body.appendChild(searchInput);
document.body.appendChild(searchResults);

const mockCourses = [
    "CS101: Introduction to Computer Science",
    "MATH220: Calculus I",
    "PHYS150: Physics for Engineers",
    "BIO240: Molecular Biology",
    "ECON305: Microeconomics"
];

searchInput.addEventListener('keyup', function() {
    if (this.value.length > 0) {
        searchResults.style.display = 'block';
        searchResults.innerHTML = '';
        
        const filteredCourses = mockCourses.filter(course => 
            course.toLowerCase().includes(this.value.toLowerCase())
        );
        
        if (filteredCourses.length > 0) {
            filteredCourses.forEach(course => {
                const courseItem = document.createElement('div');
                courseItem.textContent = course;
                courseItem.style.padding = '0.8rem';
                courseItem.style.borderBottom = '1px solid #eee';
                courseItem.style.cursor = 'pointer';
                courseItem.style.transition = 'background 0.2s ease';
                
                courseItem.addEventListener('mouseenter', function() {
                    this.style.background = '#f5f5f5';
                });
                
                courseItem.addEventListener('mouseleave', function() {
                    this.style.background = 'transparent';
                });
                
                courseItem.addEventListener('click', function() {
                    alert(`You selected: ${course}`);
                    searchInput.value = '';
                    searchResults.style.display = 'none';
                });
                
                searchResults.appendChild(courseItem);
            });
        } else {
            const noResults = document.createElement('div');
            noResults.textContent = 'No courses found';
            noResults.style.padding = '0.8rem';
            noResults.style.color = '#999';
            searchResults.appendChild(noResults);
        }
    } else {
        searchResults.style.display = 'none';
    }
});

document.querySelector('.primary-btn').addEventListener('click', function(e) {
    e.preventDefault();
    searchInput.style.display = 'block';
    searchInput.focus();
    
    const closeSearch = document.createElement('button');
    closeSearch.textContent = '×';
    closeSearch.style.position = 'absolute';
    closeSearch.style.top = '50%';
    closeSearch.style.right = '10%';
    closeSearch.style.transform = 'translateY(-50%)';
    closeSearch.style.background = 'none';
    closeSearch.style.border = 'none';
    closeSearch.style.fontSize = '2rem';
    closeSearch.style.cursor = 'pointer';
    closeSearch.style.color = '#999';
    closeSearch.style.zIndex = '11';
    
    closeSearch.addEventListener('click', function() {
        searchInput.style.display = 'none';
        searchResults.style.display = 'none';
        this.remove();
    });
    
    document.body.appendChild(closeSearch);
});
