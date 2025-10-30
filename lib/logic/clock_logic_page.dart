import 'dart:async';
import 'package:flutter/material.dart';

class ClockLogic {
  late Timer _timer;
  DateTime currentDateTime = DateTime.now();
  bool _isCustomTime = false;

  void startTimer(VoidCallback onUpdate) {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_isCustomTime) {
        currentDateTime = DateTime.now();
      } else {
        currentDateTime = currentDateTime.add(const Duration(seconds: 1));
      }
      onUpdate();
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  void setCustomTime(int hour, int minute) {
    currentDateTime = DateTime(
      currentDateTime.year,
      currentDateTime.month,
      currentDateTime.day,
      hour,
      minute,
      0,
    );
    _isCustomTime = true;
  }

  void setCustomDate(int year, int month, int day) {
    currentDateTime = DateTime(
      year,
      month,
      day,
      currentDateTime.hour,
      currentDateTime.minute,
      currentDateTime.second,
    );
    _isCustomTime = true;
  }

  void resetToRealTime() {
    _isCustomTime = false;
    currentDateTime = DateTime.now();
  }

  String formatTime() {
    String hour = (currentDateTime.hour % 12 == 0 ? 12 : currentDateTime.hour % 12).toString();
    String minute = currentDateTime.minute.toString().padLeft(2, '0');
    String ampm = currentDateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $ampm';
  }

  String formatDate() {
    String dayName = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'][currentDateTime.weekday-1];
    String monthName = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][currentDateTime.month-1];
    return '$dayName, $monthName ${currentDateTime.day}';
  }
}
