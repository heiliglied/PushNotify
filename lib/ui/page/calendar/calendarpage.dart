import 'package:flutter/material.dart';
import 'package:push_notify/service/MyService.dart';
import 'package:push_notify/ui/common/BaseDrawer.dart';
import 'package:push_notify/ui/libraries/CalendarLib.dart';
import 'package:push_notify/ui/page/calendar/CalendarViewModel.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final viewModel = locator<CalendarViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("타이틀"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const BackButtonIcon(),
          ),
        ),
        endDrawer: BaseDrawer(),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder(
        stream: viewModel.uiStateStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return Column(
              children: [
                ToggleButtons(
                  children: const [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('달력보기', style: TextStyle(fontSize: 18))),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('목록보기', style: TextStyle(fontSize: 18))),
                  ],
                  isSelected: viewModel.uiState.isSelected,
                  onPressed: viewModel.toggleSelect,
                ),
                CalendarLib(
                  focusedDay: viewModel.uiState.focusedDay,
                  kEvents: viewModel.uiState.kEvent,
                  notifyPageChange: (focusedDay) {
                    viewModel.notifyPageChange(focusedDay);
                  },
                  notifyFocusedChange: (focusedDay) {
                    viewModel.notifyFocusedDay(focusedDay);
                  },
                ),
              ],
            );
          }
        });
  }
}
