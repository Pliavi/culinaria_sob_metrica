import { ModelAttributes } from '@ioc:Adonis/Lucid/Orm'
import BaseSeeder from '@ioc:Adonis/Lucid/Seeder'
import Food from 'App/Models/Food'
import Place from 'App/Models/Place'
import Review from 'App/Models/Review'

export default class extends BaseSeeder {
  public async run() {
    Review.createMany([
      {
        id: 1,
        foodId: 1,
        rating: 5,
        title: 'Muito bom',
        comment: 'Muito bom mesmo',
        likes: 0,
        userId: 1,
      },
      {
        id: 2,
        foodId: 2,
        rating: 3,
        title: 'Até que é bom',
        comment: 'Achei um pouco salgado, mas no geral é bom, nada excepcional',
        likes: 2,
        userId: 2,
      },
      {
        id: 3,
        foodId: 3,
        rating: 4,
        title: 'Olha, esperava mais',
        comment:
          'A propaganda é boa, mas o produto não é tudo isso, mas foi bem apresentado, prato bonito',
        likes: 0,
        userId: 1,
      },
      {
        id: 4,
        foodId: 1,
        rating: 4,
        title: 'Olha, esperava mais',
        comment:
          'A propaganda é boa, mas o produto não é tudo isso, mas foi bem apresentado, prato bonito',
        likes: 0,
        userId: 1,
      },
    ])
  }
}
