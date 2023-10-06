import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class extends BaseSchema {
  protected tableName = 'review_photos'

  public async up() {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id')

      table.uuid('review_id').references('id').inTable('reviews').onDelete('CASCADE')
      table.uuid('photo_id').references('id').inTable('photos').onDelete('CASCADE')

      /**
       * Uses timestamptz for PostgreSQL and DATETIME2 for MSSQL
       */
      table.timestamp('created_at', { useTz: true })
      table.timestamp('updated_at', { useTz: true })
    })
  }

  public async down() {
    this.schema.dropTable(this.tableName)
  }
}
