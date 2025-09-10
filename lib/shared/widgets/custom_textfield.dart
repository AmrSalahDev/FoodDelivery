import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;

  final TextInputType textInputType;
  final bool? isPassword;
  final TextStyle? labelStyle;
  final List<String>? autofillHints;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final String? obscureChar;

  const CustomTextfield({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.textInputType,
    this.validator,
    this.isPassword,
    this.labelStyle,
    this.autofillHints,
    this.autovalidateMode,
    this.inputFormatters,
    this.obscureChar,
    this.maxLength,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style:
              widget.labelStyle ??
              GoogleFonts.sen(
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
                color: Color(0xFF32343E),
              ),
        ),
        SizedBox(height: 10.h),

        TextFormField(
          autovalidateMode: widget.autovalidateMode,
          autofillHints: widget.autofillHints,
          inputFormatters: widget.inputFormatters,
          obscuringCharacter: widget.obscureChar ?? '•',
          maxLength: widget.maxLength,
          obscureText: widget.isPassword ?? false ? !isPasswordVisible : false,
          keyboardType: widget.textInputType,
          controller: widget.controller,
          style: GoogleFonts.sen(
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            color: Color(0xFF32343E),
          ),
          validator: widget.validator,

          decoration: InputDecoration(
            counter: SizedBox.shrink(),
            filled: true,
            fillColor: Color(0xFFF0F5FA),
            hintText: widget.hint,
            hintStyle: GoogleFonts.sen(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: Color(0xFFA0A5BA),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),

            suffixIcon: widget.isPassword ?? false
                ? IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color(0xFFB4B9CA),
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  )
                : null,
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
