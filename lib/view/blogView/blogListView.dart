import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'apiBlogDataView.dart';
import 'noDataView.dart';

class BlogListView extends StatefulWidget {
  const BlogListView({Key? key}) : super(key: key);

  @override
  State<BlogListView> createState() => _BlogListViewState();
}

class _BlogListViewState extends State<BlogListView> {
  final dio = Dio();
  List? value;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHttp();
  }

  void getHttp() async {
    final response =
        await dio.get('https://jsonplaceholder.typicode.com/posts/');
    print(response.data);
    value = response.data as List;
  }

  @override
  Widget build(BuildContext context) {
    return (value == null)
        ? const NoDataView()
        : ApiBlogDataView(value: value!);
  }
}
