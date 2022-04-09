import 'package:calendar_event_app/model/event_data_source.dart';
import 'package:calendar_event_app/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TasksWidget extends StatefulWidget {
  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;

    if (selectedEvents.isEmpty) {
      return Center(
        child: Text("No events"),
      );

    }
    return SfCalendar(
      view: CalendarView.timelineDay,
      dataSource: EventsDataSource(provider.events),
    );
  }
}
