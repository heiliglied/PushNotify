import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:push_notify/libraries/UniDialog.dart';
import 'package:push_notify/views/partitions/BaseAppBar.dart';
import 'package:push_notify/views/partitions/BaseDrawer.dart';
import 'package:push_notify/database/database.dart';
import 'package:provider/provider.dart';

class SetNotify extends StatefulWidget {
  SetNotify({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SetNotify();
}

class _SetNotify extends State<SetNotify> {
  DateTime alertDate = DateTime.now();
  TimeOfDay alertTime = TimeOfDay.now();
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController alertName = TextEditingController();
  TextEditingController alertContents = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

    if(arguments['id'] != '') {

    }

    double widgetWidth = MediaQuery.of(context).size.width;
    double widgetHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: BaseAppBar("메시지 알리미"),
      endDrawer: BaseDrawer(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: widgetWidth,
                //height: widgetHeight - AppBar().preferredSize.height,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      arguments['title'],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24.0),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: dateinput,
                        readOnly: true,
                        //obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '날짜 선택'
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            locale: Locale('ko', 'KR'),
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now().subtract(Duration(days: 365)),
                            lastDate: DateTime.now().add(Duration(days: 365 * 2)),
                          ) ?? null;
                          if(pickedDate != null) {
                            alertDate = pickedDate;
                            setState(() {
                              dateinput.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: timeinput,
                        readOnly: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '시간 선택'
                        ),
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              cancelText: '취소',
                              confirmText: '확인',
                              helpText: '시간 선택',
                              errorInvalidText: '에러',
                              hourLabelText: '시',
                              minuteLabelText: '분',
                              initialEntryMode: TimePickerEntryMode.input,
                          );
                          if(pickedTime != null) {
                            alertTime = pickedTime;
                            String selectHour = alertTime.hour.toString().padLeft(2, '0');
                            String selectTime = alertTime.minute.toString().padLeft(2, '0');
                            if(selectHour != '' && selectTime != '') {
                              String timeSelect = selectHour + '시 ' + selectTime + '분';
                              setState(() {
                                timeinput.text = timeSelect;
                              });
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: alertName,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '알림 이름'
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: alertContents,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '알림 내용'
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: widgetWidth,
                      height: widgetHeight * 0.15 - AppBar().preferredSize.height,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: ElevatedButton(
                        child: Text("등록"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlueAccent
                        ),
                        onPressed: () async {
                          if(dateinput.text.trim() == '') {
                            UniDialog.showToast("날짜를 입력해 주세요.", 'short');
                            return;
                          }
                          if(timeinput.text.trim() == '') {
                            UniDialog.showToast("시간을 입력해 주세요.", 'short');
                            return;
                          }
                          if(alertName.text.trim() == '') {
                            UniDialog.showToast("알림을 입력해 주세요.", 'short');
                            return;
                          }

                          DateTime selecteDate = DateTime(
                              alertDate.year,
                              alertDate.month,
                              alertDate.day,
                              alertTime.hour,
                              alertTime.minute
                          );

                          insertNotiData(NotificationCompanion(
                              date: Value(selecteDate),
                              title: Value(alertName.text),
                              contents: Value(alertContents.text),
                              status: const Value(false)
                          )).then((result) => {
                              UniDialog.showToast("등록 되었습니다.", 'short'),
                              resetInput()
                          }).onError((error, stackTrace) => {
                            if(error.toString().contains("SqliteException(2067)")){
                              UniDialog.showToast("이미 등록된 날짜입니다.", 'short'),
                            } else{
                              UniDialog.showToast("등록에 실패했습니다.", 'short'),
                            }
                          });
                        },
                      ),
                    )
                  ]
                )
              ),
            )
          ),
        ]
      ),
    );
  }

  void resetInput() {
    dateinput.text = '';
    timeinput.text = '';
    alertName.text = '';
    alertContents.text = '';
  }

  Future<int> insertNotiData(NotificationCompanion noti) async {
    return Provider.of<Database>(context, listen: false).insertNoti(noti);
  }
}
