import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/shared/custom_button.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:gap/gap.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView.builder(
            itemCount: 4,
            padding: const EdgeInsets.only(top: 10, bottom: 120),
            itemBuilder: (_, index) {
              return Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical:20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Image.asset('assets/test/test1.png', width: 100),
                       Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        CustomText(text: 'Hamburger', fontweight: FontWeight.bold),
                        CustomText(text: 'Qty : X3'),
                        CustomText(text: 'Price : \$12.99', fontweight: FontWeight.bold),
                      ],
                                      ),
                                  
                           
                        ],
                      ),
                  
                      Gap(20),
                      CustomButton(text: 'Order Again', onPressed: (){}, width: 400,color: Colors.grey.shade400),
                    ],
                  ),
                ),
              );
            },
          ),
        ),  
    );
  }
}