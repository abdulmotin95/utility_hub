import 'package:flutter/material.dart';
import 'dart:math';
import 'logic/bmi_calculate_logic.dart';

class BmiCalculateScreen extends StatefulWidget {
  final String selectedGender;

  const BmiCalculateScreen({
    super.key,
    required this.selectedGender,
  });

  @override
  State<BmiCalculateScreen> createState() => _BmiCalculateScreenState();
}

class _BmiCalculateScreenState extends State<BmiCalculateScreen> {
  int _weight = 65;
  int _age = 26;
  double _height = 5.7;

  final Color _rulerIndicatorColor = const Color(0xFFF0AD4E);
  final Color _cardBackgroundColor = const Color(0xFFF5F5F5);
  final Color _valueTextColor = const Color(0xFFF0AD4E);

  final List<Color> _backgroundGradientColors = const [
    Color(0xFF5C91D4),
    Color(0xFF4451C8),
    Color(0xFF1F4ABE),
  ];

  void _calculateBMI() {
    BMILogic logic = BMILogic(weight: _weight, height: _height);
    Map<String, dynamic> result = logic.getBMIInterpretation();
    String healthyWeight = logic.getHealthyWeightRange();

    _showBMIResultDialog(double.parse(result['bmi']), result, healthyWeight);
  }

  void _showBMIResultDialog(double bmi, Map<String, dynamic> interpretation, String healthyWeight) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xFFECF0F3), Color(0xFFF9FAFB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(2, 6))],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Your BMI Result',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black87),
                ),
                const SizedBox(height: 15),
                Text(
                  bmi.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: interpretation['color'],
                    shadows: [Shadow(color: interpretation['color'].withOpacity(0.4), blurRadius: 10)],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: interpretation['color'].withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    interpretation['status']!,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: interpretation['color']),
                  ),
                ),
                const SizedBox(height: 20),
                _buildBMIIndicatorBar(bmi, interpretation),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildValueColumn('$_weight kg', 'Weight'),
                    _buildValueColumn('${_height.toStringAsFixed(1)} ft', 'Height'),
                    _buildValueColumn('$_age', 'Age'),
                    _buildValueColumn(widget.selectedGender, 'Gender'),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Healthy Weight Range:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
                ),
                Text(
                  healthyWeight,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4CAF50)),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF00C9A7), Color(0xFF92FE9D)]),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [BoxShadow(color: Colors.greenAccent.withOpacity(0.3), blurRadius: 10, offset: Offset(0, 6))],
                  ),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                    child: const Text('Close',
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBMIIndicatorBar(double bmi, Map<String, dynamic> interpretation) {
    const double minBmi = 15.0, maxBmi = 35.0;
    double normalized = ((bmi - minBmi) / (maxBmi - minBmi)).clamp(0.0, 1.0);

    return Column(
      children: [
        LayoutBuilder(builder: (context, constraints) {
          double width = constraints.maxWidth;
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 15,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Expanded(child: Container(color: Colors.blue.shade700)),
                    Expanded(child: Container(color: Colors.green.shade500)),
                    Expanded(child: Container(color: Colors.amber.shade700)),
                    Expanded(child: Container(color: Colors.red.shade700)),
                  ],
                ),
              ),
              Positioned(
                  left: (width * normalized) - 8,
                  bottom: -10,
                  child: Icon(Icons.arrow_drop_up, color: interpretation['color'], size: 28))
            ],
          );
        })
      ],
    );
  }

  Widget _buildValueColumn(String value, String label) {
    return Column(
      children: [
        Text(value.toUpperCase(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Gradient buttonGradient = const LinearGradient(colors: [Color(0xFF00C9A7), Color(0xFF92FE9D)]);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.white), onPressed: () => Navigator.pop(context)),
        title: const Text('BMI Calculator', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: _backgroundGradientColors, begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Please Modify the values',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, shadows: [Shadow(color: Colors.black, blurRadius: 5, offset: Offset(1, 1))])),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                        child: WeightAgeCard(
                            title: 'Weight (kg)',
                            value: _weight,
                            onDecrement: () => setState(() => _weight = (_weight > 10 ? _weight - 1 : 10)),
                            onIncrement: () => setState(() => _weight += 1),
                            cardBackgroundColor: _cardBackgroundColor,
                            valueTextColor: _valueTextColor,
                            buttonColor: _rulerIndicatorColor)),
                    const SizedBox(width: 20),
                    Expanded(
                        child: WeightAgeCard(
                            title: 'Age',
                            value: _age,
                            onDecrement: () => setState(() => _age = (_age > 1 ? _age - 1 : 1)),
                            onIncrement: () => setState(() => _age += 1),
                            cardBackgroundColor: _cardBackgroundColor,
                            valueTextColor: _valueTextColor,
                            buttonColor: _rulerIndicatorColor)),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: HeightCard(
                        height: _height,
                        onHeightChanged: (newHeight) => setState(() => _height = newHeight),
                        cardBackgroundColor: _cardBackgroundColor,
                        valueTextColor: _valueTextColor,
                        buttonColor: _rulerIndicatorColor)),
                const SizedBox(height: 40),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: buttonGradient,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [BoxShadow(color: Colors.greenAccent.withOpacity(0.4), blurRadius: 10, offset: Offset(0, 6))],
                  ),
                  child: ElevatedButton(
                    onPressed: _calculateBMI,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                    child: const Text('Calculate',
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class WeightAgeCard extends StatelessWidget {
  final String title;
  final int value;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final Color cardBackgroundColor;
  final Color valueTextColor;
  final Color buttonColor;

  const WeightAgeCard(
      {super.key,
        required this.title,
        required this.value,
        required this.onDecrement,
        required this.onIncrement,
        required this.cardBackgroundColor,
        required this.valueTextColor,
        required this.buttonColor});

  Widget _buildRoundButton(IconData icon, VoidCallback onPressed) {
    return RawMaterialButton(
      onPressed: onPressed,
      constraints: const BoxConstraints.tightFor(width: 55, height: 55),
      elevation: 8,
      shape: const CircleBorder(),
      fillColor: Colors.white,
      child: Icon(icon, color: buttonColor, size: 25),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          color: cardBackgroundColor, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 4))]),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 16, color: Colors.black87)),
          const SizedBox(height: 5),
          Text('$value', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: valueTextColor)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildRoundButton(Icons.remove, onDecrement),
              const SizedBox(width: 15),
              _buildRoundButton(Icons.add, onIncrement),
            ],
          ),
        ],
      ),
    );
  }
}


class HeightCard extends StatelessWidget {
  final double height;
  final Function(double) onHeightChanged;
  final Color cardBackgroundColor;
  final Color valueTextColor;
  final Color buttonColor;

  const HeightCard(
      {super.key,
        required this.height,
        required this.onHeightChanged,
        required this.cardBackgroundColor,
        required this.valueTextColor,
        required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: cardBackgroundColor, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 4))]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Height', style: TextStyle(fontSize: 16, color: Colors.black87)),
          const SizedBox(height: 10),
          Text(height.toStringAsFixed(1) + ' ft', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: valueTextColor)),
          Slider(
            value: height,
            min: 3,
            max: 8,
            activeColor: buttonColor,
            inactiveColor: buttonColor.withOpacity(0.3),
            onChanged: (value) => onHeightChanged(value),
          )
        ],
      ),
    );
  }
}
