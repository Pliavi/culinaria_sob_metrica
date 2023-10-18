import 'package:csm_front/models/photo_model.dart';
import 'package:csm_front/models/place_model.dart';
import 'package:csm_front/models/review_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_model.freezed.dart';
part 'food_model.g.dart';

@freezed
class FoodModel with _$FoodModel {
  const factory FoodModel({
    int? id,
    required String name,
    String? price,
    PhotoModel? photo,
    PlaceModel? place,
    List<ReviewModel>? reviews,
  }) = _FoodModel;

  factory FoodModel.fromJson(Map<String, dynamic> json) =>
      _$FoodModelFromJson(json);
}
