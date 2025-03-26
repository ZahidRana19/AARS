document.addEventListener('DOMContentLoaded', function() { //tab switching 
    const tabButtons = document.querySelectorAll('.tab-btn');
    const forms = document.querySelectorAll('.form');
    
    tabButtons.forEach(button => {
        button.addEventListener('click', function() {
            tabButtons.forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');
            
            forms.forEach(form => form.classList.remove('active'));
            const formId = this.getAttribute('data-form') + '-form';
            document.getElementById(formId).classList.add('active');
        });
    });

    const passwordInput = document.getElementById('signup-password');
    const meterSegments = document.querySelectorAll('.meter-segment');
    const strengthText = document.querySelector('.strength-text');
    
    if (passwordInput) {
        passwordInput.addEventListener('input', function() {
            const password = this.value;
            const strength = checkPasswordStrength(password);
   
            meterSegments.forEach(segment => {
                segment.classList.remove('weak', 'medium', 'strong');
            });
            
            if (password.length > 0) {
                if (strength === 'weak') {
                    meterSegments[0].classList.add('weak');
                    strengthText.textContent = 'Weak password';
                } else if (strength === 'medium') {
                    meterSegments[0].classList.add('medium');
                    meterSegments[1].classList.add('medium');
                    strengthText.textContent = 'Medium password';
                } else if (strength === 'strong') {
                    meterSegments[0].classList.add('strong');
                    meterSegments[1].classList.add('strong');
                    meterSegments[2].classList.add('strong');
                    strengthText.textContent = 'Strong password';
                } else if (strength === 'very-strong') {
                    meterSegments.forEach(segment => segment.classList.add('strong'));
                    strengthText.textContent = 'Very strong password';
                }
            } else {
                strengthText.textContent = 'Password strength';
            }
        });
    }

    const loginForm = document.getElementById('login-form');
    const signupForm = document.getElementById('signup-form');
    
    if (loginForm) {
        loginForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const identifier = document.getElementById('login-identifier').value;
            const password = document.getElementById('login-password').value;
            
            if (validateLoginForm(identifier, password)) {
                // here you would  send the form data to the database
                showNotification('Logging in...', 'success');

                setTimeout(() => {
                    window.location.href = '#dashboard'; 
                }, 1500);
            }
        });
    }
    
    if (signupForm) {
        signupForm.addEventListener('submit', async function(e) {
            e.preventDefault();
            const formData = new FormData(this);

            if (!validateSignupForm(this)) {
                return;
            }
            
            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.disabled = true;
    
            try {
                const response = await fetch('../php/signup.php', {
                    method: 'POST',
                    body: formData
                });
    
                const result = await response.json();
    
                if (result.success) {
                    showNotification('Creating your account...', 'info');
                    if (result.redirect) {
                        setTimeout(() => {
                            showNotification(result.message, 'success');
                            setTimeout(() => {
                                window.location.href = result.redirect;
                            }, 500);
                        }, 1500);
                    }
                } else {
                    if (result.isValidationError) {
                        showNotification(result.message, 'error', 5000);
                        
                        if (result.duplicateFields) {
                            document.querySelectorAll('.error-input').forEach(el => {
                                el.classList.remove('error-input');
                            });
                            
                            // Highlight errors
                            result.duplicateFields.forEach(field => {
                                const input = this.querySelector(`[name="${field}"]`);
                                if (input) {
                                    input.classList.add('error-input');
                                    if (field === 'phone_number') {
                                        input.value = input.value.replace(/^0+/, '');
                                    }
                                    if (result.duplicateFields[0] === field) {
                                        input.focus();
                                    }
                                }
                            });
                        }
                    } else {
                        showNotification(result.message || 'Signup failed', 'error');
                    }
                }
            } catch (error) {
                showNotification('Network error. Please try again.', 'error');
                console.error('Fetch error:', error);
            } finally {
                submitBtn.disabled = false;
            }
        });
    }
});

function togglePassword(inputId) {
    const passwordInput = document.getElementById(inputId);
    const icon = passwordInput.nextElementSibling.querySelector('i');
    
    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
    } else {
        passwordInput.type = 'password';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
    }
}

