import { MultipartFileContract } from '@ioc:Adonis/Core/BodyParser'
import crypto from 'crypto'
import Drive from '@ioc:Adonis/Core/Drive'
import Application from '@ioc:Adonis/Core/Application'

type PhotoType = 'food' | 'place'

type UploadPhotoParams = {
  file: MultipartFileContract
  type: PhotoType
}

type DeletePhotoParams = {
  fileName: string
  type: PhotoType
}

export const uploadPhoto = async ({ file, type }: UploadPhotoParams) => {
  const fileUuid = crypto.randomUUID()
  const fileExt = file.extname
  const fileName = `${fileUuid}.${fileExt}`
  const folder = `${type}_photos`
  const path = Application.tmpPath('uploads') + '/' + folder

  await file.move(path, { name: fileName })

  return folder + '/' + fileName
}

export const deletePhoto = async ({ fileName, type }: DeletePhotoParams) => {
  const folder = `${type}_photos`
  await Drive.delete(folder + '/' + fileName)
}
