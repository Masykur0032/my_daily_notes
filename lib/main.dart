import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_daily_notes/page/show.dart';

import 'page/mainpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/main': (context) => MainPage(),
          '/show': (context) => ShowPage(),
        },
        debugShowCheckedModeBanner: false,
        title: 'My Daily Notes',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: Home());
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      //appBar: AppBar(title: Text("My Daily Notes"),),
      body: Container(
        padding: EdgeInsets.only(top: 150),
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              'My',
              style: TextStyle(
                  fontFamily: 'Sacramento',
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Daily Notes',
              style: TextStyle(
                  fontFamily: 'Sacramento',
                  fontSize: 80,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            FlatButton(
              minWidth: 100,
              height: 50,
              child: Text(
                "Note",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              color: Colors.black,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, "/main");
              },
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              minWidth: 100,
              height: 50,
              child: Text(
                "Exit",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              color: Colors.black,
              textColor: Colors.white,
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
