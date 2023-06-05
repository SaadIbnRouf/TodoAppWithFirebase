import 'package:flutter/material.dart';
import 'package:todoappwithfirebase/model/todoDataModel.dart';
import 'package:todoappwithfirebase/service/localDatabaseHelper.dart';

class UpdateTodoView extends StatefulWidget {
  TodoDataModel todoDataModel;
  UpdateTodoView({Key? key, required this.todoDataModel}) : super(key: key);

  @override
  State<UpdateTodoView> createState() => _UpdateTodoViewState();
}

class _UpdateTodoViewState extends State<UpdateTodoView> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  late String title = widget.todoDataModel.title;
  late String description = widget.todoDataModel.description;
  void initState() {
    // TODO: implement initState
    _titleController.text = title;
    _descriptionController.text = description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: _titleController,
              autofocus: true,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(width: 15.0),
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: _descriptionController,
              autofocus: true,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              title = _titleController.value.text;
              description = _descriptionController.value.text;
              widget.todoDataModel.title = title;
              widget.todoDataModel.description = description;
              LocalDataBaseHelper.updateTask(widget.todoDataModel);
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
