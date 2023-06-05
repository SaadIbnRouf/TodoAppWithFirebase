import 'package:flutter/material.dart';
import 'package:todoappwithfirebase/model/todoDataModel.dart';
import '../../service/localDatabaseHelper.dart';

class NewTodoView extends StatefulWidget {
  const NewTodoView({Key? key}) : super(key: key);

  @override
  State<NewTodoView> createState() => _NewTodoViewState();
}

class _NewTodoViewState extends State<NewTodoView> {
  String value = "";
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _titleController,
                autofocus: true,
                style: TextStyle(
                  fontSize: 16.0,
                ),
                decoration: const InputDecoration(
                  labelText: "Enter your Title",
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _descriptionController,
                autofocus: true,
                style: TextStyle(
                  fontSize: 16.0,
                ),
                decoration: const InputDecoration(
                  labelText: "Enter your thoughts",
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty) {
                  var note = TodoDataModel(
                      title: _titleController.text,
                      description: _descriptionController.text);
                  LocalDataBaseHelper.addTask(note);
                }
                Navigator.pop(context);
                setState(() {});
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
