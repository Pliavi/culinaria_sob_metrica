import 'package:flutter/material.dart';

class MyAppbar extends AppBar {
  MyAppbar({
    super.key,
    List<Widget>? actions,
  }) : super(
          elevation: 2,
          backgroundColor: const Color(0xff9a522c),
          foregroundColor: const Color(0xffefd7b7),
          toolbarHeight: 72,
          title: const Column(
            children: [
              Text('Culinária sob Métrica'),
              Text(
                'Bem vindo, Fulano',
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ),
          centerTitle: true,
          actions: [
            ...?actions,
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
              ),
            )
          ],
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        );
}
