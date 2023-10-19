sealed class LoginPageState {
  const LoginPageState();

  T on<T>({
    required T Function() init,
    Function(LoginPageLoadingState state)? loading,
    Function(LoginPageErrorState state)? error,
    Function(LoginPageSuccessState state)? success,
  }) {
    return switch (this) {
      LoginPageInitState _ => init(),
      LoginPageLoadingState s => loading?.call(s) ?? init(),
      LoginPageErrorState s => error?.call(s) ?? init(),
      LoginPageSuccessState s => success?.call(s) ?? init(),
    };
  }
}

class LoginPageInitState extends LoginPageState {
  const LoginPageInitState();
}

class LoginPageLoadingState extends LoginPageState {
  const LoginPageLoadingState();
}

class LoginPageErrorState extends LoginPageState {
  const LoginPageErrorState(this.error);

  final String error;
}

class LoginPageSuccessState extends LoginPageState {
  const LoginPageSuccessState(this.isLogged);

  final bool isLogged;
}
