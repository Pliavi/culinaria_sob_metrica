import 'package:csm_front/ui/widgets/my_appbar.dart';
import 'package:flutter/material.dart';

class MainLayout extends Scaffold {
  MainLayout({
    super.key,
    super.body,
    super.floatingActionButton,
  }) : super(
          appBar: MyAppbar(),
          extendBody: true,
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) => print(value),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
            ],
          ),
        );
}
