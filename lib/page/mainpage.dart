import 'package:flutter/material.dart';
import 'package:my_daily_notes/dbhelper.dart';
import 'package:my_daily_notes/model/notes.dart';
import 'package:my_daily_notes/page/form.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class MainPage extends StatefulWidget {
  @override
  MainState createState() => MainState();
}

class MainState extends State<MainPage> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Note> itemList;
  int getId = 0;
  String show = "test";
  String showTitle = "test";
  String showContent = "test";

  void showNote() {
    setState(() {
      show = "Title : \n" + showTitle + "\n\nContent : \n" + showContent;
    });
  }

  showDeleteDialog() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.yellowAccent,
            title: Text("Are you sure to delete this item?"),
            actions: [
              RaisedButton(
                color: Colors.black,
                textColor: Colors.white,
                child: Text("Yes"),
                onPressed: () async {
                  int result = await dbHelper.delete(getId);
                  if (result > 0) {
                    updateListView();
                  }
                  Navigator.pop(context);
                },
              ),
              RaisedButton(
                color: Colors.black,
                textColor: Colors.white,
                child: Text("No"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => updateListView());
    if (itemList == null) {
      itemList = List<Note>();
    }

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
      ),
      body: Column(children: [
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: createListView(),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 10),
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            child: RaisedButton(
              color: Colors.black,
              textColor: Colors.white,
              child: Text('Add Note'),
              onPressed: () async {
                var item = await navigateToEntryForm(context, null);
                if (item != null) {
                  int result = await dbHelper.insert(item);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
            ),
          ),
        )
      ]),
    );
  }

  Future<Note> navigateToEntryForm(BuildContext context, Note note) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return NoteForm(note);
    }));
    return result;
  }

  ListView createListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.yellowAccent,
          elevation: 2.0,
          child: ListTile(
            title: Text(
              this.itemList[index].title,
              style: TextStyle(fontSize: 40, fontFamily: 'Grand'),
            ),
            subtitle: Row(
              children: [
                Text(this.itemList[index].date),
              ],
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.black,
              ),
              onTap: () async {
                getId = itemList[index].id;
                showDeleteDialog();
              },
            ),
            onTap: () async {
              showTitle = itemList[index].title;
              showContent = itemList[index].body;
              showNote();
              Navigator.pushNamed(context, '/show', arguments: show);
            },
          ),
        );
      },
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Note>> itemListFuture = dbHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
