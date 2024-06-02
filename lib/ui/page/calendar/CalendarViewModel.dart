import 'dart:async';
import 'dart:collection';
import 'package:collection/collection.dart';

import 'package:push_notify/data/database/database.dart';
import 'package:push_notify/data/repository/CalendarRepository.dart';
import 'package:push_notify/ui/libraries/CalendarLib.dart';
import 'package:push_notify/ui/page/calendar/CalendarPageUIState.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarViewModel {
  final CalendarRepository repository;
  final _uiStateController = StreamController<CalendarPageUIState>.broadcast();

  CalendarPageUIState _uiState = CalendarPageUIState(
    focusedDay: DateTime.now(),
    kEvent: LinkedHashMap<DateTime, List<NotiData>>(),
    isSelected: [true, false],
  );

  CalendarPageUIState get uiState => _uiState;

  Stream<CalendarPageUIState> get uiStateStream => _uiStateController.stream;

  CalendarViewModel(this.repository) {
    loadNotiDataForMonth(_uiState.focusedDay);
  }

  void _updateState(CalendarPageUIState newState) {
    _uiState = newState;
    _uiStateController.sink.add(_uiState);
  }

  void loadNotiDataForMonth(DateTime date) {
    repository.getDataByMonthList(date).listen((list) {
      Map<DateTime, List<NotiData>> map = groupBy(
          list, (NotiData data) =>
              DateTime(data.date.year, data.date.month, data.date.day));

      LinkedHashMap<DateTime, List<NotiData>> newKEvent = LinkedHashMap<DateTime, List<NotiData>>(
        equals: isSameDay,
        hashCode: getHashCode,
      )..addAll(map);
      print("loadNotiDataForMonth >>>>> $newKEvent");

      _updateState(_uiState.copyWith(kEvent: newKEvent));
    });
  }

  void notifyPageChange(DateTime newFocusedDay) {
    _uiState = _uiState.copyWith(focusedDay: newFocusedDay);
    loadNotiDataForMonth(newFocusedDay);
  }

  void notifyFocusedDay(DateTime newFocusedDay) {
    bool getNewNotiData = uiState.focusedDay.month != newFocusedDay.month;
    _uiState = _uiState.copyWith(focusedDay: newFocusedDay);
    if (getNewNotiData) {
      loadNotiDataForMonth(newFocusedDay);
    }
  }

  void toggleSelect(int value) {
    List<bool> newIsSelected =
        List.generate(_uiState.isSelected.length, (i) => i == value);
    _updateState(_uiState.copyWith(isSelected: newIsSelected));
  }
}
