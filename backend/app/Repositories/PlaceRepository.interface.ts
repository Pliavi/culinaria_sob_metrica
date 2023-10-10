import Place from 'App/Models/Place'
import { TransactionClientContract } from '@ioc:Adonis/Lucid/Database'

export interface FindOrCreatePlaceByNameParams {
  id?: string
  name?: string
}

export interface PlaceRepositoryInterface {
  findOrCreateByName(
    trx: TransactionClientContract,
    params: FindOrCreatePlaceByNameParams
  ): Promise<Place>
}
