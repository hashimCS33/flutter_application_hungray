import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/custom_user_text_filed.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:gap/gap.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _password = TextEditingController();

  String selectedPaymentMethod = 'Visa';

  @override
  void initState() {
    super.initState();
    _name.text = 'John Doe';
    _email.text = 'johndoe@example.com';
    _address.text = '123 Main St';
    _password.text = 'password123';
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
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        scrolledUnderElevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            child: SvgPicture.asset(
              'assets/icons/settings.svg',
              width: 20,
              height: 24,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrb4OvIZOz-Z2RvlJ0xDl1E_e3qOfh_TQK1va1Z7gJ4g&s=10',
                      ),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(color: Colors.white, width: 5),
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Gap(10),
              CustomUserTextField(controller: _name, labelText: 'Name'),
              Gap(10),
              CustomUserTextField(controller: _email, labelText: 'Email'),
              Gap(10),
              CustomUserTextField(
                controller: _address,
                labelText: 'Delivery address',
              ),
              Gap(10),
              CustomUserTextField(
                controller: _password,
                labelText: 'Password',
                isPassword:  true,
                suffixIcon: Icon(Icons.lock, color: Colors.white54, size: 18),
              ),
              Gap(20),
              Divider(color: Colors.white, thickness: 1),
              Gap(10),
              Material(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color:
                          selectedPaymentMethod == 'Visa'
                              ? Colors.blue
                              : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: ListTile(
                    onTap: () => setState(() => selectedPaymentMethod = 'Visa'),
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
                      text: '3566 **** **** 0505',
                      fontweight: FontWeight.w400,
                      fontsize: 13,
                      color: Colors.black54,
                    ),
                    trailing: Radio<String>(
                      activeColor: AppColors.primary,
                      value: 'Visa',
                      groupValue: selectedPaymentMethod,
                      onChanged:
                          (value) =>
                              setState(() => selectedPaymentMethod = value!),
                    ),
                  ),
                ),
              ),
              Gap(400),
            ],
          ),
        ),
      ),

      bottomSheet: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 20)],
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Edit profile button
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    CustomText(
                      text: 'Edit profile',
                      color: Colors.white,
                      fontsize: 16,
                      fontweight: FontWeight.w600,
                    ),
                    Gap(10),
                    Icon(CupertinoIcons.pencil, color: Colors.white, size: 20),
                  ],
                ),
              ),

              // Logout button
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.primary, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    CustomText(
                      text: 'Logout',
                      color: AppColors.primary,
                      fontsize: 16,
                      fontweight: FontWeight.w600,
                    ),
                    Gap(10),
                    Icon(
                      CupertinoIcons.arrow_right_square,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
