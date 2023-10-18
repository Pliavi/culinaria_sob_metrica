import BaseSeeder from '@ioc:Adonis/Lucid/Seeder'
import User from 'App/Models/User'

export default class extends BaseSeeder {
  public async run() {
    await User.createMany([
      {
        id: 1,
        email: 'me@pliavi.com',
        password: 'changeme',
      },
      {
        id: 2,
        email: 'jaque@gmail.com',
        password: 'changeme',
      },
    ])
  }
}
