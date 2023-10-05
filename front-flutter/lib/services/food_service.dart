import 'package:csm_front/models/food_model.dart';
import 'package:csm_front/services/api_instance.dart';

typedef JSONType = Map<String, dynamic>;

class FoodService {
  Future<List<FoodModel>> listFoods({required String state}) async {
    assert(state == "all" || state == "reviewed" || state == "unreviewed");

    final res = await api.get<List>(
      "foods",
      queryParameters: {"state": state},
    );

    final foods = res.data!
        .map((data) => FoodModel.fromJson(data))
        .toList(growable: false);

    return foods;
  }

  Future<FoodModel> getFood({required int id}) async {
    final res = await api.get<JSONType>("foods/$id");

    final food = FoodModel.fromJson(res.data!);

    return food;
  }
}
