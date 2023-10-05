import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Food from 'App/Models/Food'
import { schema, rules } from '@ioc:Adonis/Core/Validator'

export default class FoodReviewsController {
  public async store({ request }: HttpContextContract) {
    await request.validate({
      schema: schema.create({
        food_id: schema.number(),
        rating: schema.number([rules.range(1, 5)]),
        comment: schema.string({ trim: true }),
      }),
    })

    const foodId = request.param('food_id')
    const reviewRequestData = request.only(['rating', 'comment'])

    const food = await Food.findOrFail(foodId)

    const review = await food.related('reviews').create(reviewRequestData)

    return review
  }
}
