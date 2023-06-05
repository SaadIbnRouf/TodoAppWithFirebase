import 'package:flutter/material.dart';
import '../../model/todoDataModel.dart';
import 'myCardView.dart';

class TodoGridView extends StatelessWidget {
  List<TodoDataModel> data;
  TodoGridView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return MyCardView(todoDataModel: data[index]);
        });
  }
}
