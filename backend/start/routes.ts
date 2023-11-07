/*
|--------------------------------------------------------------------------
| Routes
|--------------------------------------------------------------------------
*/

import Route from '@ioc:Adonis/Core/Route'

Route.post('/auth/login', 'AuthController.login')
Route.post('/auth/register', 'AuthController.register')
Route.post('/auth/validate', 'AuthController.validateToken')
Route.post('/auth/logout', 'AuthController.logout')

Route.resource('foods', 'UserFoodsController').apiOnly()
// .middleware({ '*': ['auth'] }) // TODO: uncomment
