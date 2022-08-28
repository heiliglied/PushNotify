import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:push_notify/views/partitions/BaseAppBar.dart';
import 'package:push_notify/views/partitions/BaseDrawer.dart';
import 'package:push_notify/database/database.dart';

class Set extends StatefulWidget {
  Set({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Set();
}

class _Set extends State<Set> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController alertName = TextEditingController();
  TextEditingController alertContents = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                    const Text(
                      '알림 등록',
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
                          );
                          if(pickedDate != null) {
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
                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                            setState(() {
                              timeinput.text = DateFormat('HH:mm').format(parsedTime);;
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
                        onPressed: (){
                          setState((){

                          });
                        },
                        child: Text("등록"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlueAccent
                        ),
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
}
