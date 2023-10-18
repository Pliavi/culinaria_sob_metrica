import { LucidModel, RelationQueryBuilderContract } from '@ioc:Adonis/Lucid/Orm'
import Food from 'App/Models/Food'
import Place from 'App/Models/Place'
import { RepoCreateOptions } from '../../types/Repository.types'
import User from 'App/Models/User'
import Photo from 'App/Models/Photo'

type PreloadQuery<T extends LucidModel> = RelationQueryBuilderContract<T, any>

const preloadPlace = [
  'place',
  (query: PreloadQuery<typeof Place>) => {
    query.select('name')
  },
] as const

interface CreateParams {
  data: any
  place: Place
  photo: Photo
  user: User
}

export default class FoodRepository {
  constructor() {}

  public async create({ data, place, photo, user }: CreateParams, { trx }: RepoCreateOptions) {
    await Food.create(
      Object.assign<Food, Partial<Food>>(data, {
        placeId: place.id,
        photoId: photo.id,
        userId: user.id,
      }),
      { client: trx }
    )

    return await Food.create(
      {
        ...data,
        placeId: place.id,
        photoId: photo.id,
        userId: user.id,
      },
      { client: trx }
    )
  }

  public getReviewedBy(userId: number) {
    return Food.query()
      .whereHas('reviews', (query) => {
        query.where('user_id', userId)
      })
      .preload(...preloadPlace)
      .orderBy('created_at', 'desc')
      .exec()
  }

  public getUnreviewedBy(userId: number) {
    return Food.query()
      .whereDoesntHave('reviews', (query) => {
        query.where('user_id', userId)
      })
      .preload(...preloadPlace)
      .orderBy('created_at', 'desc')
      .exec()
  }

  public getAll() {
    return Food.query()
      .preload(...preloadPlace)
      .orderBy('created_at', 'desc')
      .exec()
  }
}
