import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:gap/gap.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.image, required this.text, required this.desc, required this.onAdd, required this.onMins, required this.onRemoveItem,required this.num});
  final String image, text, desc;
  final VoidCallback onAdd;
  final VoidCallback onMins;
  final VoidCallback onRemoveItem;
  final int num;


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(image, width: 100),
                  CustomText(text: text, fontweight: FontWeight.bold),
                  CustomText(text: desc),
                ],
              ),
            ),

            const Gap(12),

            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: onAdd,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Icon(
                          CupertinoIcons.add,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Gap(20),
                    CustomText(
                      text: num.toString(),
                      fontweight: FontWeight.w400,
                      fontsize: 20,
                    ),
                    const Gap(20),
                    GestureDetector(
                      onTap: onMins,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Icon(
                          CupertinoIcons.minus,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                const Gap(20),
                SizedBox(
                  width: 130,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: onRemoveItem,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const CustomText(text: 'Remove', color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
