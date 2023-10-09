import { MultipartFileContract } from '@ioc:Adonis/Core/BodyParser'
import crypto from 'crypto'
import Drive from '@ioc:Adonis/Core/Drive'
import Application from '@ioc:Adonis/Core/Application'
import { join } from 'path'

export default class AttachmentService {
  constructor() {}

  public async upload(file: MultipartFileContract, folder: string = '') {
    const fileUuid = crypto.randomUUID()
    const fileExt = file.extname
    const fileName = `${fileUuid}.${fileExt}`
    const path = join(Application.tmpPath('uploads'), folder)

    await file.move(path, { name: fileName })

    return join(path, fileName)
  }

  public delete(filePath: string) {
    return Drive.delete(filePath)
  }
}
