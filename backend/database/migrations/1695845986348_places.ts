import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class extends BaseSchema {
  protected tableName = 'places'

  public async up() {
    this.schema.createTable(this.tableName, (table) => {
      table.uuid('id').primary()

      table.string('name', 255).notNullable()
      table.string('description', 255).nullable()
      table.string('address', 255).nullable()
      table.string('city', 255).nullable()
      table.string('state', 255).nullable()
      table.string('country', 255).nullable()
      table.string('zip_code', 255).nullable()
      table.string('phone', 255).nullable()
      table.string('website', 255).nullable()

      table.uuid('photo_id').references('id').inTable('photos').onDelete('SET NULL')
      table.uuid('user_id').references('id').inTable('users').onDelete('SET NULL')

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
