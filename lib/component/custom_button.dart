// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constant/colors.dart';
import '../providers/admin_provider.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  String text;
  Function function;
  bool isLoading;
  CustomButton({
    Key? key,
    required this.text,
    required this.function,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          function();
        },
        child: Container(
          width: 160,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.secondColor),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  )
                : CustomText(
                    text: text,
                    color: AppColors.primaryColor,
                    fontSize: 20,
                  ),
          ),
        ),
      ),
    );
  }
}
