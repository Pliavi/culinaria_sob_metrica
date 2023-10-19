// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FoodModel _$FoodModelFromJson(Map<String, dynamic> json) {
  return _FoodModel.fromJson(json);
}

/// @nodoc
mixin _$FoodModel {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get price => throw _privateConstructorUsedError;
  PhotoModel? get photo => throw _privateConstructorUsedError;
  PlaceModel? get place => throw _privateConstructorUsedError;
  List<ReviewModel>? get reviews => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FoodModelCopyWith<FoodModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodModelCopyWith<$Res> {
  factory $FoodModelCopyWith(FoodModel value, $Res Function(FoodModel) then) =
      _$FoodModelCopyWithImpl<$Res, FoodModel>;
  @useResult
  $Res call(
      {int? id,
      String name,
      String? price,
      PhotoModel? photo,
      PlaceModel? place,
      List<ReviewModel>? reviews});

  $PhotoModelCopyWith<$Res>? get photo;
  $PlaceModelCopyWith<$Res>? get place;
}

/// @nodoc
class _$FoodModelCopyWithImpl<$Res, $Val extends FoodModel>
    implements $FoodModelCopyWith<$Res> {
  _$FoodModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? price = freezed,
    Object? photo = freezed,
    Object? place = freezed,
    Object? reviews = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as PhotoModel?,
      place: freezed == place
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as PlaceModel?,
      reviews: freezed == reviews
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<ReviewModel>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PhotoModelCopyWith<$Res>? get photo {
    if (_value.photo == null) {
      return null;
    }

    return $PhotoModelCopyWith<$Res>(_value.photo!, (value) {
      return _then(_value.copyWith(photo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PlaceModelCopyWith<$Res>? get place {
    if (_value.place == null) {
      return null;
    }

    return $PlaceModelCopyWith<$Res>(_value.place!, (value) {
      return _then(_value.copyWith(place: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FoodModelImplCopyWith<$Res>
    implements $FoodModelCopyWith<$Res> {
  factory _$$FoodModelImplCopyWith(
          _$FoodModelImpl value, $Res Function(_$FoodModelImpl) then) =
      __$$FoodModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String name,
      String? price,
      PhotoModel? photo,
      PlaceModel? place,
      List<ReviewModel>? reviews});

  @override
  $PhotoModelCopyWith<$Res>? get photo;
  @override
  $PlaceModelCopyWith<$Res>? get place;
}

/// @nodoc
class __$$FoodModelImplCopyWithImpl<$Res>
    extends _$FoodModelCopyWithImpl<$Res, _$FoodModelImpl>
    implements _$$FoodModelImplCopyWith<$Res> {
  __$$FoodModelImplCopyWithImpl(
      _$FoodModelImpl _value, $Res Function(_$FoodModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? price = freezed,
    Object? photo = freezed,
    Object? place = freezed,
    Object? reviews = freezed,
  }) {
    return _then(_$FoodModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as PhotoModel?,
      place: freezed == place
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as PlaceModel?,
      reviews: freezed == reviews
          ? _value._reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<ReviewModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodModelImpl implements _FoodModel {
  const _$FoodModelImpl(
      {this.id,
      required this.name,
      this.price,
      this.photo,
      this.place,
      final List<ReviewModel>? reviews})
      : _reviews = reviews;

  factory _$FoodModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String name;
  @override
  final String? price;
  @override
  final PhotoModel? photo;
  @override
  final PlaceModel? place;
  final List<ReviewModel>? _reviews;
  @override
  List<ReviewModel>? get reviews {
    final value = _reviews;
    if (value == null) return null;
    if (_reviews is EqualUnmodifiableListView) return _reviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'FoodModel(id: $id, name: $name, price: $price, photo: $photo, place: $place, reviews: $reviews)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.place, place) || other.place == place) &&
            const DeepCollectionEquality().equals(other._reviews, _reviews));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, price, photo, place,
      const DeepCollectionEquality().hash(_reviews));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodModelImplCopyWith<_$FoodModelImpl> get copyWith =>
      __$$FoodModelImplCopyWithImpl<_$FoodModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodModelImplToJson(
      this,
    );
  }
}

abstract class _FoodModel implements FoodModel {
  const factory _FoodModel(
      {final int? id,
      required final String name,
      final String? price,
      final PhotoModel? photo,
      final PlaceModel? place,
      final List<ReviewModel>? reviews}) = _$FoodModelImpl;

  factory _FoodModel.fromJson(Map<String, dynamic> json) =
      _$FoodModelImpl.fromJson;

  @override
  int? get id;
  @override
  String get name;
  @override
  String? get price;
  @override
  PhotoModel? get photo;
  @override
  PlaceModel? get place;
  @override
  List<ReviewModel>? get reviews;
  @override
  @JsonKey(ignore: true)
  _$$FoodModelImplCopyWith<_$FoodModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
