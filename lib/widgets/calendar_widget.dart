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

  int duration = 60;

  DateTime startTime = DateTime(2022, 7, 27, 9, 0, 0);
  DateTime endTime = DateTime(2022, 7, 27, 19, 00, 0);

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
    appointments.forEach((element) {
      for (DateTime dt = element.from;
          dt.isBefore(element.to);
          dt = dt.add(Duration(minutes: 15))) {
        setState(() {
          busyHours.add(dt);
          hours.remove(dt);
        });
      }

      for (int i = 0; i < (duration / 15); i++) {
        print(i);
        busyHours.add(element.from.subtract(Duration(minutes: (i) * 15)));
        hours.remove(element.from.subtract(Duration(minutes: (i) * 15)));
      }


    });
    print("hours: ${hours}");
    print(busyHours);
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
        to: DateTime(2022, 7, 27, 9, 45, 0)),
    Event(
        title: "Egzersiz",
        description: "description",
        from: DateTime(2022, 7, 27, 11, 30, 0),
        to: DateTime(2022, 7, 27, 12, 30, 0)),
    Event(
        title: "Lambda",
        description: "description",
        from: DateTime(2022, 7, 27, 14, 45, 0),
        to: DateTime(2022, 7, 27, 15, 15, 0)),
    Event(
        title: "Lambda",
        description: "description",
        from: DateTime(2022, 7, 27, 16, 30, 0),
        to: DateTime(2022, 7, 27, 17, 45, 0)),
    Event(
        title: "Lambda",
        description: "description",
        from: DateTime(2022, 7, 27, 18, 0, 0),
        to: DateTime(2022, 7, 27, 19, 0, 0)),
  ];
}
