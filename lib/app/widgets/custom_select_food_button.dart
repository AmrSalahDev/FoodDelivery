import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSelectFoodButton extends StatefulWidget {
  final List<String> foods;
  final Color selectedBackgroundColor;
  final Color unselectedBackgroundColor;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? borderColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;

  const CustomSelectFoodButton({
    super.key,
    required this.foods,
    required this.selectedBackgroundColor,
    required this.unselectedBackgroundColor,
    this.padding,
    this.borderColor,
    this.borderRadius,
    this.selectedTextColor,
    this.unselectedTextColor,
  });

  @override
  State<CustomSelectFoodButton> createState() => _CustomSelectFoodButtonState();
}

class _CustomSelectFoodButtonState extends State<CustomSelectFoodButton> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.foods.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding:
                    widget.padding ??
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 30.r,
                  ),
                  border: Border.all(
                    color: widget.borderColor ?? Colors.transparent,
                    width: 1,
                  ),
                  color: isSelected
                      ? widget.selectedBackgroundColor
                      : widget.unselectedBackgroundColor,
                ),
                child: Text(
                  widget.foods[index],
                  style: GoogleFonts.sen(
                    fontSize: 16.sp,
                    color: isSelected
                        ? widget.selectedTextColor ?? Colors.white
                        : widget.unselectedTextColor ?? Colors.black,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
