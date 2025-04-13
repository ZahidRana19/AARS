document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('forgotPasswordForm');
    const submitBtn = form.querySelector('.submit-btn');
    const resultMessage = document.getElementById('resultMessage');
    
    form.addEventListener('submit', async function(e) {
        e.preventDefault();
        
        //getting form data here
        const email = document.getElementById('email').value;
        
        if (!isValidEmail(email)) {
            showMessage('Please enter a valid email address', 'error');
            return;
        }

        setLoadingState(true);
        
        try {
            // Simulate API call - PLACEHOLDER, PLEASE FIX 
            await simulateApiCall(email);
            
            showMessage('Password reset link has been sent to your email. Please check your inbox.', 'success');
            
            form.reset();
        } catch (error) {
            showMessage(error.message || 'An error occurred. Please try again later', 'error');
        } finally {
            setLoadingState(false);
        }
    });
    
    function isValidEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }
    
    function showMessage(message, type) {
        resultMessage.textContent = message;
        resultMessage.className = 'result-message ' + type;
        
        //hide error messages after 5 seconds
        if (type === 'error') {
            setTimeout(() => {
                resultMessage.className = 'result-message';
            }, 5000);
        }
    }
    
    function setLoadingState(isLoading) {
        if (isLoading) {
            submitBtn.classList.add('loading');
            submitBtn.disabled = true;
        } else {
            submitBtn.classList.remove('loading');
            submitBtn.disabled = false;
        }
    }
    
    //this function simulates an API call
    function simulateApiCall(email) {
        return new Promise((resolve, reject) => {
            setTimeout(() => {
                // 90% chance of success (for demo purposes)
                if (Math.random() < 0.9) {
                    resolve();
                } else {
                    reject(new Error('Server error. Please try again.'));
                }
            }, 1500); 
        });
    }
});