import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';

class ToppingCard extends StatelessWidget {
  final String title;
  final String imageAsset;
  final VoidCallback onAddTap;

  const ToppingCard({
    super.key,
    required this.title,
    required this.imageAsset,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 175,
      decoration: BoxDecoration(
        color: AppColors.primary, // الطبقة السفلى: الخلفية الجوزية بالكامل
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            
            // 1. الطبقة الوسطى: الحاوية البيضاء تغطي الجزء العلوي وتنحني فوق الجوزي
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 105, // تحديد مساحة اللون الأبيض
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // اللون الأبيض
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            // 2. الطبقة العليا: صورة الطماطم (تظهر فوق الأبيض وفوق الجوزي بنفس الوقت)
            Positioned(
              top: 10,
              left: 14,
              right: 14,
              height: 90, // ارتفاع الصورة لتغطية مساحتها بالكامل
              child: Image.asset(
                imageAsset,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.fastfood,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
            ),

            // 3. طبقة النصوص والزر في الأسفل (فوق الخلفية الجوزية)
            Positioned(
              left: 16,
              right: 12,
              bottom: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                     CustomText(
                      text: title,  
                      color: Colors.white,
                      fontweight: FontWeight.w500,
                      fontsize: 20,
                      
                    ),
                
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onAddTap,
                      customBorder: const CircleBorder(),
                      splashColor: Colors.white24,
                      child: Ink(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE5293E), // الزر الأحمر
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}