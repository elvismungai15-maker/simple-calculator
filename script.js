let display = document.getElementById('display');

function appendNumber(number) {
    if (display.value === '0' && number !== '.') {
        display.value = number;
    } else if (number === '.' && display.value.includes('.')) {
        return;
    } else {
        display.value += number;
    }
}

function appendOperator(operator) {
    const lastChar = display.value[display.value.length - 1];
    
    // Prevent multiple operators in a row
    if (['+', '-', '*', '/', '%'].includes(lastChar)) {
        return;
    }
    
    if (display.value === '') {
        return;
    }
    
    display.value += operator;
}

function clearDisplay() {
    display.value = '0';
}

function deleteLast() {
    if (display.value.length === 1) {
        display.value = '0';
    } else {
        display.value = display.value.slice(0, -1);
    }
}

function calculate() {
    try {
        // Replace custom operators with standard JS operators
        let expression = display.value
            .replace(/÷/g, '/')
            .replace(/×/g, '*')
            .replace(/−/g, '-');
        
        // Prevent eval injection by checking for invalid characters
        if (/[^0-9+\-*/%().]/g.test(expression)) {
            display.value = 'Error';
            return;
        }
        
        const result = eval(expression);
        
        // Round to avoid floating point errors
        display.value = Math.round(result * 100000000) / 100000000;
    } catch (error) {
        display.value = 'Error';
        setTimeout(() => {
            display.value = '0';
        }, 1500);
    }
}

// Allow keyboard input
document.addEventListener('keydown', function(event) {
    const key = event.key;
    
    if (key >= '0' && key <= '9') {
        appendNumber(key);
    } else if (key === '.') {
        appendNumber('.');
    } else if (key === '+' || key === '-' || key === '*' || key === '/') {
        appendOperator(key);
    } else if (key === 'Enter' || key === '=') {
        event.preventDefault();
        calculate();
    } else if (key === 'Backspace') {
        event.preventDefault();
        deleteLast();
    } else if (key === 'Escape') {
        clearDisplay();
    }
});
