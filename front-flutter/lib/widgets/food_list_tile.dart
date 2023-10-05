import 'package:csm_front/models/food_model.dart';
import 'package:csm_front/pages/food_page.dart';
import 'package:flutter/material.dart';
import 'package:overlay_dialog/overlay_dialog.dart';

class FoodListTile extends StatefulWidget {
  final FoodModel food;

  const FoodListTile({
    super.key,
    required this.food,
  });

  @override
  State<FoodListTile> createState() => _FoodListTileState();
}

enum GestureState {
  none,
  longPressing,
}

class _FoodListTileState extends State<FoodListTile> {
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
                  widget.food.image,
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
    return SizedBox(
      height: 150,
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FoodPage(foodId: widget.food.id),
          ),
        ),
        onLongPressDown: (_) => _handleGestureState(GestureState.longPressing),
        onLongPressUp: () => _handleGestureState(GestureState.none),
        onLongPressCancel: () => _handleGestureState(GestureState.none),
        onLongPress: _showOverlayDialog,
        child: Card(
          surfaceTintColor: _state == GestureState.longPressing
              ? Colors.orange.shade100
              : null,
          elevation: _state == GestureState.longPressing ? 3.0 : 0.0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        widget.food.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
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
                            widget.food.place?.name ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.blueGrey.shade600),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rate_rounded,
                                color: Colors.orange,
                                size: 18.0,
                              ),
                              const SizedBox(width: 4.0),
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
                      const Divider(),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.orange.shade600,
                            shape: const LinearBorder(),
                          ),
                          onPressed: () {},
                          child: const Text('Avaliar'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                FoodImage(
                  foodId: widget.food.id.toString(),
                  foodImage: widget.food.image,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FoodImage extends StatelessWidget {
  const FoodImage({
    super.key,
    required this.foodId,
    required this.foodImage,
  });

  final String foodId;
  final String foodImage;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(8.0),
      clipBehavior: Clip.antiAlias,
      child: Hero(
        tag: "food-$foodId",
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            foodImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
