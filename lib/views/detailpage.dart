import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:push_notify/views/partitions/BaseDrawer.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child ?? Container(),
          );
        });
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        timeController.text = '${picked.hour}:${picked.minute}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("타이틀"),
        ),
        drawer: BaseDrawer(),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text("알람 등록", style: TextStyle(fontSize: 20)),
                    TextField(
                      onTap: () => _selectDate(context),
                      controller: dateController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "날짜"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      onTap: () => _selectTime(context),
                      controller: timeController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "시간"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "제목"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: contentController,
                      decoration: InputDecoration(
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
                child: Text("다음"),
                onPressed: () {},
              ),
            )
          ],
        ));
  }
}
