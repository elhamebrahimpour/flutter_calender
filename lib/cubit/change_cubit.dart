import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'change_state.dart';

class AppCubit extends Cubit<CubitState> {
  AppCubit() : super(CubitInitial());
  void onChanged(DateTime dateTime) => emit(
        ChangeFocusedDay(dateTime),
      );

  void onUpdateScreen() {
    emit(UpdateScreen());
  }
}
