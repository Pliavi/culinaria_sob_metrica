import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Food from 'App/Models/Food'
import { match } from 'ts-pattern'
import { schema } from '@ioc:Adonis/Core/Validator'
import Database from '@ioc:Adonis/Lucid/Database'
import StoreFoodValidator from 'App/Validators/StoreFoodValidator'
import { inject } from '@adonisjs/core/build/standalone'
import { AttachmentService } from '@ioc:CSM/Services'
import { FoodRepository, PhotoRepository, PlaceRepository } from '@ioc:CSM/Repositories'

const foodStateEnum = ['reviewed', 'unreviewed', 'all'] as const
type FoodState = (typeof foodStateEnum)[number]

@inject()
export default class UserFoodsController {
  public async index({ request, auth }: HttpContextContract) {
    await request.validate({
      schema: schema.create({
        state: schema.enum(foodStateEnum),
      }),
    })

    const userId = auth.user?.id
    const foodState: FoodState = request.input('state')

    const foods = match(foodState)
      .with('reviewed', () => FoodRepository.getReviewedBy(userId!))
      .with('unreviewed', () => FoodRepository.getUnreviewedBy(userId!))
      .with('all', () => FoodRepository.getAll())
      .exhaustive()

    return foods
  }

  public async store({ request, auth }: HttpContextContract) {
    await request.validate(StoreFoodValidator)

    const user = auth.user!

    let photoPath: string | undefined

    return await Database.transaction(async (trx) => {
      try {
        const foodData = request.except(['place', 'photo'])
        const placeData = request.input('place')
        const photoFile = request.file('photo')!

        photoPath = await AttachmentService.upload(photoFile)
        const photo = await PhotoRepository.create(photoPath, { trx })
        const place = await PlaceRepository.findOrCreateByName(placeData, { trx })
        const food = await FoodRepository.create({ data: foodData, place, photo, user }, { trx })

        return food
      } catch (error) {
        if (photoPath) {
          await AttachmentService.delete(photoPath)
        }

        throw error
      }
    })
  }

  public async show({ request }: HttpContextContract) {
    const foodId = request.param('id')
    const food = await Food.query()
      .where('id', foodId)
      .preload('place')
      .preload('photo')
      .preload('reviews', (query) => {
        query.preload('user')
      })
      .firstOrFail()

    return food
  }
}
