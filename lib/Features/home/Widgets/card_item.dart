import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:gap/gap.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.rating,
  });

  final String image;
  final String description;
  final String name;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(image, width: 120,height: 120, fit: BoxFit.cover)),
            Gap(10),
            CustomText(text: name, fontweight: FontWeight.w500, fontsize: 18),
            CustomText(
              text: description,
              fontweight: FontWeight.w500,
              fontsize: 18,
            ),
            Row(
              children: [
                CustomText(
                  text: " ⭐ $rating",
                  fontweight: FontWeight.w500,
                  fontsize: 18,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                Spacer(),
                Icon(Icons.favorite, color: AppColors.primary, size: 20),
              ],
            ),

            /// back the code have erorr logic
          ],
        ),
      ),
    );
  }
}
