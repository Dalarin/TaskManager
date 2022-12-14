import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/providers/constants.dart' as constant;
import 'package:task_manager/providers/storage_manager.dart';
import 'package:task_manager/providers/validator.dart';

import '../../models/user.dart';
import '../../repository/user_repository.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc(this._userRepository) : super(RegisterInitial()) {
    on<RegisterStarted>((event, emit) => _registerEvent(event, emit));
  }

  _registerEvent(RegisterStarted event, emit) async {
    try {
      if (event.fio.isEmpty ||
          event.password.isEmpty ||
          event.email.isEmpty ||
          event.phone.isEmpty) {
        emit(const RegisterError(
          'Заполните данные и попробуйте снова',
        ));
        emit(RegisterInitial());
      } else {
        if (!Validator.validateEmail(event.email)) {
          emit(const RegisterError('Введите email в формате email@email.ru'));
          return;
        }
        if (!Validator.validatePhone(event.phone)) {
          emit(const RegisterError('Введите телефон в формате 78005553535'));
          return;
        }
        if (!Validator.validateUsername(event.fio)) {
          emit(const RegisterError('Введите имя и фамилию в формате Иван Иванов'));
          return;
        }
        emit(RegisterLoading());
        final user = await _userRepository.createUser(User(
          password: event.password,
          phone: event.phone,
          email: event.email,
          fio: event.fio,
        ));
        if (user != null) {
          constant.user = user;
          StorageManager.saveUser(user);
          emit(RegisterLoaded(user));
        } else {
          emit(const RegisterError('Ошибка регистрации'));
        }
      }
    } on SocketException {
      emit(const RegisterError(
        'Ошибка. Проверьте интернет соединение и попробуйте снова',
      ));
      emit(RegisterInitial());
    } on Exception {
      emit(const RegisterError('Ошибка регистрации'));
    }
  }
}
