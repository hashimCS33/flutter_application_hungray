import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/Features/auth/view/login_view.dart';
import 'package:flutter_application_hungray/Features/auth/widgets/custom_btn.dart';
import 'package:flutter_application_hungray/Features/auth/widgets/custom_user_text_filed.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool obscurePassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: color, width: 1.2),
      );

  Widget _field({
    required TextEditingController controller,
    required String hint,
    bool isPassword = false,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && obscurePassword,
      keyboardType: keyboardType,
      style: const TextStyle(color: Color(0xFF1D3C1F), fontSize: 19),
      validator: (value) => (value == null || value.trim().isEmpty) ? "Please enter your $hint" : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54, fontSize: 19),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: _border(const Color(0xFFD5D5D5)),
        focusedBorder: _border(const Color(0xFFB8B8B8)),
        errorBorder: _border(const Color(0xFFFFD0D0)),
        focusedErrorBorder: _border(const Color(0xFFB8B8B8)),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: () => setState(() => obscurePassword = !obscurePassword),
                icon: Icon(
                  obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: Colors.black45,
                ),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              const Gap(36),
              SvgPicture.asset(
                "assets/logo/logo.svg",
                colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                height: 58,
              ),
              const Gap(18),
              const Text(
                "Create an account",
                style: TextStyle(color: Color(0xFF565656), fontSize: 24, fontWeight: FontWeight.w400),
              ),
              const Spacer(flex: 1),
              Expanded(
                flex: 6,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(22, 34, 22, 24),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
                  ),
                  child: StretchingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Column(
                      children: [
                        CustomUserTextField(controller: nameController, labelText: "Name"),
                        const Gap(20),
                        CustomUserTextField(controller: emailController, labelText: "Email", keyboardType: TextInputType.emailAddress),
                        const Gap(20),
                        CustomUserTextField(controller: passwordController, labelText: "Password", isPassword: true, suffixIcon: Icon(Icons.lock, color: Colors.white54, size: 18)),
                        const Gap(26),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: CustomAuthBtn(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                // Handle sign up logic here
                              }
                            },
                            text: "Sign Up",
                            color: Colors.white,
                            backgroundColor: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child:CustomAuthBtn(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginView()),
                              );
                            },
                            text: "back to login ",
                            color: AppColors.primary,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}