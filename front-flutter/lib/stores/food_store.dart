import 'package:csm_front/models/food_model.dart';
import 'package:csm_front/services/food_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

class FoodStore extends Store<FoodModel?> {
  FoodStore() : super(null);

  void getFood({
    required int id,
  }) async {
    setLoading(true);
    try {
      final food = await FoodService().getFood(id: id);
      update(food);
    } on DioException catch (e) {
      setError(e.message);
      return;
    }

    setLoading(false);
  }
}
