import 'package:flutter/material.dart';
import 'bmi_calculate_sceen.dart';

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen>
    with SingleTickerProviderStateMixin {
  String? _selectedGender;

  final List<Color> _backgroundGradientColors = const [
    Color(0xFF5C91D4),
    Color(0xFF4451C8),
    Color(0xFF1F4ABE),
  ];

  final Color _bmiTitleColor = const Color(0xFFFFCC33);
  final Color _maleTextColor = const Color(0xFF4CAF50);
  final Color _femaleTextColor = const Color(0xFFF0AD4E);

  final String _maleImageUrl =
      'https://cdn-icons-png.flaticon.com/512/147/147144.png';
  final String _femaleImageUrl =
      'https://cdn-icons-png.flaticon.com/512/2922/2922561.png';

  void _navigateToBMICalculator(String gender) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BmiCalculateScreen(selectedGender: gender),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'BMI Calculator',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _backgroundGradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'BMI Calculator',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: _bmiTitleColor,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please choose your gender',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40),

                Row(
                  children: [
                    Expanded(
                      child: _buildGenderCard(
                        gender: 'Male',
                        genderText: 'Male',
                        genderIconData: Icons.male,
                        genderImageUrl: _maleImageUrl,
                        genderTextColor: _maleTextColor,
                        isSelected: _selectedGender == 'Male',
                        onTap: () {
                          setState(() => _selectedGender = 'Male');
                          _navigateToBMICalculator('Male');
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildGenderCard(
                        gender: 'Female',
                        genderText: 'Female',
                        genderIconData: Icons.female,
                        genderImageUrl: _femaleImageUrl,
                        genderTextColor: _femaleTextColor,
                        isSelected: _selectedGender == 'Female',
                        onTap: () {
                          setState(() => _selectedGender = 'Female');
                          _navigateToBMICalculator('Female');
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                _buildHealthMessage(),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHealthMessage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '💡 Your Health, Your Wealth:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),

          _buildHealthPoint('**Regular check-ups** are essential for a healthy life.', Colors.white70),
          _buildHealthPoint('**Balanced diet** is the foundation of long-term wellness.', Colors.white70),
          _buildHealthPoint('**Stay active**; a moving body is a happy and healthy mind.', Colors.white70),
          _buildHealthPoint('BMI calculation is your **first step** to better self-care!', Colors.white70),
          _buildHealthPoint('**Prioritize sleep**; it is crucial for physical and mental recovery.', Colors.white70),
          _buildHealthPoint('**Stay hydrated** by drinking enough water throughout the day.', Colors.white70),
          _buildHealthPoint('**Reduce stress** through meditation or deep breathing exercises.', Colors.white70),
        ],
      ),
    );
  }

  Widget _buildHealthPoint(String text, Color color) {
    List<TextSpan> spans = [];
    RegExp exp = RegExp(r'\*\*(.*?)\*\*');
    int current = 0;

    for (var match in exp.allMatches(text)) {
      if (match.start > current) {
        spans.add(TextSpan(text: text.substring(current, match.start), style: TextStyle(color: color, fontFamily: 'Roboto')));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
      ));
      current = match.end;
    }
    if (current < text.length) {
      spans.add(TextSpan(text: text.substring(current), style: TextStyle(color: color, fontFamily: 'Roboto')));
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Icon(Icons.check_circle_outline, color: Colors.lightGreenAccent, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: spans,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderCard({
    required String gender,
    required String genderText,
    required IconData genderIconData,
    required String genderImageUrl,
    required Color genderTextColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        decoration: BoxDecoration(
          color: isSelected ? genderTextColor.withOpacity(0.1) : Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: isSelected ? genderTextColor.withOpacity(0.7) : Colors.black.withOpacity(0.15),
              blurRadius: 15,
              spreadRadius: isSelected ? 3 : 0,
              offset: const Offset(0, 8),
            ),
          ],
          border: isSelected ? Border.all(color: genderTextColor, width: 4) : Border.all(color: Colors.transparent, width: 4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(genderImageUrl),
            ),

            const SizedBox(height: 15),

            Text(
              genderText,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: genderTextColor,
              ),
            ),

            const SizedBox(height: 5),

            Icon(
              genderIconData,
              size: 24,
              color: isSelected ? genderTextColor : Colors.grey.shade500,
            ),
          ],
        ),
      ),
    );
  }
}