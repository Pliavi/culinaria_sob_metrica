import 'package:csm_front/data/models/food_model.dart';

sealed class HomePageState {
  const HomePageState();

  T on<T>({
    required T Function() init,
    T Function(HomePageLoadingState state)? loading,
    T Function(HomePageErrorState state)? error,
    T Function(HomePageSuccessState state)? success,
  }) {
    return switch (this) {
      HomePageInitState _ => init(),
      HomePageLoadingState s => loading?.call(s) ?? init(),
      HomePageErrorState s => error?.call(s) ?? init(),
      HomePageSuccessState s => success?.call(s) ?? init(),
    };
  }
}

class HomePageInitState extends HomePageState {
  const HomePageInitState();
}

class HomePageLoadingState extends HomePageState {
  const HomePageLoadingState();
}

class HomePageErrorState extends HomePageState {
  const HomePageErrorState(this.error);

  final String error;
}

class HomePageSuccessState extends HomePageState {
  const HomePageSuccessState(this.foods);

  final List<FoodModel> foods;
}
