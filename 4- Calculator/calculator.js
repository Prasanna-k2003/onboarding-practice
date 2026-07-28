const display = document.getElementById("display");
const expression = document.getElementById("expression");

let currentNumber = "";
let previousNumber = "";
let operator = "";
let shouldResetDisplay = false;


let expressionParts = [];



function isTypedNumber(str) {
    return str !== "" && !isNaN(parseFloat(str));
}


function roundResult(num) {
    if (!isFinite(num)) return num;
    return Math.round((num + Number.EPSILON) * 1e10) / 1e10;
}

function updateDisplay() {
    display.value = currentNumber || "0";
    expression.textContent = expressionParts.join(" ");
}

function setActiveOperator(activeButton) {
    document.querySelectorAll(".operator").forEach(btn => {
        btn.classList.toggle("active", btn === activeButton);
    });
}

function clearActiveOperator() {
    document.querySelectorAll(".operator").forEach(btn => btn.classList.remove("active"));
}


document.querySelectorAll(".number").forEach(button => {
    button.addEventListener("click", () => {
        if (shouldResetDisplay) {
            currentNumber = "";
            expressionParts = [];
            shouldResetDisplay = false;
        }
        currentNumber += button.textContent;
        updateDisplay();
    });
});


document.querySelector(".decimal").addEventListener("click", () => {
    if (shouldResetDisplay) {
        currentNumber = "";
        expressionParts = [];
        shouldResetDisplay = false;
    }

    if (!currentNumber.includes(".")) {
        if (currentNumber === "") {
            currentNumber = "0.";
        } else if (currentNumber === "-") {
            currentNumber = "-0.";
        } else {
            currentNumber += ".";
        }
    }

    updateDisplay();
});


document.querySelectorAll(".operator").forEach(button => {
    button.addEventListener("click", () => {
        const selectedOperator = button.textContent;
        const hasNumber = isTypedNumber(currentNumber);


        if (!hasNumber && currentNumber === "" && previousNumber === "" && selectedOperator === "-") {
            currentNumber = "-";
            updateDisplay();
            return;
        }

        
        if (!hasNumber) {
            if (previousNumber !== "") {
                operator = selectedOperator;
                currentNumber = ""; // drop any stray "-"
                if (expressionParts.length > 0) {
                    expressionParts[expressionParts.length - 1] = selectedOperator;
                }
                setActiveOperator(button);
                updateDisplay();
            }
            return;
        }

                expressionParts.push(currentNumber, selectedOperator);

        if (previousNumber !== "" && operator !== "") {
            calculate();
        }

        previousNumber = currentNumber;
        operator = selectedOperator;
        currentNumber = "";
        shouldResetDisplay = false;
        setActiveOperator(button);
        updateDisplay();
    });
});


document.querySelector(".equals").addEventListener("click", () => {
    if (previousNumber === "" || !isTypedNumber(currentNumber) || operator === "") {
        return;
    }

    expressionParts.push(currentNumber);
    updateDisplay();
    calculate();
    clearActiveOperator();
});


document.querySelector(".clear").addEventListener("click", () => {
    currentNumber = "";
    previousNumber = "";
    operator = "";
    shouldResetDisplay = false;
    expressionParts = [];

    clearActiveOperator();
    expression.textContent = "";
    display.value = "0";
});


function calculate() {
    let prev = parseFloat(previousNumber);
    let curr = parseFloat(currentNumber);
    let result;

    switch (operator) {
        case "+":
            result = prev + curr;
            break;

        case "-":
            result = prev - curr;
            break;

        case "*":
            result = prev * curr;
            break;

        case "/":
            if (curr === 0) {
                display.value = "Cannot divide by zero";

                currentNumber = "";
                previousNumber = "";
                operator = "";
                expressionParts = [];
                expression.textContent = "";
                shouldResetDisplay = true;

                return;
            }
            result = prev / curr;
            break;

        default:
            return;
    }

    result = roundResult(result);

    currentNumber = result.toString();
    previousNumber = "";
    operator = "";
    shouldResetDisplay = true;

    display.value = currentNumber;
}


document.addEventListener("keydown", (event) => {
    const key = event.key;

    if (key !== "" && !isNaN(key)) {
        document.querySelectorAll(".number").forEach(button => {
            if (button.textContent === key) {
                button.click();
            }
        });
    } else if (key === ".") {
        document.querySelector(".decimal").click();
    } else if (["+", "-", "*", "/"].includes(key)) {
        document.querySelectorAll(".operator").forEach(button => {
            if (button.textContent === key) {
                button.click();
            }
        });
    } else if (key === "Enter" || key === "=") {
        event.preventDefault();
        document.querySelector(".equals").click();
    } else if (key === "Escape") {
        document.querySelector(".clear").click();
    } else if (key === "Backspace") {
        if (!shouldResetDisplay) {
            currentNumber = currentNumber.slice(0, -1);
            updateDisplay();
        }
    }
});


updateDisplay();