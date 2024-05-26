import '../database/database.dart';

class DataSource {
  final MyDatabase database;

  DataSource(this.database);

  Stream<List<NotiData>> getDataByMonthList(DateTime _focusedDay) {
    print(
        "DataSource/getDataByMonth : ${_focusedDay.year}/${_focusedDay.month}/${_focusedDay.day}");
    // 현재 월의 첫날
    DateTime firstDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month, 1);

    // 다음 달의 첫날에서 하루를 빼면 현재 월의 마지막 날이 됩니다.
    DateTime lastDayOfMonth =
        DateTime(_focusedDay.year, _focusedDay.month + 1, 1)
            .subtract(const Duration(milliseconds: 1));

    return database.getNotiDataMonth(firstDayOfMonth, lastDayOfMonth);
  }

  Stream<List<NotiData>> getNotNotifiedList(int page, int limit){
    return database.getNotNotifiedNotiPaginationStream(page, limit);
  }

  Future<int> addOrUpdateNoti(NotiCompanion notiCompanion){
    return database.addOrUpdateNoti(notiCompanion);
  }

  Future<int> turnOffNoti(NotiData data){
    return database.turnOffNoti(data);
  }

  Future<NotiData> getNoti(int id){
    return database.getNoti(id);
  }

}
