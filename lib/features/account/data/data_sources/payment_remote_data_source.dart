import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/account/data/models/payment_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class PaymentRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  PaymentRemoteDataSource({required this.firestore, required this.auth});

  Future<Either<Failure, PaymentModel>> addCard({
    required String cardNumber,
    required String expiryDate,
    required String securityCode,
    required String holderName,
  }) async {
    final user = auth.currentUser;
    try {
      if (user == null) {
        return left(Failure(message: 'User is not logged In'));
      }
      final docRef = firestore
          .collection('users')
          .doc(user.uid)
          .collection('cards')
          .doc();
      final model = PaymentModel(
        cardNumber: cardNumber,
        validity: expiryDate,
        securityCode: securityCode,
        holderName: holderName,
        id: docRef.id,
        isDefault: false,
      );
      await docRef.set(model.toJson());
      return right(model);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<PaymentModel>>> getCards() async {
    final user = auth.currentUser;
    try {
      if (user == null) {
        left('User is not logged in');
      }
      final snapshots = await firestore
          .collection('users')
          .doc(user?.uid)
          .collection('cards')
          .get();
      final cards = snapshots.docs
          .map((card) => PaymentModel.fromJson(card.data()))
          .toList();
      return right(cards);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, Unit>> deleteCard(String cardId) async {
    final user = auth.currentUser;
    try {
      if (user == null) {
        return left(Failure(message: 'User is not logged In'));
      }
      await firestore
          .collection('users')
          .doc(user.uid)
          .collection('cards')
          .doc(cardId)
          .delete();
      return right(unit);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, Unit>> updateCard(PaymentModel card) async {
    final user = auth.currentUser;
    try {
      if (user == null) {
        return left(Failure(message: 'User is not logged In'));
      }
      await firestore
          .collection('users')
          .doc(user.uid)
          .collection('cards')
          .doc(card.id)
          .update(card.toJson());
      return right(unit);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, Unit>> setDefaultCard(String cardId) async {
    final user = auth.currentUser;
    try {
      if (user == null) {
        return left(Failure(message: 'User is not logged In'));
      }
      final cardsCollection = firestore
          .collection('users')
          .doc(user.uid)
          .collection('cards');
      final batch = firestore.batch();
      final cards = cardsCollection.get();
      for (var doc in (await cards).docs) {
        batch.update(doc.reference, {'isDefault': false});
      }
      batch.update(cardsCollection.doc(cardId), {'isDefault': true});

      await batch.commit();

      return right(unit);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
