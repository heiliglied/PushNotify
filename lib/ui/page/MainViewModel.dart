import 'dart:async';

import 'package:push_notify/data/database/database.dart';
import 'package:push_notify/data/repository/CalendarRepository.dart';




class MainViewModel {

  final CalendarRepository repository;
  int page = 0;
  int limit = 10;
  bool allLoaded = false;
  final StreamController<List<NotiData>> _notiStreamController =
  StreamController.broadcast();

  MainViewModel(this.repository) {
    getNotNotifiedList(page, limit);
  }

  Stream<List<NotiData>> get notiDataStream => _notiStreamController.stream;

  void getNotNotifiedList(int page, int limit) {
    repository.getNotNotifiedList(page, limit).listen((data) {
      _notiStreamController.add(data);
    });
  }

  void updatePage(int newPage) {
    page++;
    getNotNotifiedList(page, limit);
  }

  void dispose() {
    _notiStreamController.close();
  }

  Future<int> turnOffNoti(NotiData data) async{
    return repository.turnOffNoti(data);
  }

  Future<NotiData> getNoti(int id) async{
    return repository.getNoti(id);
  }
}
