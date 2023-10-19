import 'package:csm_front/ui/pages/home_page/home_page_cubit.dart';
import 'package:csm_front/ui/pages/home_page/home_page_states.dart';
import 'package:csm_front/ui/widgets/food_list_tile.dart';
import 'package:csm_front/ui/widgets/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomePageCubit>();

    cubit.getFoods();

    return BlocBuilder<HomePageCubit, HomePageState>(
      bloc: cubit,
      builder: (context, state) {
        return MainLayout(
          body: state.on(
            init: () => const Center(child: CircularProgressIndicator()),
            error: (state) => Center(child: Text(state.error)),
            success: (state) => ListView.builder(
              itemCount: state.foods.length,
              itemBuilder: (context, index) => FoodListTile(
                food: state.foods[index],
              ),
            ),
          ),
        );
      },
    );
  }
}
