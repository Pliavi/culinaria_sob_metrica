import 'package:csm_front/core/keys.dart';
import 'package:csm_front/interactor/services/login_service/login_service.dart';
import 'package:csm_front/ui/pages/login_page/login_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final api = Dio(
  BaseOptions(
    baseUrl: "http://localhost:3333/",
  ),
)..interceptors.add(
    InterceptorsWrapper(
      onError: (response, handler) {
        if (response.response?.statusCode == 401) {
          LoginService.logout();
          GlobalKeys.navigatorKey.currentState?.pushReplacement(
            MaterialPageRoute(
              builder: (_) => LoginPage(),
            ),
          );
          return;
        }

        return handler.next(response);
      },
    ),
  );
