import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/auth/data/models/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firebaseFirestore;

  AuthRemoteDataSource({required this.auth, required this.firebaseFirestore});
  Future<Either<Failure, AuthModel>> signUp(
    String fullName,
    String email,
    String password,
  ) async {
    try {
      final user = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await user.user?.updateDisplayName(fullName);
      await firebaseFirestore.collection('users').doc(user.user?.uid).set({
        'id': user.user?.uid,
        'fullName': fullName,
        'email': email,
      });
      return right(
        AuthModel(
          id: user.user?.uid ?? '',
          email: user.user?.email ?? '',
          fullName: fullName,
        ),
      );
    } on FirebaseAuthException catch (e) {
      return left(Failure(message: e.code));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, AuthModel>> signIn(
    String email,
    String password,
  ) async {
    try {
      final user = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(
        AuthModel(
          id: user.user?.uid ?? '',
          email: user.user?.email ?? '',
          fullName: '',
        ),
      );
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.code));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, AuthModel>> signOut() async {
    try {
      await auth.signOut();
      return right(AuthModel(id: '', email: '', fullName: ''));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, AuthModel>> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return right(AuthModel(id: '', email: email, fullName: ''));
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.code));
    }
  }
}
