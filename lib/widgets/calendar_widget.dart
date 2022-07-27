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
  DateTime selectedTime = DateTime.now();
  List<DateTime> hours = [];
  List<DateTime> busyHours = [];
  List<DateTime> appointmentStarts = [];

  @override
  void initState() {
    getHours();
    getAppointments();
    super.initState();
  }

  int duration = 30;

  DateTime startTime = DateTime(2022, 7, 27, 9, 0, 0);
  DateTime endTime = DateTime(2022, 7, 27, 13, 00, 0);

  getHours() {
    print("getHours");
    for (DateTime i = startTime;
        i.isBefore(endTime);
        i = i.add(Duration(minutes: 15))) {
      print(i);
      setState(() {
        hours.add(i);
      });
    }
  }

  getAppointments() {
    print("first phase");

    for (int j = 0; j < hours.length; j++) {
      for (int i = 0; i < appointments.length; i++) {
        if ((hours[j].isAtSameMomentAs(appointments[i].from) ||
                hours[j].isAfter(appointments[i].from)) &&
            hours[j].isBefore(appointments[i].to)) {
          print(hours[j]);
          setState(() {
            busyHours.add(hours[j]);
          });
        }
        if (hours[j].isAtSameMomentAs(appointments[i].to)) {}
      }
    }
    setState(() {
      for (DateTime i in busyHours) {
        hours.remove(i);
      }
    });
    print("second phase ");

    for (int i = 0; i < appointments.length; i++) {
      setState(() {
        appointmentStarts.add(appointments[i].from);
      });
    }

    print("third phase");

    
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: appointments.map((event) {
              return ListTile(
                title: Text(event.title),
                subtitle: Text(event.from.toString()),
                trailing: Text(event.to.toString()),
              );
            }).toList(),
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: hours.map((hour) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 0.1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12),
                      child: Text(
                          hour.hour.toString() + ":" + hour.minute.toString()),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<Event> appointments = [
    Event(
        title: "Yoga",
        description: "description",
        from: DateTime(2022, 7, 27, 9, 0, 0),
        to: DateTime(2022, 7, 27, 9, 30, 0)),
    Event(
        title: "Egzersiz",
        description: "description",
        from: DateTime(2022, 7, 27, 11, 15, 0),
        to: DateTime(2022, 7, 27, 11, 45, 0)),
    Event(
        title: "Lambda",
        description: "description",
        from: DateTime(2022, 7, 27, 12, 30, 0),
        to: DateTime(2022, 7, 27, 13, 0, 0)),
  ];
}
