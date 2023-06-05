import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentService {
  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(
      {required String amount, required String currency}) async {
    try {
      // step 1 create payment Intent
      paymentIntentData = await createPaymentIntent(amount, currency);

      // initialize payment sheet
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            // Main params
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            merchantDisplayName: 'Flutter Stripe Store Demo',

            // customer params
            customerId: paymentIntentData!['customer'],
            // customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],

            // extra params

            primaryButtonLabel: 'Pay now',
            // applePay: const PaymentSheetApplePay(
            //   merchantCountryCode: 'US',
            // ),
            googlePay: const PaymentSheetGooglePay(
              merchantCountryCode: 'US',
              testEnv: true,
            ),
          ),
        );
        displayPaymentSheet();
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Make Payment Error',
        backgroundColor: Colors.red,
      );
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        //Clear paymentIntent variable after successful payment
        paymentIntentData = null;
      });
      Fluttertoast.showToast(
        msg: 'Payment Successful',
        backgroundColor: Colors.blue,
      );
    } on Exception catch (e) {
      if (e is StripeException) {
        Fluttertoast.showToast(
          msg: 'Payment Error',
          backgroundColor: Colors.red,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Unforseen Error',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error',
        backgroundColor: Colors.red,
      );
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };
      final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
      var response = await http.post(
        url,
        headers: {
          'Authorization':
              'Bearer sk_test_51NFTDaITDwxwMoiGp38pjjXKruDbHm7Q4VkzvZFwQ3rDfjHYJVZPg3w1loOhdHxr1qrdx51TWefzRztfvpOzJyDN003a41A4g7',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return jsonDecode(response.body);
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Create Payment Error',
        backgroundColor: Colors.red,
      );
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
