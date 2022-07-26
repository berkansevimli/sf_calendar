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

  @override
  void initState() {
    getHours();
    getAppointments();
    super.initState();
  }

  int duration = 30;

  DateTime startTime = DateTime(2022, 7, 27, 9, 0, 0);
  DateTime endTime = DateTime(2022, 7, 27, 13, 0, 0);

  getHours() {
    print("getHours");
    for (DateTime i = startTime;
        i.isBefore(endTime) || i.isAtSameMomentAs(startTime);
        i = i.add(Duration(minutes: 15))) {
      print(i);
      setState(() {
        hours.add(i);
      });
    }
  }

  getAppointments() {
    print("getAppointments");

    for (int i = 0; i < appointments.length; i++) {
      setState(() {
        // appointments[i].from = appointments[i].from.add(Duration(minutes: duration));
        // appointments[i].to = appointments[i].to.add(Duration(minutes: duration));
        for (int j = 0; j < hours.length; j++) {
          // print(hours[j]);

          if ((hours[j].isAfter(appointments[i].from) ||
                  hours[j].isAtSameMomentAs(appointments[i].from)) &&
              hours[j].isBefore(appointments[i].to)) {
            //print("${hours[j]} is between ${appointments[i].from} and ${appointments[i].to}");

            for (DateTime dateTime = appointments[i].from;
                dateTime.isBefore(appointments[i].to) 
                   ;
                dateTime = dateTime.add(Duration(minutes: 30))) {
              print(dateTime);
              hours.remove(dateTime);
              for (DateTime dateTime2 = appointments[i].from;
                  dateTime2.isBefore(appointments[i].to);
                  dateTime2 = dateTime2.add(Duration(minutes: 15))) {
                print(dateTime2);
                hours.remove(dateTime2);
              }
            }
          }
          // if (appointments[i].from.isAtSameMomentAs(hours[j])) {
          //   hours.remove(appointments[i].from);
          // }
          // if (appointments[i].to.isAtSameMomentAs(hours[j])) {
          //   hours.remove(appointments[i].from);
          // }
        }
      });
    }
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
    // Event(
    //     title: "Yoga",
    //     description: "description",
    //     from: DateTime(2022, 7, 27, 9, 0, 0),
    //     to: DateTime(2022, 7, 27, 9, 30, 0)),
    // Event(
    //     title: "Yoga",
    //     description: "description",
    //     from: DateTime(2022, 7, 27, 11, 15, 0),
    //     to: DateTime(2022, 7, 27, 11, 45, 0)),
    Event(
        title: "Lambda",
        description: "description",
        from: DateTime(2022, 7, 27, 12, 30, 0),
        to: DateTime(2022, 7, 27, 13, 0, 0)),
  ];
}
