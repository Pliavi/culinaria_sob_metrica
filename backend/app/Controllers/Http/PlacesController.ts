import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Place from 'App/Models/Place'

export default class PlacesController {
  public async index({ request }: HttpContextContract) {
    const placeSearchFragment = request.input('search')

    const places = await Place.query()
      .where('name', 'like', `%${placeSearchFragment}%`)
      .orderBy('name')
      .limit(10)
      .exec()

    return places
  }
}
