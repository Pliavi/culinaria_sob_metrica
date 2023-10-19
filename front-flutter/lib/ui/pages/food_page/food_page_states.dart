import 'package:csm_front/data/models/food_model.dart';

sealed class FoodPageState {
  const FoodPageState();

  T on<T>({
    required T Function() init,
    T Function(FoodPageLoadingState state)? loading,
    T Function(FoodPageErrorState state)? error,
    T Function(FoodPageSuccessState state)? success,
  }) {
    return switch (this) {
      FoodPageInitState _ => init(),
      FoodPageLoadingState s => loading?.call(s) ?? init(),
      FoodPageErrorState s => error?.call(s) ?? init(),
      FoodPageSuccessState s => success?.call(s) ?? init(),
    };
  }
}

class FoodPageInitState extends FoodPageState {
  const FoodPageInitState();
}

class FoodPageLoadingState extends FoodPageState {
  const FoodPageLoadingState();
}

class FoodPageErrorState extends FoodPageState {
  const FoodPageErrorState(this.error);

  final String error;
}

class FoodPageSuccessState extends FoodPageState {
  const FoodPageSuccessState(this.food);

  final FoodModel food;
}
