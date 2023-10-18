import 'package:csm_front/models/food_model.dart';
import 'package:csm_front/services/api_instance.dart';
import 'package:csm_front/services/food_service/food_service_exceptions.dart';
import 'package:csm_front/services/food_service/food_service_types.part.dart';
import 'package:result_dart/result_dart.dart';

class FoodService {
  AsyncFoodListResult listFoods({required String state}) async {
    assert(state == "all" || state == "reviewed" || state == "unreviewed");

    try {
      final res = await api.get(
        "foods",
        queryParameters: {"state": state},
      );

      final foods = res.data!
          .map((data) => FoodModel.fromJson(data))
          .toList(growable: false);

      return foods.toSuccess();
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
