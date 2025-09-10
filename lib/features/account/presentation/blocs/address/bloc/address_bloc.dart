import 'package:ecommerce_app/features/account/domain/entitites/address_entity.dart';
import 'package:ecommerce_app/features/account/domain/use_cases/address/add_address_use_case.dart';
import 'package:ecommerce_app/features/account/domain/use_cases/address/delete_address_use_case.dart';
import 'package:ecommerce_app/features/account/domain/use_cases/address/get_address_use_case.dart';
import 'package:ecommerce_app/features/account/domain/use_cases/address/update_address_use_case.dart';
import 'package:ecommerce_app/features/account/domain/use_cases/user/set_default_address_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddAddressUseCase addAddressUseCase;
  final GetAddressUseCase getAddressUseCase;
  final DeleteAddressUseCase deleteAddressUseCase;
  final SetDefaultAddressUseCase setDefaultAddressUseCase;
  final UpdateAddressUseCase updateAddressUseCase;
  AddressBloc({
    required this.addAddressUseCase,
    required this.getAddressUseCase,
    required this.deleteAddressUseCase,
    required this.setDefaultAddressUseCase,
    required this.updateAddressUseCase,
  }) : super(AddressInitial()) {
    on<AddAddressEvent>((event, emit) async {
      emit(AddressLoading());
      final failureOrAddress = await addAddressUseCase(
        isDefault: event.isDefault,
        country: event.country,
        buildingNo: event.buildingNo,
        fullName: event.fullName,
        landMark: event.landMark,
        town: event.town,
        area: event.area,
        state: event.state,
        mobileNo: event.mobileNo,
        pincode: event.pincode,
      );

      await failureOrAddress.fold(
        (failure) async => emit(AddressError(message: failure.message)),
        (_) async {
          // 🔑 Reload full list instead of emitting only new address
          final refreshed = await getAddressUseCase();
          refreshed.fold(
            (failure) => emit(AddressError(message: failure.message)),
            (addresses) => emit(AddressLoaded(addresses: addresses)),
          );
        },
      );
    });

    on<LoadAddressEvent>((event, emit) async {
      emit(AddressLoading());
      final failureOrAddress = await getAddressUseCase();
      failureOrAddress.fold(
        (failure) => emit(AddressError(message: failure.message)),
        (address) => emit(AddressLoaded(addresses: address)),
      );
    });
    on<SetDefaultAddressEvent>((event, emit) async {
      final result = await setDefaultAddressUseCase(event.id);
      await result.fold(
        (failure) async => emit(AddressError(message: failure.message)),
        (_) async {
          final refreshed = await getAddressUseCase();
          refreshed.fold(
            (failure) => emit(AddressError(message: failure.message)),
            (addresses) => emit(AddressLoaded(addresses: addresses)),
          );
        },
      );
    });
    on<DeleteAddressEvent>((event, emit) async {
      final result = await deleteAddressUseCase(event.id);

      await result.fold(
        (failure) async => emit(AddressError(message: failure.message)),
        (_) async {
          final refreshed = await getAddressUseCase();
          refreshed.fold(
            (failure) => emit(AddressError(message: failure.message)),
            (addresses) => emit(AddressLoaded(addresses: addresses)),
          );
        },
      );
    });
    on<UpdateAddressEvent>((event, emit) async {
      final result = await updateAddressUseCase(
        id: event.id,
        isDefault: event.isDefault,
        country: event.country,
        buildingNo: event.buildingNo,
        fullName: event.fullName,
        landMark: event.landMark,
        town: event.town,
        area: event.area,
        state: event.state,
        mobileNo: event.mobileNo,
        pincode: event.pincode,
      );

      await result.fold(
        (failure) async => emit(AddressError(message: failure.message)),
        (_) async {
          final refreshed = await getAddressUseCase();
          refreshed.fold(
            (failure) => emit(AddressError(message: failure.message)),
            (addresses) => emit(AddressLoaded(addresses: addresses)),
          );
        },
      );
    });
  }
}
