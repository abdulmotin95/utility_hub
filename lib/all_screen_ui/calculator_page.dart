import 'package:flutter/material.dart';
import '../logic/calculator_logic.dart';
import 'dart:ui';

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  final CalculatorLogic logic = CalculatorLogic();

  Widget buildButton(String buttonText, Color color, Color textColor, [int flex = 1]) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: const EdgeInsets.all(6.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: color.withOpacity(0.6),
                foregroundColor: textColor,
                padding: const EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                textStyle: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                elevation: 5,
              ),
              onPressed: () {
                logic.onButtonPressed(buttonText);
                setState(() {});
              },
              child: Text(buttonText),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5C91D4),
              Color(0xFF4451C8),
              Color(0xFF1F4ABE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Simple Calculator',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        logic.expression,
                        style: const TextStyle(fontSize: 28.0, color: Colors.white70),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        logic.output,
                        style: const TextStyle(fontSize: 68.0, fontWeight: FontWeight.w300, color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(top: 140),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          buildButton("C", Colors.orange.shade800, Colors.white),
                          buildButton("DEL", Colors.red.shade700, Colors.white),
                          buildButton("√", Colors.grey.shade700, Colors.white),
                          buildButton("/", Colors.grey.shade700, Colors.white),
                        ],
                      ),
                      Row(
                        children: [
                          buildButton("7", Colors.grey.shade800, Colors.white),
                          buildButton("8", Colors.grey.shade800, Colors.white),
                          buildButton("9", Colors.grey.shade800, Colors.white),
                          buildButton("x", Colors.grey.shade700, Colors.white),
                        ],
                      ),
                      Row(
                        children: [
                          buildButton("4", Colors.grey.shade800, Colors.white),
                          buildButton("5", Colors.grey.shade800, Colors.white),
                          buildButton("6", Colors.grey.shade800, Colors.white),
                          buildButton("-", Colors.grey.shade700, Colors.white),
                        ],
                      ),
                      Row(
                        children: [
                          buildButton("1", Colors.grey.shade800, Colors.white),
                          buildButton("2", Colors.grey.shade800, Colors.white),
                          buildButton("3", Colors.grey.shade800, Colors.white),
                          buildButton("+", Colors.grey.shade700, Colors.white),
                        ],
                      ),
                      Row(
                        children: [
                          buildButton("0", Colors.grey.shade800, Colors.white, 2),
                          buildButton(".", Colors.grey.shade800, Colors.white),
                          buildButton("=", Colors.blue.shade700, Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
