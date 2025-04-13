document.addEventListener('DOMContentLoaded', function() {
    const urlParams = new URLSearchParams(window.location.search);
    const token = urlParams.get('token');

    if (token) {
        document.getElementById('token').value = token;
    } else {
        showNotification('Invalid or expired password reset link.', 'error');
        setTimeout(() => {
            window.location.href = '../html/login.html';
        }, 3000);
    }
    
    const form = document.getElementById('reset-password-form');
    const newPasswordInput = document.getElementById('new-password');
    const confirmPasswordInput = document.getElementById('confirm-password');
    const requirementsList = document.querySelectorAll('#requirements-list li');
    const strengthMeter = document.querySelectorAll('.meter-segment');
    const strengthText = document.querySelector('.strength-text');
    
    //password requirement checks
    const requirements = {
        length: {
            element: document.getElementById('req-length'),
            validate: password => password.length >= 8
        },
        uppercase: {
            element: document.getElementById('req-uppercase'),
            validate: password => /[A-Z]/.test(password)
        },
        lowercase: {
            element: document.getElementById('req-lowercase'),
            validate: password => /[a-z]/.test(password)
        },
        number: {
            element: document.getElementById('req-number'),
            validate: password => /[0-9]/.test(password)
        },
        special: {
            element: document.getElementById('req-special'),
            validate: password => /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password)
        }
    };
    

    newPasswordInput.addEventListener('input', function() {
        const password = this.value;
        
        let metRequirements = 0;
        for (const key in requirements) {
            const req = requirements[key];
            const isMet = req.validate(password);

            if (isMet) {
                req.element.classList.add('met');
                req.element.classList.remove('unmet');
                metRequirements++;
            } else {
                req.element.classList.add('unmet');
                req.element.classList.remove('met');
            }
        }
        
        updatePasswordStrength(password, metRequirements);
        checkPasswordsMatch();
    });
    
    confirmPasswordInput.addEventListener('input', checkPasswordsMatch);
    
    form.addEventListener('submit', async function(e) {
        e.preventDefault();
        
        const newPassword = newPasswordInput.value;
        const confirmPassword = confirmPasswordInput.value;
        const token = document.getElementById('token').value;
        
        let allRequirementsMet = true;
        for (const key in requirements) {
            if (!requirements[key].validate(newPassword)) {
                allRequirementsMet = false;
                break;
            }
        }
        
        if (!allRequirementsMet) {
            showNotification('Your password does not meet all requirements.', 'error');
            return;
        }
        
        if (newPassword !== confirmPassword) {
            showNotification('Passwords do not match.', 'error');
            return;
        }
  
        const submitBtn = form.querySelector('.submit-btn');
        submitBtn.textContent = 'Processing...';
        submitBtn.disabled = true;
        
        try {
            //simulate API call - we need to work on THIS. THIS IS JUST A PLACEHOLDER.
            await resetPassword(token, newPassword);
            
            showNotification('Password has been reset successfully!', 'success');
            
            setTimeout(() => {
                window.location.href = '../html/login.html';
            }, 2000);
        } catch (error) {
     
            showNotification(error.message || 'An error occurred. Please try again.', 'error');
            
    
            submitBtn.textContent = 'Reset Password';
            submitBtn.disabled = false;
        }
    });
 
    function checkPasswordsMatch() {
        const newPassword = newPasswordInput.value;
        const confirmPassword = confirmPasswordInput.value;
        
        if (confirmPassword && newPassword !== confirmPassword) {
            confirmPasswordInput.style.borderColor = 'var(--error)';
        } else {
            confirmPasswordInput.style.borderColor = '';
        }
    }
    

    function updatePasswordStrength(password, metRequirements) {
        if (!password) {
            resetStrengthMeter();
            return;
        }
        
        let score = 0;
        
        score = Math.min(Math.floor(metRequirements), 4);
        
        if (password.length > 12) score = Math.min(score + 1, 4);
        
        for (let i = 0; i < strengthMeter.length; i++) {
            if (i < score) {
                strengthMeter[i].style.backgroundColor = getStrengthColor(score);
            } else {
                strengthMeter[i].style.backgroundColor = '#e0e0e0';
            }
        }
        
        strengthText.textContent = getStrengthText(score);
        strengthText.style.color = getStrengthColor(score);
    }

    function resetStrengthMeter() {
        strengthMeter.forEach(segment => {
            segment.style.backgroundColor = '#e0e0e0';
        });
        strengthText.textContent = 'Password strength';
        strengthText.style.color = '';
    }
    

    function getStrengthColor(score) {
        const colors = ['#e74c3c', '#e67e22', '#f1c40f', '#3498db', '#2ecc71'];
        return colors[score] || colors[0];
    }
 
    function getStrengthText(score) {
        const texts = ['Very weak', 'Weak', 'Moderate', 'Strong', 'Very strong'];
        return texts[score] || texts[0];
    }
    
    function showNotification(message, type) {
        const existingNotification = document.querySelector('.notification');
        if (existingNotification) {
            existingNotification.remove();
        }
        
        const notification = document.createElement('div');
        notification.className = `notification ${type}`;
        notification.textContent = message;
        
        document.body.appendChild(notification);
        
        setTimeout(() => {
            notification.style.opacity = '1';
            notification.style.transform = 'translateY(0)';
        }, 10);
        
        setTimeout(() => {
            notification.style.opacity = '0';
            notification.style.transform = 'translateY(20px)';
            
            setTimeout(() => {
                notification.remove();
            }, 300);
        }, 5000);
    }
    
    window.togglePassword = function(inputId) {
        const input = document.getElementById(inputId);
        const icon = input.nextElementSibling.querySelector('i');
        
        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    };
    
    //this function simulates an API call for password reset
    function resetPassword(token, newPassword) {
        return new Promise((resolve, reject) => {
            console.log(`Reset password with token: ${token} and new password: ${newPassword}`);
            
            setTimeout(() => {
                // 90% chance of success (for demo purposes)
                if (Math.random() < 0.9) {
                    resolve();
                } else {
                    reject(new Error('Failed to reset password. Please try again.'));
                }
            }, 1500);
        });
    }
});