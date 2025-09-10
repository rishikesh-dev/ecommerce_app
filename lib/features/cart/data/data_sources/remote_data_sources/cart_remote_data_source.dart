import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class CartRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  CartRemoteDataSource({required this.firestore, required this.auth});
  Future<Either<Failure, List<ProductModel>>> addToCart(
    ProductModel product,
  ) async {
    try {
      final docRef = firestore
          .collection('users')
          .doc(auth.currentUser?.uid)
          .collection('carts')
          .doc(product.id.toString());

      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Update quantity
        final existingProduct = ProductModel.fromJson(docSnapshot.data()!);
        final updatedProduct = existingProduct.copyWith(
          quantity: existingProduct.quantity + product.quantity,
        );
        await docRef.set(updatedProduct.toJson());
      } else {
        // Add new product
        await docRef.set(product.toJson());
      }

      return right([product]);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, ProductModel>> removeFromCart(
    ProductModel product,
  ) async {
    try {
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('carts')
          .doc('${product.id}')
          .delete();
      return right(product);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<ProductModel>>> getCartItems() async {
    try {
      final snapshot = await firestore
          .collection('users')
          .doc(auth.currentUser?.uid)
          .collection('carts')
          .get();
      final products = snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
      return right(products);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
