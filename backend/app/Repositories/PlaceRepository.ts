import Place from 'App/Models/Place'
import { match } from 'ts-pattern'
import isUUID from 'is-uuid'
import { PlaceRepositoryInterface } from './PlaceRepository.interface'

export default class PlaceRepository implements PlaceRepositoryInterface {
  public async findOrCreateByName({ id, name }, { trx }) {
    const place = await match(id)
      .when(isUUID.anyNonNil, () => Place.findOrFail(id, { client: trx }))
      .otherwise(() => {
        console.log('Creating place with name: ' + name)
        return Place.create({ name }, { client: trx })
      })

    return place
  }
}
