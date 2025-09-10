import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/account/data/models/address_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class AddressRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  AddressRemoteDataSource({required this.firestore, required this.auth});

  Future<Either<Failure, AddressModel>> addAddress({
    required bool isDefault,
    required String country,
    required String buildingNo,
    required String fullName,
    required String landMark,
    required String area,
    required String town,
    required String state,
    required String mobileNo,
    required String pincode,
  }) async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        return left(Failure(message: "No user logged in"));
      }

      final addressRef = firestore
          .collection('users')
          .doc(user.uid)
          .collection('address')
          .doc();

      final address = AddressModel(
        id: addressRef.id,
        country: country,
        isDefault: isDefault,
        buildingNo: buildingNo,
        fullName: fullName,
        landMark: landMark,
        area: area,
        town: town,
        state: state,
        mobileNo: mobileNo,
        pincode: pincode,
      );
      final addressCollection = firestore
          .collection('users')
          .doc(user.uid)
          .collection('address');
      final batch = firestore.batch();
      if (isDefault) {
        final allDocs = await addressCollection.get();
        for (var doc in allDocs.docs) {
          batch.update(doc.reference, {'isDefault': false});
        }
      }
      batch.set(addressRef, address.toJson());
      await batch.commit();

      return right(address);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, AddressModel>> updateAddress({
    required bool isDefault,
    required String id,
    required String country,
    required String buildingNo,
    required String fullName,
    required String landMark,
    required String area,
    required String town,
    required String state,
    required String mobileNo,
    required String pincode,
  }) async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        return left(Failure(message: 'User not logged in'));
      }
      final address = AddressModel(
        id: id,
        country: country,
        isDefault: isDefault,
        buildingNo: buildingNo,
        fullName: fullName,
        landMark: landMark,
        area: area,
        town: town,
        state: state,
        mobileNo: mobileNo,
        pincode: pincode,
      );

      await firestore
          .collection('users')
          .doc(user.uid)
          .collection('address')
          .doc(id)
          .update(address.toJson());
      return right(address);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<AddressModel>>> getAddresses() async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        return left(Failure(message: 'User not logged in'));
      }

      final snapshots = await firestore
          .collection('users')
          .doc(user.uid)
          .collection('address')
          .get();

      final addresses = snapshots.docs.map((doc) {
        final data = doc.data();

        return AddressModel.fromJson({...data, 'id': doc.id});
      }).toList();

      return right(addresses);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, Unit>> updateDefaultAddress(String addressId) async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        return left(Failure(message: 'User not logged in'));
      }
      final addressCollection = firestore
          .collection('users')
          .doc(user.uid)
          .collection('address');
      final batch = firestore.batch();
      final allDocs = await addressCollection.get();
      for (var doc in allDocs.docs) {
        batch.update(doc.reference, {'isDefault': false});
      }
      batch.update(addressCollection.doc(addressId), {'isDefault': true});
      await batch.commit();
      return right(unit);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, Unit>> deleteAddress(String addressId) async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        return left(Failure(message: 'User not logged in'));
      }
      await firestore
          .collection('users')
          .doc(user.uid)
          .collection('address')
          .doc(addressId)
          .delete();
      return right(unit);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
