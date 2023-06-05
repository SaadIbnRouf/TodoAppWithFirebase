import 'package:flutter/material.dart';
import 'package:todoappwithfirebase/view/blogView/apiBlogDetailView.dart';

class ApiBlogDataView extends StatefulWidget {
  List value;
  ApiBlogDataView({Key? key, required this.value}) : super(key: key);

  @override
  State<ApiBlogDataView> createState() => _ApiBlogDataViewState();
}

class _ApiBlogDataViewState extends State<ApiBlogDataView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Page'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(10.0),
        itemCount: widget.value.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ApiBlogDetailView(id: widget.value[index]['id']),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white12,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Card(
                child: ListTile(
                  style: ListTileStyle.drawer,
                  title: Text(widget.value[index]['title']),
                  subtitle: Text(widget.value[index]['body']),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 10.0,
          );
        },
      ),
    );
  }
}
