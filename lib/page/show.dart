import 'package:flutter/material.dart';

class ShowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //throw UnimplementedError();
    String ItemArgs = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Daily Notes',
          style: TextStyle(fontFamily: 'Sacramento', fontSize: 30),
        ),
        leading: InkWell(
          child: Icon(Icons.keyboard_arrow_left),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: new Text(
          ItemArgs,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Grand',
          ),
        ),
      ),
    );
  }
}
