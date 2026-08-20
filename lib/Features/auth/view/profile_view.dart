import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Network/api_erorr.dart';
import 'package:flutter_application_hungray/Core/utils/image_helper.dart';
import 'package:flutter_application_hungray/Features/auth/data/auth_repo.dart';
import 'package:flutter_application_hungray/Features/auth/data/user_model.dart';
import 'package:flutter_application_hungray/Features/auth/view/login_view.dart';
import 'package:flutter_application_hungray/Features/auth/widgets/custom_btn.dart';
import 'package:flutter_application_hungray/shared/custom_snack.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../widgets/custom_user_text_filed.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:gap/gap.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String selectedPaymentMethod = 'Visa';
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _visa = TextEditingController();

  UserModel? userModel;
  AuthRepo authRepo = AuthRepo();

  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      setState(() {
        userModel = user;
      });
    } catch (e) {
      String erorrmsg = "Unexpected Erorr form server";
      if (e is ApiErorr) {
        erorrmsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(erorrmsg));
    }
  }

  @override
  void initState() {
    getProfileData().then((v) {
      if (userModel != null) {
        _name.text = userModel!.name ?? '';
        _email.text = userModel!.Email ?? '';
        _address.text =
            userModel?.address != null
                ? "55 Najfa, IRAQ"
                : userModel!
                    .address!; // Set the address to "adress" if it's null, otherwise use the actual address
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _address.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 60,
      color: Colors.white,
      backgroundColor: AppColors.primary,
      onRefresh: () async {
        await getProfileData();
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(238, 255, 255, 255),

          //App bar with settings icon
          appBar: AppBar(
            toolbarHeight: 0.0,
            backgroundColor: Colors.white,
            elevation: 0.0,
            scrolledUnderElevation: 0.0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: SingleChildScrollView(
              child: Skeletonizer(
                enabled: userModel == null,
                child: Column(
                  children: [
                    Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Profile',
                          fontweight: FontWeight.w600,
                          fontsize: 24,
                          color: Colors.black87,
                        ),
                        Gap(20),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: SvgPicture.asset(
                            'assets/icons/settings.svg',
                            height: 24,
                            width: 24,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
          
                    Gap(20),
          
                    // Profile picture
                    Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image:
                              userModel?.imageUrl != null &&
                                      userModel!.imageUrl!.isNotEmpty
                                  ? DecorationImage(
                                    image: NetworkImage(
                                      ImageHelper.getImageUrl(
                                        userModel!.imageUrl!,
                                      ),
                                    ),
          
                                    fit: BoxFit.cover,
                                  )
                                  : null,
                          border: Border.all(
                            color: AppColors.primary,
                            width: 2,
                          ),
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
          
                    Gap(20),
          
                    // User information fields
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          CustomUserTextField(
                            controller: _name,
                            labelText: 'Name',
                            keyboardType: TextInputType.name,
                            hinttext: 'Enter your Name',
                          ),
          
                          Gap(10),
                          CustomUserTextField(
                            controller: _email,
                            labelText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            hinttext: 'Enter your Email',
                          ),
          
                          Gap(10),
                          CustomUserTextField(
                            controller: _address,
                            labelText: 'Delivery address',
                            keyboardType: TextInputType.streetAddress,
                            hinttext: 'Enter your Delivery address',
                          ),
                        ],
                      ),
                    ),
          
                    Gap(20),
                    Divider(
                      color: const Color.fromARGB(255, 14, 13, 13),
                      thickness: 1,
                    ),
                    Gap(10),
          
                    userModel?.visa !=
                            null // Check if the user has a Visa card edit تعديل لانه اكو مشكلة انه كارد ما جاي يطلع null
                        ? CustomUserTextField(
                          controller: _visa,
                          labelText: 'Visa card',
                          keyboardType: TextInputType.number,
                          hinttext: 'ADD VISA CARD',
                        )
                        : Material(
                          color: const Color(0xFFD6EAF3),
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color:
                                    selectedPaymentMethod == 'Visa'
                                        ? AppColors.primary
                                        : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: ListTile(
                              onTap:
                                  () => setState(
                                    () => selectedPaymentMethod = 'Visa',
                                  ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 16,
                              ),
                              leading: Image.asset(
                                'assets/icons/visa.png',
                                height: 60,
                                width: 48,
                                fit: BoxFit.contain,
                              ),
                              title: CustomText(
                                text: 'Debit card',
                                fontweight: FontWeight.w600,
                                fontsize: 16,
                                color: Colors.black87,
                              ),
                              subtitle: CustomText(
                                text:
                                    userModel?.visa ??
                                    "**** **** **** 2342", // بعجل ما يكون عندك رقم البطاقة الحقيقي، ممكن تحط أي نص هنا بعدين ارجعها
                                fontweight: FontWeight.w400,
                                fontsize: 13,
                                color: Colors.black54,
                              ),
                              trailing: Radio<String>(
                                activeColor: AppColors.primary,
                                value: 'Visa',
                                groupValue: selectedPaymentMethod,
                                onChanged:
                                    (value) => setState(
                                      () => selectedPaymentMethod = value!,
                                    ),
                              ),
                            ),
                          ),
                        ),
                    Gap(400),
                  ],
                ),
              ),
            ),
          ),

          bottomSheet: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey.shade400, blurRadius: 20),
              ],
            ),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Edit profile button
                  Row(
                    children: [
                      CustomAuthBtn(
                        onTap: () {
                          // Handle edit profile action
                        },
                        text: 'Edit Profile',
                        color: AppColors.primary,
                        fontsize: 24,
                        fontweight: FontWeight.w600,
                        height: 40,
                        width: 170,
                        backgroundColor: Colors.white,
                        showbroder: false,
                      ),

                      Icon(
                        CupertinoIcons.pencil,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ],
                  ),

                  // Logout button
                  Row(
                    children: [
                      CustomAuthBtn(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (c) => const LoginView(),
                            ),
                            (route) => false,
                          );
                        },
                        text: 'Logout',
                        color: AppColors.primary,
                        fontsize: 24,
                        fontweight: FontWeight.w600,
                        height: 40,
                        width: 140,
                        backgroundColor: Colors.white,
                        showbroder: false,
                      ),

                      Icon(
                        CupertinoIcons.arrow_right_square,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ],
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
