import 'package:flutter/material.dart';

import '../../data/database/database.dart';
import '../../repository/CalendarRepository.dart';

class DetailViewModel {

  final CalendarRepository repository;
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  TimeOfDay _selectedTime = TimeOfDay.now();
  TimeOfDay get selectedTime => _selectedTime;

  DetailViewModel(this.repository);

  Future<int> addOrUpdateNoti(NotiCompanion data) async{
    return repository.addOrUpdateNoti(data);
  }

  void updateSelectedDate(DateTime newDate) {
    _selectedDate = newDate;
  }

  void updateSelectedTime(TimeOfDay newTime) {
    _selectedTime = newTime;
  }
}