class FoodServiceException implements Exception {
  final Exception previousException;
  final String message;

  FoodServiceException(this.previousException, this.message);
}
