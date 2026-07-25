const display = document.getElementById("display");

const numberButtons = document.querySelectorAll(".number");
const operatorButtons = document.querySelectorAll(".operator");
const decimalButton = document.querySelector(".decimal");
const clearButton = document.querySelector(".clear");
const equalsButton = document.querySelector(".equals");

let currentNumber = "";
let previousNumber = "";
let operator = "";


numberButtons.forEach(button => {

    button.addEventListener("click", () => {

        currentNumber += button.textContent;
        display.value = currentNumber;

    });

});

decimalButton.addEventListener("click", () => {

    if (!currentNumber.includes(".")) {

        if (currentNumber === "") {
            currentNumber = "0";
        }

        currentNumber += ".";
        display.value = currentNumber;

    }

});


clearButton.addEventListener("click", () => {

    currentNumber = "";
    previousNumber = "";
    operator = "";

    display.value = "";

});

function calculate() {

    let num1 = parseFloat(previousNumber);
    let num2 = parseFloat(currentNumber);

    switch (operator) {

        case "+":
            return num1 + num2;

        case "-":
            return num1 - num2;

        case "*":
            return num1 * num2;

        case "/":

            if (num2 === 0) {
                return "Cannot divide by 0";
            }

            return num1 / num2;

        default:
            return num2;
    }

}


operatorButtons.forEach(button => {

    button.addEventListener("click", () => {

        if (currentNumber === "") {
            return;
        }

        if (previousNumber !== "") {

            let result = calculate();

            if (result === "Cannot divide by 0") {

                display.value = result;

                currentNumber = "";
                previousNumber = "";
                operator = "";

                return;
            }

            previousNumber = result.toString();
            display.value = previousNumber;

        } else {

            previousNumber = currentNumber;

        }

        operator = button.textContent;
        currentNumber = "";

    });

});


equalsButton.addEventListener("click", () => {

    if (previousNumber === "" || currentNumber === "") {
        return;
    }

    let result = calculate();

    if (result === "Cannot divide by 0") {

        display.value = result;

        currentNumber = "";
        previousNumber = "";
        operator = "";

        return;
    }

    display.value = result;

    currentNumber = result.toString();
    previousNumber = "";
    operator = "";

});