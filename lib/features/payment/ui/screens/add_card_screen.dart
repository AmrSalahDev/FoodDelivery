import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/constants/app_colors.dart';
import 'package:food_delivery/core/constants/app_strings.dart';
import 'package:food_delivery/features/payment/data/models/card_info_model.dart';
import 'package:food_delivery/features/payment/enums/cards_supported.dart';
import 'package:food_delivery/features/payment/ui/cubits/card_cubit.dart';
import 'package:food_delivery/shared/widgets/custom_circle_button.dart';
import 'package:food_delivery/shared/widgets/custom_rectangle_button.dart';
import 'package:food_delivery/shared/widgets/custom_textfield.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/core/utils/text_field_utils/credit_card_number_formatter.dart';
import 'package:my_flutter_toolkit/core/utils/text_field_utils/expiry_date_formatter.dart';
import 'package:my_flutter_toolkit/core/utils/text_field_utils/validators.dart';

class AddCardScreen extends StatefulWidget {
  final CardsSupported cardType;
  const AddCardScreen({super.key, required this.cardType});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  late final TextEditingController holderNameController;
  late final TextEditingController cardNumberController;
  late final TextEditingController expiryDateController;
  late final TextEditingController cvvController;

  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    holderNameController = TextEditingController();
    cardNumberController = TextEditingController();
    expiryDateController = TextEditingController();
    cvvController = TextEditingController();

    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    holderNameController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (formKey.currentState!.validate()) {
      final cardInfo = CardInfoModel(
        cardHolderName: holderNameController.text,
        cardNumber: cardNumberController.text,
        expiryDate: expiryDateController.text,
        cvv: cvvController.text,
        cardType: widget.cardType.displayName,
        cardLogo: widget.cardType.icon,
      );
      context.read<CardCubit>().saveCard(cardInfo);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                HeaderSection(),
                SizedBox(height: 30.h),
                BodySection(
                  holderNameController: holderNameController,
                  cardNumberController: cardNumberController,
                  expiryDateController: expiryDateController,
                  cvvController: cvvController,

                  formKey: formKey,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: FooterSection(onSubmit: () => _onSubmit()),
    );
  }
}

class AppBarPart extends StatelessWidget {
  const AppBarPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCircleButton(
          backgroundColor: Color(0xFFECF0F4),
          size: 55.h,
          onPressed: () => context.pop(),
          icon: Icon(Icons.close, color: AppColors.darkBlue, size: 24.h),
        ),
        SizedBox(width: 15.w),
        Text(
          AppStrings.addCard,
          style: GoogleFonts.sen(
            fontSize: 20.sp,
            fontWeight: FontWeight.normal,
            color: AppColors.darkBlue,
          ),
        ),
      ],
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [AppBarPart()]);
  }
}

class BodySection extends StatefulWidget {
  final TextEditingController holderNameController;
  final TextEditingController cardNumberController;
  final TextEditingController expiryDateController;
  final TextEditingController cvvController;
  final GlobalKey<FormState> formKey;

  const BodySection({
    super.key,
    required this.holderNameController,
    required this.cardNumberController,
    required this.expiryDateController,
    required this.cvvController,
    required this.formKey,
  });

  @override
  State<BodySection> createState() => _BodySectionState();
}

class _BodySectionState extends State<BodySection> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          CustomTextfield(
            controller: widget.holderNameController,
            label: AppStrings.cardHolderName.toUpperCase(),
            hint: AppStrings.enterCardHolderName,
            validator: (value) => Validators.name(value: value),
            labelStyle: GoogleFonts.sen(
              fontSize: 14.sp,
              color: Color(0xFFA0A5BA),
              fontWeight: FontWeight.normal,
            ),
            textInputType: TextInputType.text,
          ),
          CustomTextfield(
            controller: widget.cardNumberController,
            maxLength: 19,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
              CreditCardNumberFormatter(),
            ],
            label: AppStrings.cardNumber.toUpperCase(),
            validator: (value) => Validators.cardNumber(value: value),
            hint: AppStrings.enterCardNumber,
            labelStyle: GoogleFonts.sen(
              fontSize: 14.sp,
              color: Color(0xFFA0A5BA),
              fontWeight: FontWeight.normal,
            ),
            textInputType: TextInputType.number,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextfield(
                  controller: widget.expiryDateController,
                  maxLength: 7,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                    ExpiryDateFormatter(),
                  ],
                  validator: (value) => Validators.expiryDate(value: value),
                  label: AppStrings.expiry.toUpperCase(),
                  hint: AppStrings.enterExpiry,
                  labelStyle: GoogleFonts.sen(
                    fontSize: 14.sp,
                    color: Color(0xFFA0A5BA),
                    fontWeight: FontWeight.normal,
                  ),
                  textInputType: TextInputType.number,
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: CustomTextfield(
                  controller: widget.cvvController,
                  maxLength: 3,
                  isPassword: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  validator: (value) => Validators.cvv(value: value),
                  label: AppStrings.cvv.toUpperCase(),
                  hint: AppStrings.enterCvv,
                  labelStyle: GoogleFonts.sen(
                    fontSize: 14.sp,
                    color: Color(0xFFA0A5BA),
                    fontWeight: FontWeight.normal,
                  ),
                  textInputType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  final VoidCallback onSubmit;

  const FooterSection({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: CustomRectangleButton(
        backgroundColor: AppColors.secondary,
        title: AppStrings.addAndMakePayment.toUpperCase(),
        onPressed: () => onSubmit(),
      ),
    );
  }
}
