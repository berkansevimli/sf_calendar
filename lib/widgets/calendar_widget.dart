import 'dart:math';

import 'package:calendar_event_app/model/event.dart';
import 'package:calendar_event_app/model/event_data_source.dart';
import 'package:calendar_event_app/provider/event_provider.dart';
import 'package:calendar_event_app/widgets/tasks_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  List<Event> _shiftCollection =[];
  List<CalendarResource> _employeeCollection = <CalendarResource>[];
  late EventsDataSource _events;

  @override
  void initState() {
    _addResources();
    _addAppointments();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    _events = EventsDataSource(_shiftCollection, _employeeCollection);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: SfCalendar(
              view: CalendarView.timelineWeek,
              allowedViews: const [
                CalendarView.timelineDay,
                CalendarView.timelineWeek,
                CalendarView.timelineWorkWeek,
              ],
              showDatePickerButton: true,
              resourceViewSettings: const ResourceViewSettings(
                  displayNameTextStyle: TextStyle(color: Colors.white),
                  showAvatar: true,
                  size: 80,
                  visibleResourceCount: 3),
              dataSource: _events,
            ),
          ),

          //TasksWidget(),
        ],
      ),
    );
  }

  void _addResources() {
    Random random = Random();
    List<String> _nameCollection = <String>[];
    _nameCollection.add('John');
    _nameCollection.add('Bryan');
    _nameCollection.add('Robert');
    _nameCollection.add('Kenny');
    _nameCollection.add('Tia');
    _nameCollection.add('Theresa');
    _nameCollection.add('Edith');
    _nameCollection.add('Brooklyn');
    _nameCollection.add('James William');
    _nameCollection.add('Sophia');
    _nameCollection.add('Elena');
    _nameCollection.add('Stephen');
    _nameCollection.add('Zoey Addison');
    _nameCollection.add('Daniel');
    _nameCollection.add('Emilia');
    _nameCollection.add('Kinsley Elena');
    _nameCollection.add('Daniel');
    _nameCollection.add('William');
    _nameCollection.add('Addison');
    _nameCollection.add('Ruby');

    List<Color> _resourceColorCollection = <Color>[];
    _resourceColorCollection.add(const Color(0xFF7c9473));
    _resourceColorCollection.add(const Color(0xFFcfdac8));
    _resourceColorCollection.add(const Color(0xFFcdd0cb));
    _resourceColorCollection.add(const Color(0xFF9dad7f));

    for (int i = 0; i < _nameCollection.length; i++) {
      _employeeCollection.add(CalendarResource(
        displayName: _nameCollection[i],
        id: '000' + i.toString(),
        color: _resourceColorCollection[random.nextInt(4)],
      ));
    }
  }

  void _addAppointments() {
    _shiftCollection = [];
    List<String> _subjectCollection = <String>[];
    _subjectCollection.add('General Meeting');
    _subjectCollection.add('Plan Execution');
    _subjectCollection.add('Project Plan');
    _subjectCollection.add('Consulting');
    _subjectCollection.add('Support');
    _subjectCollection.add('Development Meeting');
    _subjectCollection.add('Scrum');
    _subjectCollection.add('Project Completion');
    _subjectCollection.add('Release updates');
    _subjectCollection.add('Performance Check');

    List<Color> _colorCollection = <Color>[];
    _colorCollection.add(const Color(0xFFbe9fe1));
    _colorCollection.add(const Color(0xFFc9b6e4));
    _colorCollection.add(const Color(0xFFe1ccec));
    _colorCollection.add(const Color(0xFFf1f1f6));

    final Random random = Random();
    for (int i = 0; i < _employeeCollection.length; i++) {
      final List<String> _employeeIds = <String>[
        _employeeCollection[i].id.toString()
      ];
      if (i == _employeeCollection.length - 1) {
        int index = random.nextInt(5);
        index = index == i ? index + 1 : index;
        _employeeIds.add(_employeeCollection[index].id.toString());
      }

      for (int k = 0; k < 365; k++) {
        if (_employeeIds.length > 1 && k % 2 == 0) {
          continue;
        }
        for (int j = 0; j < 2; j++) {
          final DateTime date = DateTime.now().add(Duration(days: k + j));
          int startHour = 9 + random.nextInt(6);
          startHour =
              startHour >= 13 && startHour <= 14 ? startHour + 1 : startHour;
          final DateTime _shiftStartTime =
              DateTime(date.year, date.month, date.day, startHour, 0, 0);
          _shiftCollection.add(Event(
            description: "default",
              title:_subjectCollection[random.nextInt(8)] ,
              from: _shiftStartTime,
              to: _shiftStartTime.add(Duration(hours: 1)),
              backgroundColor: _colorCollection[random.nextInt(4)],
              resourceIds: _employeeIds
              
              ));
        }
      }
    }
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source, List<CalendarResource> resourceColl) {
    appointments = source;
    resources = resourceColl;
  }
}
