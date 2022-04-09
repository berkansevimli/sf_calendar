import 'package:calendar_event_app/model/event.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventsDataSource extends CalendarDataSource {
  EventsDataSource(List<Event> appointments) {
    this.appointments = appointments;
  }

  Event getEvent(int index) => appointments![index] as Event;

  

  @override
  DateTime getStartTime(int index) => getEvent(index).from;

  @override
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  String getSubject(int index) => getEvent(index).title;

}
