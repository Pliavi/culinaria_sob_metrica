import 'package:csm_front/interactor/services/login_service/login_service.dart';
import 'package:csm_front/interactor/validators/string_validators.dart';
import 'package:csm_front/ui/pages/login_page/login_page_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef FormKey = GlobalKey<FormState>;

class LoginPageCubit extends Cubit<LoginPageState> with StringValidatorsMixin {
  LoginPageCubit() : super(const LoginPageInitState());

  String _email = '';
  String _password = '';

  setEmail(value) => _email = value;
  setPassword(value) => _password = value;

  void onLoginButtonPressed(FormKey formKey) async {
    emit(const LoginPageLoadingState());

    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();

      final result = await LoginService.login(_email, _password);

      result.fold(
        (user) => emit(const LoginPageSuccessState(true)),
        (error) => emit(LoginPageErrorState(error.toString())),
      );
    }
  }

  void checkIsLogged() async {
    final result = await LoginService.checkIsLogged();

    result.fold(
      (isLogged) {
        emit(switch (isLogged) {
          true => const LoginPageSuccessState(true),
          false => const LoginPageInitState(),
        });
      },
      (error) => emit(LoginPageErrorState(error.toString())),
    );
  }

  void logout() async {
    final result = await LoginService.logout();

    result.fold(
      (isLogged) {
        emit(switch (isLogged) {
          true => const LoginPageInitState(),
          false => const LoginPageSuccessState(true),
        });
      },
      (error) => emit(LoginPageErrorState(error.toString())),
    );
  }
}
