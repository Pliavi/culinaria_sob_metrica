import { MultipartFileContract } from '@ioc:Adonis/Core/BodyParser'
import Photo from 'App/Models/Photo'
import crypto from 'crypto'
import { RepoCreateOptions } from './Repository.types'

type UploadPhotoRequest = {
  file: MultipartFileContract
  type: 'food' | 'place'
}

export default class PhotoRepository {
  constructor() {}

  public async create({ file, type }: UploadPhotoRequest, { trx }: RepoCreateOptions) {
    const fileUuid = crypto.randomUUID()
    const fileExt = file.extname
    const fileName = `${fileUuid}.${fileExt}`

    const photo = Photo.create({ url: `${type}/${fileName}` }, { client: trx })

    return photo
  }
}
