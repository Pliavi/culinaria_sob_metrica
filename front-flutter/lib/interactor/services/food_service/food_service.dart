import 'package:csm_front/data/datasources/api_instance.dart';
import 'package:csm_front/data/models/food_model.dart';
import 'package:csm_front/interactor/services/food_service/food_service_exceptions.dart';
import 'package:csm_front/interactor/services/food_service/food_service_types.part.dart';
import 'package:result_dart/result_dart.dart';

enum FoodListState { all, reviewed, unreviewed }

class FoodService {
  AsyncFoodListResult listFoods({required FoodListState state}) async {
    try {
      final res = await api.get(
        "foods",
        queryParameters: {"state": state.name},
      );

      final foods = res.data!
          .map<FoodModel>((data) => FoodModel.fromJson(data))
          .toList(growable: false);

      return Success(foods);
    } on Exception catch (e) {
      return FoodServiceException(
        e,
        "Não foi possível listar os alimentos",
      ).toFailure();
    }
  }

  AsyncFoodResult getFood({required int id}) async {
    try {
      final res = await api.get("foods/$id");
      final food = FoodModel.fromJson(res.data!);

      return food.toSuccess();
    } on Exception catch (e) {
      return FoodServiceException(
        e,
        "Não foi possível obter o alimento",
      ).toFailure();
    }
  }
}
