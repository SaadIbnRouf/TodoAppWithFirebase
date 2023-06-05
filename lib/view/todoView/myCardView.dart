import 'package:flutter/material.dart';
import '../../model/todoDataModel.dart';
import 'package:todoappwithfirebase/view/todoView/updateTodoView.dart';
import '../../service/localDatabaseHelper.dart';

class MyCardView extends StatefulWidget {
  MyCardView({required this.todoDataModel, Key? key}) : super(key: key);

  TodoDataModel todoDataModel;

  @override
  State<MyCardView> createState() => _MyCardViewState();
}

class _MyCardViewState extends State<MyCardView> {
  late String title = widget.todoDataModel.title;
  late String description = widget.todoDataModel.description;
  late int? value = widget.todoDataModel.id;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          width: 1.0,
          color: Colors.white54,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                LocalDataBaseHelper.deleteTask(widget.todoDataModel);
                setState(() {});
              },
              icon: Icon(Icons.delete_forever),
            ),
          ],
        ),
      ),
    );
  }
}
