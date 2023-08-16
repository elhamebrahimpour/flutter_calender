part of 'change_cubit.dart';

@immutable
sealed class CubitState {}

class CubitInitial extends CubitState {}

class ChangeFocusedDay extends CubitState {
  final DateTime focusDateTime;
  ChangeFocusedDay(this.focusDateTime);
}

class UpdateScreen extends CubitState {}
