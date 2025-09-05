import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';

class AddToCartController extends ChangeNotifier {
  int _quantity;
  final int minQuantity;
  final int maxQuantity;

  AddToCartController({
    int initialQuantity = 0,
    this.minQuantity = 0,
    this.maxQuantity = 99,
  }) : _quantity = initialQuantity;

  int get quantity => _quantity;

  void setQuantity(int value) {
    if (value >= minQuantity && value <= maxQuantity) {
      _quantity = value;
      notifyListeners();
    }
  }

  void increment() {
    if (_quantity < maxQuantity) {
      _quantity++;
      notifyListeners();
    }
  }

  void decrement() {
    if (_quantity > minQuantity) {
      _quantity--;
      notifyListeners();
    }
  }
}

class AddToCartButtonV2 extends StatefulWidget {
  final AddToCartController controller;
  final Function(int value) onIncrement;
  final Function(int value) onDecrement;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Color countColor;
  final Color borderColor;
  final Color iconColor;
  final Color? iconBackgroundColor;
  final TextStyle? countTextStyle;
  final double borderWidth;
  final double borderRadius;
  final double height;
  final double width;
  final double initialSize;
  final BoxShape initialShape;
  final Duration animationDuration;

  const AddToCartButtonV2({
    super.key,
    required this.controller,
    required this.onIncrement,
    required this.onDecrement,
    this.padding = const EdgeInsets.all(10),
    this.iconBackgroundColor,
    this.backgroundColor = Colors.white,
    this.countColor = Colors.black,
    this.borderColor = Colors.white,
    this.iconColor = Colors.black,
    this.borderWidth = 1.0,
    this.borderRadius = 10.0,
    this.animationDuration = const Duration(milliseconds: 200),
    this.height = 40.0,
    this.width = 100.0,
    this.initialSize = 40.0,
    this.initialShape = BoxShape.circle,
    this.countTextStyle,
  });

  @override
  State<AddToCartButtonV2> createState() => _AddToCartButtonV2State();
}

class _AddToCartButtonV2State extends State<AddToCartButtonV2> {
  late AddToCartController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final quantity = controller.quantity;
    final bool isAdded = quantity > controller.minQuantity;

    return AnimatedContainer(
      duration: widget.animationDuration,
      width: isAdded ? widget.width : widget.initialSize,
      height: isAdded ? widget.height : widget.initialSize,
      padding: isAdded ? widget.padding : null,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(
          widget.initialShape == BoxShape.circle
              ? widget.height / 2
              : widget.borderRadius,
        ),
        border: Border.all(
          color: widget.borderColor,
          width: widget.borderWidth,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            duration: widget.animationDuration,
            opacity: isAdded ? 1 : 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.decrement();
                      widget.onDecrement.call(controller.quantity);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            widget.iconBackgroundColor ?? Colors.grey.shade700,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.remove,
                        size: 18,
                        color: widget.iconColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: AnimatedDigitWidget(
                      value: controller.quantity,
                      textStyle:
                          widget.countTextStyle ??
                          TextStyle(
                            color: widget.countColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.increment();
                      widget.onIncrement.call(controller.quantity);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            widget.iconBackgroundColor ?? Colors.grey.shade700,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.add, size: 18, color: widget.iconColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          IgnorePointer(
            ignoring: isAdded,
            child: AnimatedOpacity(
              duration: widget.animationDuration,
              opacity: isAdded ? 0 : 1,
              child: GestureDetector(
                onTap: () {
                  controller.increment();
                  widget.onIncrement.call(controller.quantity);
                },
                child: Center(child: Icon(Icons.add, color: widget.iconColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
