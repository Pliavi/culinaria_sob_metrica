import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Food from 'App/Models/Food'
import FoodRepository from 'App/Repositories/FoodRepository'
import { match } from 'ts-pattern'
import { schema } from '@ioc:Adonis/Core/Validator'
import PhotoRepository from 'App/Repositories/PhotoRepository'
import Database, { TransactionClientContract } from '@ioc:Adonis/Lucid/Database'
import PlaceRepository from 'App/Repositories/PlaceRepository'
import StoreFoodValidator from 'App/Validators/StoreFoodValidator'
import type { MultipartFileContract } from '@ioc:Adonis/Core/BodyParser'
import Place from 'App/Models/Place'
import Photo from 'App/Models/Photo'
import User from 'App/Models/User'

const foodStateEnum = ['reviewed', 'unreviewed', 'all'] as const
type FoodState = (typeof foodStateEnum)[number]

export default class UserFoodsController {
  private foodRepository = new FoodRepository()
  private photoRepository = new PhotoRepository()
  private placeRepository = new PlaceRepository()

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

  public async store({ request, response, auth }: HttpContextContract) {
    await request.validate(StoreFoodValidator)

    return await Database.transaction(async (trx) => {
      try {
        const foodReqData = request.except(['place', 'photo'])
        const placeReqData = request.input('place')
        const foodPhotoFile = request.file('photo')

        const place = await this.placeRepository.findOrCreateByName(placeReqData, { trx })
        const foodPhoto = await this.uploadFoodPhoto(foodPhotoFile!, trx)
        const food = await this.createFoodItem(foodReqData, place, foodPhoto, auth.user!, trx)

        return food
      } catch (error) {
        await trx.rollback()

        return response.badRequest({ error: error.message })
      }
    })
  }

  private async uploadFoodPhoto(file: MultipartFileContract, trx: TransactionClientContract) {
    // const fileName = await uploadPhoto({ file, type: 'food' })
    try {
      const photo = await this.photoRepository.create({ file, type: 'food' }, { trx })

      return photo
    } catch (error) {
      // await deletePhoto({ fileName, type: 'food' })
      throw error
    }
  }

  private async createFoodItem(
    foodReqData: any,
    place: Place,
    photo: Photo,
    user: User,
    trx: TransactionClientContract
  ) {
    return await Food.create(
      {
        ...foodReqData,
        photoId: photo.id,
        placeId: place.id,
        userId: user.id,
      },
      { client: trx }
    )
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
