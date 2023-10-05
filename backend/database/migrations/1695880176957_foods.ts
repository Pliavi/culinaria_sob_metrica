import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class extends BaseSchema {
  protected tableName = 'foods'

  public async up() {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id')

      table.string('name', 255).notNullable()
      table.string('price', 255).nullable()
      table.string('image', 255).nullable()

      // XXX: If you want to delete a place, you must delete all the foods in it first
      //      Cause deleting a place will lead to delete the foods and the reviews in it
      table.integer('place_id').unsigned().references('id').inTable('places').onDelete('RESTRICT')

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
