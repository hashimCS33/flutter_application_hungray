import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gap(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
            
              child: SvgPicture.asset(
                "assets/logo/logo.svg",
                color: AppColors.primary,
                height: 35,
              ),
            ),
            Gap(5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomText(
                text: "Hello, hi dev hashim",
                color: Colors.grey,
                fontweight: FontWeight.w500,
                fontsize: 20,
              ),
            ),
          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primary,
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
