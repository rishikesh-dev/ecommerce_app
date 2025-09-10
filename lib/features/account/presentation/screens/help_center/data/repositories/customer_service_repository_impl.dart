import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/account/presentation/screens/help_center/domain/entity/customer_service_entity.dart';
import 'package:ecommerce_app/features/account/presentation/screens/help_center/domain/repositories/customer_sevice_repository.dart';
import 'package:fpdart/fpdart.dart';

class CustomerServiceRepositoryImpl extends CustomerServiceRepository {
  @override
  Future<Either<Failure, CustomerServiceEntity>> editMessage() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CustomerServiceEntity>>> getCustomerMessages() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CustomerServiceEntity>> sendMessage() {
    throw UnimplementedError();
  }
}
