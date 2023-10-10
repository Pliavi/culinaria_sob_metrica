declare module '@ioc:CSM/Repositories' {
  import FoodRepository from 'App/Repositories/FoodRepository'
  import PhotoRepository from 'App/Repositories/PhotoRepository'
  import PlaceRepository from 'App/Repositories/PlaceRepository'

  const FoodRepositorySingleton: FoodRepository
  const PhotoRepositorySingleton: PhotoRepository
  const PlaceRepositorySingleton: PlaceRepository

  export {
    FoodRepositorySingleton as FoodRepository,
    PhotoRepositorySingleton as PhotoRepository,
    PlaceRepositorySingleton as PlaceRepository,
  }
}
