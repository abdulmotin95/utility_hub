import 'package:flutter/material.dart';
import 'dart:async';
import '../logic/bangla_calendar_logic.dart';

class BanglaCalendarScreen extends StatefulWidget {
  @override
  State<BanglaCalendarScreen> createState() => _BanglaCalendarScreenState();
}

class _BanglaCalendarScreenState extends State<BanglaCalendarScreen> {
  final List<String> banglaMonths = [
    "বৈশাখ", "জ্যৈষ্ঠ", "আষাঢ়", "শ্রাবণ", "ভাদ্র", "আশ্বিন",
    "কার্তিক", "অগ্রহায়ণ", "পৌষ", "মাঘ", "ফাল্গুন", "চৈত্র"
  ];

  final List<String> banglaDayNames = [
    "রবি", "সোম", "মঙ্গল", "বুধ", "বৃহঃ", "শুক্র", "শনি"
  ];

  late List<int> daysInMonth;
  late DateTime today;
  late int banglaYear;
  late int banglaMonthIndex;
  late int banglaDate;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    _updateBanglaDate();
    _startDailyTimer();
  }

  void _updateBanglaDate() {
    daysInMonth = BanglaDateConverter.getDaysInMonth(today.year);
    final result = BanglaDateConverter.calculateBanglaDate(today);
    setState(() {
      banglaYear = result['banglaYear']!;
      banglaMonthIndex = result['banglaMonthIndex']!;
      banglaDate = result['banglaDate']!;
    });
  }

  void _startDailyTimer() {
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    final durationUntilMidnight = nextMidnight.difference(now);

    _timer = Timer(durationUntilMidnight, () {
      _updateBanglaDate();
      _timer = Timer.periodic(const Duration(hours: 24), (timer) {
        _updateBanglaDate();
      });
    });
  }

  void _showBanglaDateDialog(int day) {
    DateTime selectedDate = DateTime(today.year, today.month, day);
    final result = BanglaDateConverter.calculateBanglaDate(selectedDate);

    String banglaDate = BanglaDateConverter.convertToBanglaDigits(result['banglaDate']!);
    String banglaMonth = banglaMonths[result['banglaMonthIndex']!];
    String banglaYearStr = BanglaDateConverter.convertToBanglaDigits(result['banglaYear']!);

  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentBanglaYear = BanglaDateConverter.convertToBanglaDigits(banglaYear);

    return DefaultTabController(
      length: 12,
      initialIndex: banglaMonthIndex,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(right: 60),
            child: Center(
              child: Text(
                "বাংলা বর্ষপঞ্জি (${currentBanglaYear} বঙ্গাব্দ)",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepOrange, Colors.orangeAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.white, width: 3),
            ),
            tabs: banglaMonths
                .map(
                  (month) => Tab(
                child: Text(
                  month,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            )
                .toList(),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF7F8FA), Color(0xFFFFF3E0)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: TabBarView(
            children: List.generate(12, (monthIndex) {
              int daysPassedSinceBoishakh1 = 0;
              for (int i = 0; i < monthIndex; i++) {
                daysPassedSinceBoishakh1 += daysInMonth[i];
              }

              DateTime monthStartDate = DateTime(today.year, 4, 14).add(Duration(days: daysPassedSinceBoishakh1));
              int startDayIndex = (monthStartDate.weekday % 7);

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 0,
                        ),
                        itemCount: banglaDayNames.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Text(
                              banglaDayNames[index],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.deepOrange,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: daysInMonth[monthIndex],
                        itemBuilder: (context, index) {
                          int dateNumber = index + 1;
                          bool isToday = (monthIndex == banglaMonthIndex && dateNumber == banglaDate);

                          String banglaDateText = BanglaDateConverter.convertToBanglaDigits(dateNumber);

                          return GestureDetector(
                            onTap: () => _showBanglaDateDialog(dateNumber),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                gradient: isToday
                                    ? const LinearGradient(
                                  colors: [Colors.blueAccent, Colors.lightBlue],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                                    : const LinearGradient(
                                  colors: [Colors.white, Color(0xFFFFF8E1)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(2, 3),
                                  ),
                                ],
                                border: Border.all(
                                  color: isToday ? Colors.blueAccent : Colors.grey.shade300,
                                  width: 1.2,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                banglaDateText,
                                style: TextStyle(
                                  color: isToday ? Colors.white : Colors.black87,
                                  fontWeight: isToday ? FontWeight.w900 : FontWeight.w600,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
