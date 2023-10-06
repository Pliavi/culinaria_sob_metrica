import crypto from 'crypto'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Food from 'App/Models/Food'
import FoodRepository from 'App/Repositories/FoodRepository'
import { match } from 'ts-pattern'
import { schema } from '@ioc:Adonis/Core/Validator'
import PhotoRepository from 'App/Repositories/PhotoRepository'
import Database from '@ioc:Adonis/Lucid/Database'
import PlaceRepository from 'App/Repositories/PlaceRepository'
import { deletePhoto, uploadPhoto } from 'App/utils/FileUtils'

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

  // TODO: use attachment-lite to upload files directly from models
  public async store({ request, response }: HttpContextContract) {
    // await request.validate(StoreFoodValidator)
    // TODO: Separar o validador de Fotos e de Lugares, sao 3 no total

    const {
      place_id: placeId,
      place_name: placeName,
      ...foodRequestData
    } = request.only([
      // food
      'name',
      'price',
      // place
      'place_name',
      'place_id',
    ])
    const foodPhotoFile = request.file('photo')
    let foodPhotoFileName: string

    return await Database.transaction(async (trx) => {
      try {
        const place = await this.placeRepository.findOrCreateByName(
          { id: placeId, name: placeName },
          { trx }
        )

        foodPhotoFileName = await uploadPhoto({ file: foodPhotoFile!, type: 'food' })
        const foodPhoto = await this.photoRepository.create(
          { file: foodPhotoFile!, type: 'food' },
          { trx }
        )

        const food = await Food.create(
          {
            ...foodRequestData,
            photoId: foodPhoto.id,
            placeId: place.id,
            userId: '6330ad47-b109-4515-9f81-a81429cdcf02',
          },
          { client: trx }
        )

        return food
      } catch (error) {
        console.log('rollingBack')
        await trx.rollback()
        if (foodPhotoFileName) await deletePhoto({ fileName: foodPhotoFileName, type: 'food' })

        return response.badRequest({ error: error.message })
      }
    })
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
