import 'package:csm_front/models/food_model.dart';
import 'package:csm_front/services/food_service/food_service_exceptions.dart';
import 'package:result_dart/result_dart.dart';

typedef FoodList = List<FoodModel>;

typedef AsyncFoodListResult = AsyncResult<FoodList, FoodServiceException>;
typedef ListFoodResult = Result<FoodList, FoodServiceException>;
typedef AsyncFoodResult = AsyncResult<FoodModel, FoodServiceException>;
typedef FoodResult = Result<FoodModel, FoodServiceException>;
