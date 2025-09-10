import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/account/presentation/screens/help_center/domain/entity/customer_service_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class CustomerServiceRepository {
  Future<Either<Failure, List<CustomerServiceEntity>>> getCustomerMessages();
  Future<Either<Failure, CustomerServiceEntity>> sendMessage();
  Future<Either<Failure, CustomerServiceEntity>> editMessage();
}
