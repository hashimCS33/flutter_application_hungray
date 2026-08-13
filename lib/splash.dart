import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/Features/auth/view/login_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// أضفنا الـ SingleTickerProviderStateMixin لتوفير الـ vsync للأنيميشن
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // 1. إعداد متحكم الأنيميشن (المدة ثانية ونصف)
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // 2. تطبيق منحنى حركة مرن (بونص خفيف ولطيف عند الظهور)
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    // 3. تشغيل الأنيميشن
    _controller.forward();

    // 4. الانتقال للشاشة التالية بعد 3 ثوانٍ
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (c) => const LoginView()),
      );
    });
  }

  @override
  void dispose() {
    // مهم جداً للتخلص من المتحكم في الذاكرة لتجنب أي Memory Leak
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          children: [
            const Gap(280),
            // هنا قمنا بلف اللوغو بالأنيميشن الخاص بالـ Scale والـ Fade
            FadeTransition(
              opacity: _controller,
              child: ScaleTransition(
                scale: _animation,
                child: SvgPicture.asset("assets/logo/logo.svg"),
              ),
            ),
            const Spacer(),
            Image.asset("assets/splash/splash.png"),
          ],
        ),
      ),
    );
  }
}
