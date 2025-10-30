import 'dart:math';

class CalculatorLogic {
  String output = "0";
  String expression = "";
  double num1 = 0.0;
  String operand = "";
  bool newOperation = true;

  String _formatResult(double result) {
    String resultString = result.toString();
    if (resultString.endsWith('.0')) {
      return resultString.substring(0, resultString.length - 2);
    }
    return result.toStringAsPrecision(resultString.length > 10 ? 10 : resultString.length);
  }

  void onButtonPressed(String buttonText) {
    if (buttonText == "C") {
      output = "0";
      expression = "";
      num1 = 0.0;
      operand = "";
      newOperation = true;
    } else if (buttonText == "DEL") {
      if (output.length > 1) {
        output = output.substring(0, output.length - 1);
      } else {
        output = "0";
      }
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "x" || buttonText == "/") {
      if (operand.isEmpty) {
        num1 = double.tryParse(output) ?? 0.0;
      } else {
        _performCalculation(double.tryParse(output) ?? 0.0);
      }
      operand = buttonText;
      expression = _formatResult(num1) + " " + operand;
      newOperation = true;
    } else if (buttonText == "√") {
      double num = double.tryParse(output) ?? 0.0;
      if (num < 0) {
        output = "Error";
      } else {
        double result = sqrt(num);
        expression = "√($output) =";
        output = _formatResult(result);
      }
      operand = "";
      newOperation = true;
    } else if (buttonText == ".") {
      if (newOperation) {
        output = "0.";
        newOperation = false;
      } else if (!output.contains(".")) {
        output += buttonText;
      }
    } else if (buttonText == "=") {
      if (operand.isNotEmpty) {
        double num2 = double.tryParse(output) ?? 0.0;
        expression = "${_formatResult(num1)} $operand ${_formatResult(num2)} =";
        _performCalculation(num2);
        operand = "";
        newOperation = true;
      }
    } else {
      if (output == "0" || newOperation) {
        output = buttonText;
        newOperation = false;
        if (operand.isEmpty) {
          expression = "";
        }
      } else {
        output += buttonText;
      }
    }
  }

  void _performCalculation(double num2) {
    double result = 0.0;
    if (operand == "+") {
      result = num1 + num2;
    } else if (operand == "-") {
      result = num1 - num2;
    } else if (operand == "x") {
      result = num1 * num2;
    } else if (operand == "/") {
      if (num2 != 0) {
        result = num1 / num2;
      } else {
        output = "Error";
        num1 = 0.0;
        return;
      }
    }
    output = _formatResult(result);
    num1 = result;
  }
}
