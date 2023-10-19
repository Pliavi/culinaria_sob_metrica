import 'package:csm_front/data/datasources/api_instance.dart';
import 'package:csm_front/interactor/services/food_service/food_service.dart';
import 'package:csm_front/ui/pages/food_page/food_page_cubit.dart';
import 'package:csm_front/ui/pages/home_page/home_page.dart';
import 'package:csm_front/ui/pages/home_page/home_page_cubit.dart';
import 'package:csm_front/ui/pages/login_page/login_page.dart';
import 'package:csm_front/ui/pages/login_page/login_page_cubit.dart';
import 'package:csm_front/ui/pages/login_page/login_page_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final foodService = FoodService();
    final providers = [
      BlocProvider(create: (_) {
        final cubit = LoginPageCubit();
        cubit.checkIsLogged();

        return cubit;
      }),
      BlocProvider(create: (_) => HomePageCubit(foodService: foodService)),
      BlocProvider(create: (_) => FoodPageCubit(foodService: foodService)),
    ];

    return MultiBlocProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff9a522c)),
          useMaterial3: true,
        ),
        home: BlocBuilder<LoginPageCubit, LoginPageState>(
          bloc: context.read(),
          builder: (context, state) {
            return state.on(
              init: () {
                return Column(
                  children: [
                    FutureBuilder(
                      future: SharedPreferences.getInstance(),
                      builder: (context, snapshot) => Text(
                        snapshot.data?.getString("token") ?? "No token",
                      ),
                    ),
                    Expanded(child: LoginPage()),
                  ],
                );
              },
              success: (_) => Column(
                children: [
                  Text(api.options.headers.toString()),
                  const Expanded(child: HomePage()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
