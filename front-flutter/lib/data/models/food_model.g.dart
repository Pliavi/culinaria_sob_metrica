// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FoodModelImpl _$$FoodModelImplFromJson(Map<String, dynamic> json) =>
    _$FoodModelImpl(
      id: json['id'] as int?,
      name: json['name'] as String,
      price: json['price'] as String?,
      photo: json['photo'] == null
          ? null
          : PhotoModel.fromJson(json['photo'] as Map<String, dynamic>),
      place: json['place'] == null
          ? null
          : PlaceModel.fromJson(json['place'] as Map<String, dynamic>),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FoodModelImplToJson(_$FoodModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'photo': instance.photo,
      'place': instance.place,
      'reviews': instance.reviews,
    };
