import 'package:csm_front/interactor/services/food_service/food_service.dart';
import 'package:csm_front/ui/pages/home_page/home_page_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit({
    required this.foodService,
  }) : super(const HomePageLoadingState());

  final FoodService foodService;

  Future<void> getFoods() async {
    emit(const HomePageLoadingState());

    final foods = await foodService.listFoods(state: FoodListState.unreviewed);

    foods.fold(
      (foods) => emit(HomePageSuccessState(foods)),
      (error) => emit(HomePageErrorState(error.message)),
    );
  }
}
