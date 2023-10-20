/*
|--------------------------------------------------------------------------
| Routes
|--------------------------------------------------------------------------
*/

import Route from '@ioc:Adonis/Core/Route'

Route.post('/login', 'AuthController.login')
Route.post('/register', 'AuthController.register')
Route.post('/validate-token', 'AuthController.validateToken')
Route.post('/logout', 'AuthController.logout')

Route.resource('foods', 'UserFoodsController')
  .apiOnly()
  .middleware({ '*': ['auth'] })
