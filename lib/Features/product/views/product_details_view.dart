import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Features/product/widget/spicy_slider.dart';
import 'package:flutter_application_hungray/Features/product/widget/topping_card.dart';
import 'package:flutter_application_hungray/shared/custom_button.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:gap/gap.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  bool isSpicy = false;
  double sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Product Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpicySlider(
                sliderValue: sliderValue,
                onSliderChanged: (value) => setState(() => sliderValue = value),
              ),
          
              const Gap(24),
          
              CustomText(
                text: 'toppings',
                fontweight: FontWeight.bold,
                fontsize: 20,
              ),
              const Gap(8),
              SizedBox(
                height: 180,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(5, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: ToppingCard(
                          title: 'Tomate',
                          imageAsset: 'assets/test/test2.png',
                          onAddTap: () {
                            // Handle add topping
                          },
                        ),
                      );
                    }),
                  ),
                ),
              ),
              
              Gap(20),
              CustomText(
                text: 'Side Options',
                fontweight: FontWeight.bold,
                fontsize: 20,
              ),
              const Gap(8),
              SizedBox(
                height: 180,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(5, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: ToppingCard(
                          title: 'Tomate',
                          imageAsset: 'assets/test/test2.png',
                          onAddTap: () {
                            // Handle add topping
                          },
                        ),
                      );
                    }),
                  ),
                ),
              ),
                Gap(40),
      
               
                Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Column(
                    children: [
                      CustomText(
                        text: 'Total ',
                        color: Colors.grey,
                        fontweight: FontWeight.bold,
                        fontsize: 30,
                      ),

                      CustomText(
                        text: '\$12.99',
                        fontweight: FontWeight.bold,
                        fontsize:30,
                      ),
                    ]      
                  ),
                   CustomButton(
                text: 'Add to Cart',
                onPressed: () {
                  // Handle add to cart action
                },
               ),
                
                ],) , 

                Gap(100),

              

            ],
          ),
        ),
      ),
    );
  }
}
