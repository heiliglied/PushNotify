
import 'package:push_notify/data/database/database.dart';
import 'package:push_notify/data/datasource/DataSource.dart';


class CalendarRepository {
  final DataSource dataSource;
  CalendarRepository(this.dataSource);

  Stream<List<NotiData>> getDataByMonthList(DateTime _focusedDay) {
    return dataSource.getDataByMonthList(_focusedDay);
  }

  Stream<List<NotiData>> getNotNotifiedList(int page, int limit) {
    return dataSource.getNotNotifiedList(page, limit);
  }

  Future<int> addOrUpdateNoti(NotiCompanion notiCompanion){
    return dataSource.addOrUpdateNoti(notiCompanion);
  }

  Future<int> turnOffNoti(NotiData data){
    return dataSource.turnOffNoti(data);
  }

  Future<NotiData> getNoti(int id){
    return dataSource.getNoti(id);
  }
}