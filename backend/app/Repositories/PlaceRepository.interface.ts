import Place from 'App/Models/Place'
import { RepoCreateOptions } from './Repository.types'

export type CreatePlaceByNameParams = {
  id?: string
  name?: string
}

export interface PlaceRepositoryInterface {
  findOrCreateByName(params: CreatePlaceByNameParams, options?: RepoCreateOptions): Promise<Place>
}
