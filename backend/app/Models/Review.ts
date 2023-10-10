import { DateTime } from 'luxon'

import {
  BaseModel,
  BelongsTo,
  ManyToMany,
  belongsTo,
  column,
  manyToMany,
} from '@ioc:Adonis/Lucid/Orm'
import Food from './Food'
import User from './User'
import Photo from './Photo'

export default class Review extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column()
  public title: string

  @column()
  public comment: string

  @column()
  public rating: number

  @column()
  public likes: number

  @manyToMany(() => Photo, { pivotTable: 'review_photos' })
  public photos: ManyToMany<typeof Photo>

  @column({ serializeAs: null })
  public userId: number
  @belongsTo(() => User)
  public user: BelongsTo<typeof User>

  @column({ serializeAs: null })
  public foodId: string
  @belongsTo(() => Food)
  public food: BelongsTo<typeof Food>

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
}
