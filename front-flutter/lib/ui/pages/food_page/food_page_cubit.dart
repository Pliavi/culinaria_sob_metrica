import 'package:csm_front/interactor/services/food_service/food_service.dart';
import 'package:csm_front/ui/pages/food_page/food_page_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodPageCubit extends Cubit<FoodPageState> {
  FoodPageCubit({
    required this.foodService,
  }) : super(const FoodPageLoadingState());

  final FoodService foodService;

  Future<void> getFood({required int id}) async {
    emit(const FoodPageLoadingState());

    final food = await foodService.getFood(id: id);

    food.fold(
      (food) => emit(FoodPageSuccessState(food)),
      (error) => emit(FoodPageErrorState(error.message)),
    );
  }
}
