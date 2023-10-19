import 'package:flutter/material.dart';

extension ContextRouteExtension on BuildContext {
  T? getRouteArg<T extends Object?>([T? fallback]) {
    final arg = ModalRoute.of(this)?.settings.arguments as T?;

    return arg ?? fallback;
  }
}
