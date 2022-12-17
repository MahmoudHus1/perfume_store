import 'package:flutter/material.dart';
import 'package:perfume_store/core/constant/colors.dart';

import 'custom_text.dart';

class CustomProfile extends StatelessWidget {
  final String label;
  final String value;
  const CustomProfile({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.secondColor, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Expanded(
            child: CustomText(
                text: label, fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryColor,),
          ),
          Expanded(
            flex: 1,
            child: CustomText(text: value, fontSize: 18, color: AppColors.primaryColor,),
          )
        ],
      ),
    );
  }
}
