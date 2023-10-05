import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Food from 'App/Models/Food'
import StoreFoodValidator from 'App/Validators/StoreFoodValidator'
import FoodRepository from 'App/Repositories/FoodRepository'
import { match } from 'ts-pattern'
import { schema } from '@ioc:Adonis/Core/Validator'
import crypto from 'crypto'

const foodStateEnum = ['reviewed', 'unreviewed', 'all'] as const
type FoodState = (typeof foodStateEnum)[number]

export default class UserFoodsController {
  private foodRepository = new FoodRepository()

  public async index({ request, auth }: HttpContextContract) {
    await request.validate({
      schema: schema.create({
        state: schema.enum(foodStateEnum),
      }),
    })

    const repo = this.foodRepository
    const userId = auth.user?.id
    const foodState: FoodState = request.input('state')

    const foods = match(foodState)
      .with('reviewed', () => repo.getReviewedBy(userId!))
      .with('unreviewed', () => repo.getUnreviewedBy(userId!))
      .with('all', () => repo.getAll())
      .exhaustive()

    return foods
  }

  public async store({ request }: HttpContextContract) {
    await request.validate(StoreFoodValidator)

    const foodRequestData = request.only(['name', 'price'])
    const foodImage = request.file('image')!
    const foodImageName = crypto.randomUUID() + '.' + foodImage.extname

    const food = await Food.create({
      ...foodRequestData,
      image: foodImageName,
    })

    await foodImage.move('public/images', { name: food.image })

    return food
  }

  public async show({ request }: HttpContextContract) {
    const foodId = request.param('id')
    const food = await Food.query()
      .where('id', foodId)
      .preload('place')
      .preload('reviews', (query) => {
        query.preload('user')
      })
      .firstOrFail()

    return food
  }
}
