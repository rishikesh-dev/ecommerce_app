import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class SavedRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  SavedRemoteDataSource({required this.auth, required this.firestore});

  Future<Either<Failure, List<ProductModel>>> getSavedItems() async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        return left(const Failure(message: 'User is not authorized'));
      }

      final snapshot = await firestore
          .collection('users')
          .doc(user.uid)
          .collection('wishlist')
          .get();

      final items = snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();

      return right(items);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, ProductModel>> saveItem(ProductModel item) async {
    try {
      await firestore
          .collection('users')
          .doc(auth.currentUser?.uid)
          .collection('wishlist')
          .doc(item.id.toString()) // use product id as doc id
          .set(item.toJson());

      return right(item);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, ProductModel>> removeItem(ProductModel item) async {
    try {
      await firestore
          .collection('users')
          .doc(auth.currentUser?.uid)
          .collection('wishlist')
          .doc(item.id.toString()) // must match the id used in saveItem
          .delete();

      return right(item);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
