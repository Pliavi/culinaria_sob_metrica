import 'package:flutter/material.dart';

class FetchBuilder extends StatelessWidget {
  const FetchBuilder({
    Key? key,
    required this.fetcher,
    required this.onLoading,
    required this.onError,
    required this.onState,
  }) : super(key: key);

  final Future<dynamic> fetcher;
  final Widget Function(BuildContext context) onLoading;
  final Widget Function(BuildContext context, dynamic error) onError;
  final Widget Function(BuildContext context, Object? state) onState;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetcher,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return onLoading(context);
        }

        if (snapshot.hasError) {
          return onError(context, snapshot.error);
        }

        return onState(context, snapshot.data);
      },
    );
  }
}
