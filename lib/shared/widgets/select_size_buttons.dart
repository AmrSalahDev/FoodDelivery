import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/shared/widgets/custom_circle_button.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectSizeButtons extends StatefulWidget {
  final List<String> sizes;
  final Color selectedBackgroundColor;
  final Color unselectedBackgroundColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final Function(int index, String size)? onSizeSelected;

  const SelectSizeButtons({
    super.key,
    required this.sizes,
    this.onSizeSelected,
    required this.selectedBackgroundColor,
    required this.unselectedBackgroundColor,
    this.selectedTextColor,
    this.unselectedTextColor,
  });

  @override
  State<SelectSizeButtons> createState() => _SelectSizeButtonsState();
}

class _SelectSizeButtonsState extends State<SelectSizeButtons> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.sizes.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CustomCircleButton(
              onPressed: () {
                setState(() {
                  selectedIndex = index;
                });
                if (widget.onSizeSelected != null) {
                  widget.onSizeSelected!(index, widget.sizes[index]);
                }
              },
              backgroundColor: isSelected
                  ? widget.selectedBackgroundColor
                  : widget.unselectedBackgroundColor,
              size: 55.h,
              icon: Text(
                widget.sizes[index],
                style: GoogleFonts.sen(
                  fontSize: 16.sp,
                  color: isSelected
                      ? widget.selectedTextColor ?? AppColors.white
                      : widget.unselectedTextColor ?? AppColors.darkBlue,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
