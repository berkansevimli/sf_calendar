// import 'package:calendar_event_app/model/event_data_source.dart';
// import 'package:calendar_event_app/provider/event_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';

// class TasksWidget extends StatefulWidget {
//   @override
//   _TasksWidgetState createState() => _TasksWidgetState();
// }

// class _TasksWidgetState extends State<TasksWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<EventProvider>(context);
//     final selectedEvents = provider.eventsOfSelectedDate;

//     if (selectedEvents.isEmpty) {
//       return const Center(
//         child: Text("No events"),
//       );
//     }
//     return SfCalendar(
//       view: CalendarView.workWeek,
//       timeSlotViewSettings: TimeSlotViewSettings(
//           startHour: 9,
//           endHour: 16,
//           nonWorkingDays: <int>[DateTime.friday, DateTime.saturday]),
//       dataSource: EventsDataSource(provider.events),
//       initialDisplayDate: provider.selectedDate,
//       appointmentBuilder: appointmentBuilder,
//       showCurrentTimeIndicator: true,
//       selectionDecoration: BoxDecoration(
//         color: Colors.blue.withOpacity(0.5),
//         borderRadius: BorderRadius.circular(10),
//       ),
//     );
//   }

//   Widget appointmentBuilder(
//     BuildContext context,
//     CalendarAppointmentDetails details,
//   ) {
//     final event = details.appointments.first;
//     return Container(
//       width: details.bounds.width,
//       child: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(event.title),
//               Text(event.description),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
