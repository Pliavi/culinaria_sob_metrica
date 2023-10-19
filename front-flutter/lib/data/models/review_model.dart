import 'package:csm_front/data/models/food_model.dart';
import 'package:csm_front/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

@freezed
class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    FoodModel? food,
    UserModel? user,
    required String comment,
    required num rating,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
}
