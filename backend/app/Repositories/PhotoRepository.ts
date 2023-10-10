import Photo from 'App/Models/Photo'
import { RepoCreateOptions } from './Repository.types'

export default class PhotoRepository {
  constructor() {}

  public async create(filePath: string, { trx }: RepoCreateOptions) {
    const photo = Photo.create({ url: filePath }, { client: trx })

    return photo
  }
}
