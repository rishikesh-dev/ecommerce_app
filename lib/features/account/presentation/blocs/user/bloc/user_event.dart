part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class GetUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final String fullName;

  UpdateUserEvent({required this.fullName});
}
