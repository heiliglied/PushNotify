import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:push_notify/data/database/database.dart';
import 'package:push_notify/routes.dart';
import 'package:push_notify/service/MyService.dart';
import 'package:push_notify/ui/common/BaseDrawer.dart';
import 'package:push_notify/ui/libraries/UniDialog.dart';
import 'package:push_notify/ui/page/detail/DetailViewModel.dart';
import 'package:push_notify/ui/route/CommonRouteObserver.dart';


class DetailArgument {
  final String title;
  final String content;
  final DateTime dateTime;

  DetailArgument(this.title, this.content, this.dateTime);
}

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  var _isInit = true;

  final viewModel = locator<DetailViewModel>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: viewModel.selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != viewModel.selectedDate) {
      viewModel.updateSelectedDate(picked);
      dateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
        context: context,
        initialTime: viewModel.selectedTime,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child ?? Container(),
          );
        });
    if (picked != null && picked != viewModel.selectedTime) {
      print("$picked");
      setState(() {
        viewModel.updateSelectedTime(picked);
        timeController.text =
            '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  Future<int> upsertNotiData(NotiCompanion noti) async {
    return viewModel.addOrUpdateNoti(noti);
  }

  late Object args;
  var notiId = 0;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && _isInit == true) {
      NotiData noti = args as NotiData;
      notiId = noti.id;
      titleController.text = noti.title;
      contentController.text = noti.contents;
      TimeOfDay savedTime = TimeOfDay.fromDateTime(noti.date);
      dateController.text = DateFormat('yyyy-MM-dd').format(noti.date);
      timeController.text =
          '${savedTime.hour.toString().padLeft(2, '0')}:${savedTime.minute.toString().padLeft(2, '0')}';
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var list = AppNavObserver.navStack;
    list.forEach((element) {
      print("${element.name}>");
    });

    return Scaffold(
        appBar: AppBar(
          title: Text("타이틀"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: BackButtonIcon(),
          ),
        ),
        endDrawer: BaseDrawer(),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text("알람 등록", style: TextStyle(fontSize: 20)),
                    TextField(
                      onTap: () => _selectDate(context),
                      controller: dateController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "날짜"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      onTap: () => _selectTime(context),
                      controller: timeController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "시간"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "제목"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: contentController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "본문"),
                    ),
                  ],
                ),
              )),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                child: const Text("저장"),
                onPressed: () async {
                  if (dateController.text.trim() != "" &&
                      timeController.text.trim() != "" &&
                      titleController.text.trim() != "" &&
                      contentController.text.trim() != "") {
                    var selected = DateTime(
                        viewModel.selectedDate.year,
                        viewModel.selectedDate.month,
                        viewModel.selectedDate.day,
                        viewModel.selectedTime.hour,
                        viewModel.selectedTime.minute);

                    NotiCompanion data;
                    if (notiId != 0) {
                      data = NotiCompanion(
                          id: Value(notiId),
                          date: Value(selected),
                          title: Value(titleController.text),
                          contents: Value(contentController.text),
                          status: const Value(false));
                    } else {
                      data = NotiCompanion(
                          date: Value(selected),
                          title: Value(titleController.text),
                          contents: Value(contentController.text),
                          status: const Value(false));
                    }
                    debugPrint("$data");
                    viewModel
                        .addOrUpdateNoti(data)
                        .then((value) => {
                              showToast("저장이 완료되었습니다."),
                              // Navigator.pop(context, data)
                              Navigator.pushNamedAndRemoveUntil(
                                  context, Routes.mainPage, (r) => false,
                                  arguments: {"title": "홈"})
                            })
                        .onError((error, stackTrace) => {
                              if (error
                                  .toString()
                                  .contains("SqliteException(2067)"))
                                {showToast("이미 등록된 날짜입니다.")}
                              else
                                {
                                  debugPrint("$error"),
                                  showToast("등록에 실패했습니다.")
                                }
                            });
                  } else {
                    UniDialog.dialog(context,
                        title: "경고",
                        content: "작성하지 않은 항목이 있습니다.",
                        positiveText: "확인", positive: () {
                      Navigator.pop(context);
                    });
                  }
                },
              ),
            )
          ],
        ));
  }

  void showToast(String msg) {
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT);
  }
}
