import { schema, rules, CustomMessages } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

export default class StoreFoodValidator {
  constructor(protected ctx: HttpContextContract) {}

  public schema = schema.create({
    name: schema.string(
      {
        trim: true,
        escape: true,
      },
      [rules.minLength(2), rules.maxLength(255)]
    ),
    price: schema.string.nullable(
      {
        trim: true,
        escape: true,
      },
      [rules.regex(/^[0-9]+(\.[0-9]{1,2})?$/)]
    ),
    photo: schema.file.optional({
      extnames: ['jpg', 'png', 'jpeg'],
      size: '5mb',
    }),
    // TODO: remove optional
    place: schema.object.optional().members({
      name: schema.string({}, [rules.requiredIfNotExists('place.id')]),
      id: schema.number([rules.requiredIfNotExists('place.name')]),
    }),
  })

  public messages: CustomMessages = {
    'name.required': 'Nome é obrigatório',
    'name.minLength': 'Nome deve ter no mínimo 2 caracteres',
    'name.maxLength': 'Nome deve ter no máximo 255 caracteres',
    'price.regex': 'Preço deve ser um número decimal',
    'image.extnames': 'Imagem deve ser um arquivo png ou jpg/jpeg',
    'image.size': 'Imagem deve ter no máximo 5MB',
    'place.requiredIfNotExists': 'Local é obrigatório',
    'placeId.requiredIfNotExists': 'Local é obrigatório',
  }
}
