import Place from 'App/Models/Place'

import { RepoCreateOptions } from '../../types/Repository.types'

interface FindOrCreatePlaceByNameParams {
  id: number
  name: string
}

export default class PlaceRepository {
  public async firstOrCreateByName(
    { id, name }: FindOrCreatePlaceByNameParams,
    { trx }: RepoCreateOptions
  ) {
    return await Place.firstOrCreate({ id }, { name }, { client: trx })
  }
}
