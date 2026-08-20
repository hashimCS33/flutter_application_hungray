import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/Core/Network/api_erorr.dart';
import 'package:flutter_application_hungray/Features/auth/data/auth_repo.dart';
import 'package:flutter_application_hungray/Features/auth/view/login_view.dart';
import 'package:flutter_application_hungray/Features/auth/widgets/custom_btn.dart';
import 'package:flutter_application_hungray/Features/auth/widgets/custom_user_text_filed.dart';
import 'package:flutter_application_hungray/shared/custom_Snack.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool obscurePassword = true;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  
  AuthRepo authRepo = AuthRepo();
  bool isLoading = false;
  Future<void>Signup() async{
  

    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);
    }{
      try {
        final user = await authRepo.signup(nameController.text.trim(), emailController.text.trim(), passwordController.text.trim());
        if (!context.mounted) return;
        if (user !=null){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (c) => const LoginView()),
            (route) => false,
          );
        }
        
         setState(() => isLoading = false);
    } catch (e) {
      setState(() => isLoading = false);
      String errorMsg = "unhandled error";
      if (e is ApiErorr){
       errorMsg = e.message;
      }
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(errorMsg));
    } 
    }



  }



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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 22),
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
                  const Gap(40),

                  Container(
                     width: double.infinity,
                     padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F0EA),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                    children: [
                      CustomUserTextField(controller: nameController, labelText: "Name"),
                      const Gap(14),
                      CustomUserTextField(controller: emailController, labelText: "Email", keyboardType: TextInputType.emailAddress),
                      const Gap(14),
                      CustomUserTextField(controller: passwordController, labelText: "Password", isPassword: true, suffixIcon: Icon(Icons.lock, color: Colors.white54, size: 18)),
                      const Gap(24),
                      isLoading ? CupertinoActivityIndicator(color: Colors.white) 
                      :CustomAuthBtn(
                                onTap: Signup,
                                text: "Sign Up",
                                color: AppColors.primary,
                                fontsize: 20,
                                fontweight: FontWeight.w600,
                                height: 50,
                                width: double.infinity,
                                backgroundColor: Colors.white,
                              ),
                       const Gap(16),
                                    
                        SizedBox(
                          height: 50,
                          child: CustomAuthBtn(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (c) => const LoginView()),
                                  (route) => false,
                                );
                              },
                              text: "back to login",
                              textColor: Colors.black, 
                              color: AppColors.primary,
                              fontsize: 20,
                              fontweight: FontWeight.w600,
                              height: 50,
                              width: double.infinity,
                              backgroundColor: Colors.white,      
                                                           
                            ),
                        ),
                        
                    ],
                   ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}