import 'dart:collection';

import 'package:push_notify/data/database/database.dart';




class CalendarPageUIState {
  final LinkedHashMap<DateTime, List<NotiData>> kEvent;
  final DateTime focusedDay;
  final List<bool> isSelected;

  CalendarPageUIState({
    required this.focusedDay,
    required this.kEvent,
    required this.isSelected,
  });

  CalendarPageUIState copyWith({
    LinkedHashMap<DateTime, List<NotiData>>? kEvent,
    DateTime? focusedDay,
    List<bool>? isSelected,
  }) {
    return CalendarPageUIState(
      kEvent: kEvent ?? this.kEvent,
      focusedDay: focusedDay ?? this.focusedDay,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}