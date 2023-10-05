import 'package:flutter/material.dart';
import 'package:overlay_dialog/overlay_dialog.dart';

const foodImageUrl =
    'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80';

class FoodCard extends StatefulWidget {
  const FoodCard({
    super.key,
  });

  @override
  State<FoodCard> createState() => _FoodCardState();
}

enum GestureState {
  none,
  longPressing,
}

class _FoodCardState extends State<FoodCard> {
  GestureState _state = GestureState.none;
  final _dialogHelper = DialogHelper();

  _handleGestureState(GestureState state) {
    setState(() => _state = state);

    if (state == GestureState.none) {
      _dialogHelper.hide(context);
    }
  }

  _showOverlayDialog() {
    _dialogHelper.show(
      context,
      DialogWidget.custom(
        child: Card(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Brownie com cobertura de chocolate',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Chilili doceria',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              AspectRatio(
                aspectRatio: 1.0,
                child: Image.network(
                  foodImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('R\$ 12,00'),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_rate_rounded,
                          color: Colors.yellow.shade800,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '4.9',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey.shade900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.orange.shade900.withOpacity(0.15),
          blurRadius: 24.0,
          offset: const Offset(0, 8.0),
        ),
      ]),
      child: Card(
        elevation: 0,
        child: GestureDetector(
          onLongPressDown: (_) {
            _handleGestureState(GestureState.longPressing);
          },
          onLongPressEnd: (_) {
            _handleGestureState(GestureState.none);
          },
          onLongPress: _showOverlayDialog,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              left: 8.0,
              right: 8.0,
              bottom: 10.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(8.0),
                  clipBehavior: Clip.antiAlias,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Image.network(
                      foodImageUrl,
                      fit: BoxFit.cover,
                      color: _state == GestureState.longPressing
                          ? Colors.black38
                          : null,
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Brownie com cobertura de chocolate',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      color: Colors.blueGrey.shade600,
                      size: 18.0,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      'Chilili doceria',
                      style: TextStyle(color: Colors.blueGrey.shade600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