function checkPasswordStrength(password) {
    if (!password) return '';
    
    const hasLowerCase = /[a-z]/.test(password);
    const hasUpperCase = /[A-Z]/.test(password);
    const hasNumbers = /\d/.test(password);
    const hasSpecialChars = /[!@#$%^&*(),.?":{}|<>]/.test(password);
    
    const criteriaCount = [hasLowerCase, hasUpperCase, hasNumbers, hasSpecialChars].filter(Boolean).length;
    
    if (password.length < 6) return 'weak';
    if (password.length < 8) return 'medium';
    
    if (criteriaCount === 4 && password.length >= 10) return 'very-strong';
    if (criteriaCount >= 3) return 'strong';
    if (criteriaCount >= 2) return 'medium';
    
    return 'weak';
}

function validateLoginForm(identifier, password) {
    let isValid = true;
    let email;

    const isEmail = identifier.includes('@');
    
    if (isEmail) {
        email = identifier;

        if (!isValidEmail(email)) {
            showNotification('Please enter a valid email address', 'error');
            isValid = false;
        }
    } else {
        username = identifier;
    }
    
    return isValid;
}

function validateSignupForm(form) {
    let isValid = true;
    const values = Object.fromEntries(new FormData(form).entries());
    
    if (values.first_name.length < 2 || values.last_name < 2) {
        showNotification('Name cannot be a single letter', 'error');
        isValid = false;
    }
    
    if (values.username.length < 3) {
        showNotification('Please enter a valid username', 'error');
        isValid = false;
    }

    if (values.phone_number.length < 11 || values.phone_number.length > 11) {
        showNotification('Please enter a valid phone number (11 digits)', 'error');
        isValid = false;
    }
    
    if (!isValidEmail(values.email) || !values.email.endsWith('.edu')) {
        showNotification('Please enter a valid university email address (.edu)', 'error');
        isValid = false;
    }
    
    if (checkPasswordStrength(values.password) === 'weak') {
        showNotification('Please choose a stronger password', 'error');
        isValid = false;
    }

    if(values.password != values.confirm_password) {
        showNotification('Password does not match!', 'error');
        isValid = false;
    }

    if(!isValidRegCode(values.reg_code)) {
        showNotification('Please enter a valid Registration Code', 'error');
        isValid = false;
    }
    
    return isValid;
}

function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

function isValidRegCode(reg_code) {
    // 7-character pattern: T...s with at least 2 numbers (Student)
    const pattern7 = /^T(?=.*[0-9].*[0-9])[A-Za-z0-9]{5}s$/;
    
    // 9-character pattern: R...t with at least 2 numbers (Teacher)
    const pattern9 = /^R(?=.*[0-9].*[0-9])[A-Za-z0-9]{7}t$/;
    
    return pattern7.test(reg_code) || pattern9.test(reg_code);
}

function showNotification(message, type = 'info') {
    let notification = document.querySelector('.notification');
    
    if (!notification) {

        notification = document.createElement('div');
        notification.className = 'notification';
        document.body.appendChild(notification);

        notification.style.position = 'fixed';
        notification.style.bottom = '20px';
        notification.style.right = '20px';
        notification.style.padding = '15px 25px';
        notification.style.borderRadius = '5px';
        notification.style.boxShadow = '0 4px 12px rgba(0, 0, 0, 0.15)';
        notification.style.zIndex = '1000';
        notification.style.transition = 'all 0.3s ease';
        notification.style.transform = 'translateY(20px)';
        notification.style.opacity = '0';
    }

    if (type === 'success') {
        notification.style.backgroundColor = '#28a745';
        notification.style.color = 'white';
    } else if (type === 'error') {
        notification.style.backgroundColor = '#dc3545';
        notification.style.color = 'white';
    } else {
        notification.style.backgroundColor = '#f8f9fa';
        notification.style.color = '#333';
    }
    
    notification.textContent = message;
 
    setTimeout(() => {
        notification.style.transform = 'translateY(0)';
        notification.style.opacity = '1';
    }, 10);

    setTimeout(() => {
        notification.style.transform = 'translateY(20px)';
        notification.style.opacity = '0';
        setTimeout(() => {
            if (notification.parentNode) {
                notification.parentNode.removeChild(notification);
            }
        }, 300);
    }, 3000);
}
