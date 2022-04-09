import 'package:calendar_event_app/model/event_data_source.dart';
import 'package:calendar_event_app/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: SfCalendar(
        view: CalendarView.month,
        dataSource: EventsDataSource(events),
        initialDisplayDate: DateTime.now(),
        cellBorderColor: Colors.transparent,
        onLongPress: (details) {
          final provider = Provider.of<EventProvider>(context, listen: false);
          provider.setDate(details.date!);
          
        },
      ),
    );
  }
}
