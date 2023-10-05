import 'package:csm_front/models/food_model.dart';
import 'package:csm_front/services/food_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

class FoodsStore extends Store<List<FoodModel>> {
  FoodsStore() : super([]);

  void fetchFoods() async {
    setLoading(true);
    try {
      final foods = await FoodService().listFoods(state: "all");
      update(foods);
    } on DioException catch (e) {
      setError(e.message);
      return;
    }

    setLoading(false);
  }
}
