import 'dart:async';

import 'package:push_notify/repository/CalendarRepository.dart';

import '../../data/database/database.dart';


class CalendarViewModel{
  final CalendarRepository repository;

  final StreamController<List<NotiData>> _notiStreamController = StreamController.broadcast();
  Stream<List<NotiData>> get notiDataStream => _notiStreamController.stream;

  DateTime _focusedDay = DateTime.now();
  DateTime get focusedDay => _focusedDay;

  List<bool> _isSelected = [true, false];
  List<bool> get isSelected => _isSelected;

  CalendarViewModel(this.repository) {
    loadNotiDataForMonth(_focusedDay);
  }

  void loadNotiDataForMonth(DateTime date) {
    repository.getDataByMonthList(date).listen((data) {
      _notiStreamController.add(data);
    });
  }

  void updateFocusdDay(DateTime newFocusedDay) {
    _focusedDay = newFocusedDay;
    loadNotiDataForMonth(newFocusedDay);
  }

  void toggleSelect(int value) {
    var result = <bool>[];
    for (int i = 0; i < isSelected.length; i++) {
      if (i == value) {
        result.add(true);
      } else {
        result.add(false);
      }
    }
    _isSelected = result;
  }

  void dispose() {
    _notiStreamController.close();
  }
}
