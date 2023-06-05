import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../service/paymentService.dart';

class ApiBlogDetailView extends StatefulWidget {
  ApiBlogDetailView({Key? key, required this.id}) : super(key: key);
  int id;

  @override
  State<ApiBlogDetailView> createState() => _ApiBlogDetailViewState();
}

class _ApiBlogDetailViewState extends State<ApiBlogDetailView> {
  PaymentService obj = PaymentService();
  final dio = Dio();
  Map? value;
  void initState() {
    // TODO: implement initState
    super.initState();
    getHttp();
  }

  void getHttp() async {
    final response = await dio
        .get('https://jsonplaceholder.typicode.com/posts/${widget.id}');
    value = response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (value == null)
          ? const Center(
              child: Text('Data not found'),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  style: ListTileStyle.list,
                  title: Text(value!['title']),
                  subtitle: Text(value!['body']),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      obj.makePayment(amount: '5', currency: 'USD');
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 2,
                        backgroundColor: Colors.white30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                    child: Text('Buy Me a Coffee'),
                  ),
                )
              ],
            ),
    );
  }
}
