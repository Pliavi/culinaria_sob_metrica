import { DateTime } from 'luxon'
import { BaseModel, beforeSave, column } from '@ioc:Adonis/Lucid/Orm'
import crypto from 'crypto'

export default class Photo extends BaseModel {
  @column({ isPrimary: true })
  public id: string

  @column()
  public url: string

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @beforeSave()
  public static setUUID(photo: Photo) {
    photo.id = crypto.randomUUID()
  }
}
