import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/Core/Network/api_erorr.dart';
import 'package:flutter_application_hungray/Core/Network/api_service.dart';
import 'package:flutter_application_hungray/Features/auth/data/auth_repo.dart';
import 'package:flutter_application_hungray/Features/auth/view/signup_view.dart';
import 'package:flutter_application_hungray/Features/auth/widgets/custom_btn.dart';
import 'package:flutter_application_hungray/Features/auth/widgets/custom_user_text_filed.dart';
import 'package:flutter_application_hungray/root.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  bool isLoading = false;

  AuthRepo authRepo = AuthRepo();

  Future<void> login() async {

   if (formKey.currentState!.validate()) 
    setState(() => isLoading = true);{ // هذا الشرط يتحقق من صحة النموذج قبل متابعة عملية تسجيل الدخول يسوي فارغ الحقول اذا كانت صحيحة
    try {
     final user = await authRepo.login(emailController.text.trim(), passwordController.text.trim());
     if (!context.mounted) return;
     if (user !=null){
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (c) => const Root()),
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
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          backgroundColor: Colors.red.shade900,
          content: Row(
            children: [

            Icon(CupertinoIcons.info,color: Colors.white,),
            Gap(14),
            
              CustomText(
                text: errorMsg,
                color: Colors.white,
                fontsize: 12,
                fontweight: FontWeight.w600,
              ),
            ],
          ),
        ),
      );
   } 
   }
  }

  





 
  @override
  void dispose() {
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
      validator:
          (value) =>
              (value == null || value.trim().isEmpty)
                  ? "Please enter your $hint"
                  : null,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54, fontSize: 19),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: _border(const Color(0xFFD5D5D5)),
        focusedBorder: _border(const Color(0xFFB8B8B8)),
        errorBorder: _border(const Color(0xFFFFD0D0)),
        focusedErrorBorder: _border(const Color(0xFFB8B8B8)),
        suffixIcon:
            isPassword
                ? IconButton(
                  onPressed:
                      () => setState(() => obscurePassword = !obscurePassword),
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
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
                colorFilter: ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
                height: 58,
              ),
              const Gap(18),
              const Text(
                "Welcome to our Food App",
                style: TextStyle(
                  color: Color(0xFF565656),
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(flex: 1),
              Expanded(
                flex: 6,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(22, 34, 22, 24),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: StretchingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Column(
                        children: [
                          CustomUserTextField(
                            controller: emailController,
                            labelText: "Email",
                          ),
                          CustomUserTextField(
                            controller: passwordController,
                            labelText: "Password",
                            isPassword: true,
                          ),
                          const Gap(26),
                         
                           Column(
                              children: [
                                isLoading ? CupertinoActivityIndicator(
                            color: Colors.white,)
                                :CustomAuthBtn(
                                  onTap: login,
                                  text: "Login",
                                  color: Colors.white,
                                  fontsize: 20,
                                  fontweight: FontWeight.w600,
                                  height: 50,
                                  width: double.infinity,
                                ),

                                const Gap(20),

                                CustomAuthBtn(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SignupView(),
                                      ),
                                    );
                                  },
                                  text: "Create an account",
                                  color: AppColors.primary,
                                  fontsize: 20,
                                  fontweight: FontWeight.w600,
                                  backgroundColor: Colors.white,
                                  height: 50,
                                  width: double.infinity,
                                ),
                              ],
                            ),
                             
                           
                          const Gap(20),

                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Root(),
                                ),
                              );
                            },
                            child: const Text(
                              "Continue as Guest ?",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
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
