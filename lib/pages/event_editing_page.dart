import 'package:calendar_event_app/model/event.dart';
import 'package:calendar_event_app/provider/event_provider.dart';
import 'package:calendar_event_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({Key? key, this.event}) : super(key: key);
  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        actions: buildActions(),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTitle(),
                  SizedBox(
                    height: 8,
                  ),
                  buildDateTimePickers(),
                ],
              ))),
    );
  }

  List<Widget> buildActions() => [
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent, shadowColor: Colors.transparent),
            onPressed: saveForm,
            icon: Icon(Icons.done),
            label: Text('Save'))
      ];

  Widget buildTitle() => TextFormField(
        controller: titleController,
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: "Add Title",
        ),
        onFieldSubmitted: (_) {},
        validator: (title) =>
            title != null && title.isEmpty ? "Please add title" : null,
      );

  Widget buildDateTimePickers() => Column(
        children: [buildFrom(), buildTo()],
      );
  Widget buildFrom() => buildHeader(
        header: "FROM",
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: dropDownWidget(
                    text: Utils.toDate(fromDate),
                    onClicked: () => pickFromDateTime(pickDate: true))),
            Expanded(
                child: dropDownWidget(
                    text: Utils.toTime(fromDate),
                    onClicked: () => pickFromDateTime(pickDate: false)))
          ],
        ),
      );

  Widget buildTo() => buildHeader(
        header: "To",
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: dropDownWidget(
                    text: Utils.toDate(toDate),
                    onClicked: () => pickToDateTime(pickDate: true))),
            Expanded(
                child: dropDownWidget(
                    text: Utils.toTime(toDate),
                    onClicked: () => pickToDateTime(pickDate: false)))
          ],
        ),
      );

  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          child
        ],
      );

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(() {
      fromDate = date;
    });
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(toDate,
        pickDate: pickDate, firsDate: pickDate ? fromDate : null);
    if (date == null) return;

    setState(() {
      toDate = date;
    });
  }

  Future<DateTime?> pickDateTime(DateTime initialDate,
      {required pickDate, DateTime? firsDate}) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firsDate ?? DateTime.now(),
          lastDate: DateTime(2025));

      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));

      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

  Widget dropDownWidget(
          {required String text, required VoidCallback onClicked}) =>
      ListTile(
        title: Text(text),
        onTap: onClicked,
        trailing: Icon(Icons.arrow_drop_down),
      );

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final event = Event(
          title: titleController.text,
          description: "Description",
          from: fromDate,
          to: toDate,
          isAllDay: false);

      final provider = Provider.of<EventProvider>(context, listen: false);
      provider.addEvent(event);

      Navigator.of(context).pop();
    }
  }
}
