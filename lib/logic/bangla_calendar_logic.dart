class BanglaDateConverter {
  static List<int> getDaysInMonth(int year) {
    bool isLeap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    return [
      31, 31, 31, 31, 31, 30, 30, 30, 30, 30, isLeap ? 30 : 29, 30
    ];
  }


  static Map<String, int> calculateBanglaDate(DateTime date, {int? manualYearOffset}) {
    int year = date.year;
    List<int> daysInMonth = getDaysInMonth(year);

    int banglaYear;


    if (date.month > 4 || (date.month == 4 && date.day >= 14)) {
      banglaYear = year - 593;
    } else {
      banglaYear = year - 594;
    }


    if (manualYearOffset != null) {
      banglaYear += manualYearOffset;
    }


    DateTime nextBoishakh = DateTime(year + 1, 4, 14);
    if (date.isAfter(nextBoishakh)) {
      banglaYear++;
    }


    DateTime boishakhStart = DateTime(year, 4, 14);
    int diff = date.difference(boishakhStart).inDays;

    int banglaMonthIndex = 0;
    int banglaDate = 1;

    if (diff >= 0) {
      int month = 0;
      int dayCount = diff;
      while (dayCount >= daysInMonth[month]) {
        dayCount -= daysInMonth[month];
        month++;
      }
      banglaMonthIndex = month;
      banglaDate = dayCount + 1;
    } else {
      List<int> prevYearDays = getDaysInMonth(year - 1);
      int month = 11;
      int dayCount = -diff - 1;
      while (dayCount >= prevYearDays[month]) {
        dayCount -= prevYearDays[month];
        month--;
      }
      banglaMonthIndex = month;
      banglaDate = prevYearDays[month] - dayCount;
    }

    return {
      'banglaYear': banglaYear,
      'banglaMonthIndex': banglaMonthIndex,
      'banglaDate': banglaDate,
    };
  }


  static String convertToBanglaDigits(int number) {
    const Map<String, String> banglaDigits = {
      '0': '০', '1': '১', '2': '২', '3': '৩', '4': '৪',
      '5': '৫', '6': '৬', '7': '৭', '8': '৮', '9': '৯',
    };
    String str = number.toString();
    String banglaStr = '';
    for (int i = 0; i < str.length; i++) {
      banglaStr += banglaDigits[str[i]] ?? str[i];
    }
    return banglaStr;
  }


  static String getFormattedBanglaDate(DateTime date, {int? manualYearOffset}) {
    final result = calculateBanglaDate(date, manualYearOffset: manualYearOffset);
    final banglaYear = convertToBanglaDigits(result['banglaYear']!);
    final banglaDate = convertToBanglaDigits(result['banglaDate']!);
    final banglaMonths = [
      "বৈশাখ", "জ্যৈষ্ঠ", "আষাঢ়", "শ্রাবণ", "ভাদ্র", "আশ্বিন",
      "কার্তিক", "অগ্রহায়ণ", "পৌষ", "মাঘ", "ফাল্গুন", "চৈত্র"
    ];
    final monthName = banglaMonths[result['banglaMonthIndex']!];
    return "$banglaDate $monthName $banglaYear বঙ্গাব্দ";
  }
}
