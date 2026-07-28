const display = document.getElementById("display");
const expression = document.getElementById("expression");

let currentNumber = "";
let previousNumber = "";
let operator = "";
let shouldResetDisplay = false;


function updateDisplay() {
    display.value = currentNumber || "0";

    if (previousNumber !== "" && operator !== "") {
        expression.textContent = previousNumber + " " + operator;
    } else {
        expression.textContent = "";
    }
}


document.querySelectorAll(".number").forEach(button => {
    button.addEventListener("click", () => {

        if (shouldResetDisplay) {
            currentNumber = "";
            shouldResetDisplay = false;
        }

        currentNumber += button.textContent;
        updateDisplay();
    });
});


document.querySelector(".decimal").addEventListener("click", () => {

    if (shouldResetDisplay) {
        currentNumber = "0";
        shouldResetDisplay = false;
    }

    if (!currentNumber.includes(".")) {

        if (currentNumber === "") {
            currentNumber = "0";
        }

        currentNumber += ".";
    }

    updateDisplay();
});


document.querySelectorAll(".operator").forEach(button => {

    button.addEventListener("click", () => {

        const selectedOperator = button.textContent;

        
        if (currentNumber === "" && previousNumber === "" && selectedOperator === "-") {
            currentNumber = "-";
            updateDisplay();
            return;
        }

       
        if (previousNumber !== "" && currentNumber === "") {
            operator = selectedOperator;
            updateDisplay();
            return;
        }

        if (currentNumber === "") return;

        if (previousNumber !== "") {
            calculate();
        }

        previousNumber = currentNumber;
        operator = selectedOperator;
        currentNumber = "";
        shouldResetDisplay = false;

        updateDisplay();

    });

});


document.querySelector(".equals").addEventListener("click", () => {

    if (
        previousNumber === "" ||
        currentNumber === "" ||
        operator === ""
    ) {
        return;
    }

    expression.textContent =
        previousNumber + " " + operator + " " + currentNumber;

    calculate();

});


document.querySelector(".clear").addEventListener("click", () => {

    currentNumber = "";
    previousNumber = "";
    operator = "";
    shouldResetDisplay = false;

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
                expression.textContent = "";

                return;
            }

            result = prev / curr;
            break;

        default:
            return;

    }

    
    result = Number(result.toFixed(10));

    currentNumber = result.toString();
    previousNumber = "";
    operator = "";

    shouldResetDisplay = true;

    display.value = currentNumber;

}

document.addEventListener("keydown", (event) => {

    const key = event.key;

    if (!isNaN(key)) {

        document.querySelectorAll(".number").forEach(button => {

            if (button.textContent === key) {
                button.click();
            }

        });

    }

    else if (key === ".") {
        document.querySelector(".decimal").click();
    }

    else if (["+", "-", "*", "/"].includes(key)) {

        document.querySelectorAll(".operator").forEach(button => {

            if (button.textContent === key) {
                button.click();
            }

        });

    }

    else if (key === "Enter") {

        event.preventDefault();

        document.querySelector(".equals").click();

    }

    else if (key === "Escape") {

        document.querySelector(".clear").click();

    }

    else if (key === "Backspace") {

        if (!shouldResetDisplay) {

            currentNumber = currentNumber.slice(0, -1);

            updateDisplay();

        }

    }

});


updateDisplay();