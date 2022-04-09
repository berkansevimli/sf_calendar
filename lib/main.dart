import 'package:calendar_event_app/pages/event_editing_page.dart';
import 'package:calendar_event_app/provider/event_provider.dart';
import 'package:calendar_event_app/widgets/calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: AppBarTheme(color: Colors.red)),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: CalendarWidget(),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (builder) => EventEditingPage()));
          },
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
