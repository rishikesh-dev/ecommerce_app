import 'dart:async';

import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

abstract interface class PaymentOption {
  Future<Either<Failure, Unit>> processPayment({
    required String orderId,
    required String description,
    required String currency,
    required double amount,
    required String method,
  });
}

class PaymentRemoteDataSource implements PaymentOption {
  final _paymentSuccessController = StreamController<bool>.broadcast();

  final Razorpay _razorpay;
  final FirebaseAuth _auth;

  PaymentRemoteDataSource({
    required Razorpay razorpay,
    required FirebaseAuth auth,
  }) : _razorpay = razorpay,
       _auth = auth {
    // Attach event listeners
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  @override
  Future<Either<Failure, Unit>> processPayment({
    required String orderId,
    required String description,
    required String currency,
    required double amount,
    required String method,
  }) async {
    final completer = Completer<Either<Failure, Unit>>();

    void successHandler(PaymentSuccessResponse _) {
      if (!completer.isCompleted) completer.complete(right(unit));
    }

    void errorHandler(PaymentFailureResponse _) {
      if (!completer.isCompleted) {
        completer.complete(left(Failure(message: "Payment failed")));
      }
    }

    void walletHandler(ExternalWalletResponse _) {
      if (!completer.isCompleted) {
        completer.complete(left(Failure(message: "External wallet used")));
      }
    }

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, successHandler);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, errorHandler);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, walletHandler);

    try {
      final options = {
        'key': 'rzp_test_RCFQmq2xIAlrnB',
        'amount': amount,
        'currency': currency,
        'name': _auth.currentUser?.displayName ?? '',
        'order_id': orderId,
        'description': description,

        'prefill': {'email': _auth.currentUser?.email ?? '', 'method': method},
      };

      _razorpay.open(options);
    } catch (e) {
      if (!completer.isCompleted) {
        completer.complete(left(Failure(message: e.toString())));
      }
    }

    return completer.future;
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    _paymentSuccessController.add(true);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _paymentSuccessController.add(true);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    _paymentSuccessController.add(true);
  }

  void dispose() {
    _razorpay.clear();
    _paymentSuccessController.close();
  }
}
