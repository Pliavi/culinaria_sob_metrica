import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Food from 'App/Models/Food'
import { match } from 'ts-pattern'
import { schema } from '@ioc:Adonis/Core/Validator'
import Database from '@ioc:Adonis/Lucid/Database'
import StoreFoodValidator from 'App/Validators/StoreFoodValidator'
import { inject } from '@adonisjs/core/build/standalone'
import { AttachmentService } from '@ioc:CSM/Services'
import { FoodRepository, PhotoRepository, PlaceRepository } from '@ioc:CSM/Repositories'
import Photo from 'App/Models/Photo'
import Place from 'App/Models/Place'
import User from 'App/Models/User'

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

    const userId = auth.user?.id ?? 1 // TODO: remove default value
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

    const user = auth.user ?? (await User.firstOrFail()) // TODO: remove default value

    let photoPath: string | undefined

    return await Database.transaction(async (trx) => {
      try {
        const foodData = request.except(['place', 'photo'])
        const placeData = request.input('place')
        delete foodData.id

        let photo: Photo
        if (request.file('photo') !== null && request.file('photo') !== undefined) {
          const photoFile = request.file('photo')!
          photoPath = await AttachmentService.upload(photoFile)
          photo = await PhotoRepository.create(photoPath, { trx })
        } else {
          photo = await Photo.firstOrFail() // TODO: remove default
        }

        let place: Place
        if (placeData !== undefined && placeData !== null) {
          place = await PlaceRepository.firstOrCreateByName(placeData, { trx })
        } else {
          place = await Place.firstOrFail() // TODO: remove default
        }

        console.log(foodData)

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
