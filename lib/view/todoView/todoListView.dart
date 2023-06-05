import 'package:flutter/material.dart';
import '../../model/todoDataModel.dart';
import 'myCardView.dart';

class TodoListView extends StatelessWidget {
  List<TodoDataModel> data;
  TodoListView({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return MyCardView(
            todoDataModel: data[index],
          );
        },
      ),
    );
  }
}
