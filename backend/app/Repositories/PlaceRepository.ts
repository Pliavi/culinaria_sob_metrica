import Place from 'App/Models/Place'
import { P, match } from 'ts-pattern'

import { FindOrCreatePlaceByNameParams } from './PlaceRepository.interface'
import { RepoCreateOptions } from './Repository.types'

export default class PlaceRepository {
  public async findOrCreateByName(
    { id, name }: FindOrCreatePlaceByNameParams,
    { trx }: RepoCreateOptions
  ) {
    const place = await match(id)
      .with(P.number, () => Place.findOrFail(id, { client: trx }))
      .otherwise(() => Place.create({ name }, { client: trx }))

    return place
  }
}
