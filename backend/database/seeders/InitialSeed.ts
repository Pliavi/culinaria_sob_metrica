import { ModelAttributes } from '@ioc:Adonis/Lucid/Orm'
import BaseSeeder from '@ioc:Adonis/Lucid/Seeder'
import Food from 'App/Models/Food'
import Place from 'App/Models/Place'

export default class extends BaseSeeder {
  public async run() {
    const defaultValues = {
      city: 'Caraguatatuba',
      state: 'SP',
      country: 'Brasil',
    } as ModelAttributes<InstanceType<typeof Place>>

    await Place.createMany([
      {
        ...defaultValues,
        id: 1,
        name: 'Pizza 1',
        city: 'São José dos Campos',
      },
      {
        ...defaultValues,
        id: 2,
        name: 'Chilili Doceria',
      },
      {
        ...defaultValues,
        id: 3,
        name: 'Santo Suco',
      },
      {
        ...defaultValues,
        id: 4,
        name: 'Confeitaria Imperial (Shopping Serramar)',
      },
      {
        ...defaultValues,
        id: 5,
        name: 'Burguer King (Shopping Serramar)',
      },
      {
        ...defaultValues,
        id: 6,
        name: 'Chiquinho (Centro)',
      },
      {
        ...defaultValues,
        id: 7,
        name: "Jet'z Burger",
      },
      {
        ...defaultValues,
        id: 8,
        name: 'KFC (Vale Sul Shopping)',
        city: 'São José dos Campos',
      },
      {
        ...defaultValues,
        id: 9,
        name: 'BS Bgr',
      },
      {
        ...defaultValues,
        id: 10,
        name: 'Café Dary',
      },
      {
        ...defaultValues,
        id: 11,
        name: 'Padaria Pão Chick',
        city: 'São José dos Campos',
      },
    ])

    await Food.createMany([
      {
        name: 'Pizza de strogonoff',
        placeId: 1,
      },
      {
        name: 'Shake Mix Chocotino c/ Nutella',
        placeId: 6,
      },
      {
        name: 'X-Salada',
        placeId: 7,
      },
      {
        name: 'Boeing 747',
        placeId: 7,
      },
      {
        name: 'Massa gelada',
        placeId: 5,
      },
      {
        name: 'Combo Double Crunch',
        placeId: 8,
      },
      {
        name: 'Lanche Natural',
        placeId: 11,
      },
      {
        name: 'BS (X-Salada)',
        placeId: 9,
      },
      {
        name: 'Isso Não é Uma Cópia! (Cópia do McDonalds)',
        placeId: 9,
      },
      {
        name: 'Capuccino Invertido (quente)',
        placeId: 10,
      },
      {
        name: "Lury's Café (quente)",
        placeId: 10,
      },
      {
        name: 'Manhattan burguer',
        placeId: 3,
      },
    ])
  }
}
