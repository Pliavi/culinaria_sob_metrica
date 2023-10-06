import { LucidModel, RelationQueryBuilderContract } from '@ioc:Adonis/Lucid/Orm'
import Food from 'App/Models/Food'
import Place from 'App/Models/Place'

type PreloadQuery<T extends LucidModel> = RelationQueryBuilderContract<T, any>

const preloadPlace = [
  'place',
  (query: PreloadQuery<typeof Place>) => {
    query.select('name')
  },
] as const

export default class FoodRepository {
  constructor() {}

  public getReviewedBy(userId: string) {
    return Food.query()
      .whereHas('reviews', (query) => {
        query.where('user_id', userId)
      })
      .preload(...preloadPlace)
      .orderBy('created_at', 'desc')
      .exec()
  }

  public getUnreviewedBy(userId: string) {
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
