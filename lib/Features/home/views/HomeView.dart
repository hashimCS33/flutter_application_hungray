import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Features/home/Widgets/card_item.dart';
import 'package:flutter_application_hungray/Features/home/Widgets/food_catrgory.dart';
import 'package:flutter_application_hungray/Features/home/Widgets/search_field.dart';
import 'package:flutter_application_hungray/Features/home/Widgets/user_header.dart';
import 'package:flutter_application_hungray/Features/product/views/product_details_view.dart';
import 'package:gap/gap.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List category = ['All', 'Combo', 'Sliders', 'Classic'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              floating: false,
              pinned: true,
              toolbarHeight: 200,
              scrolledUnderElevation: 0,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 39,right: 20,left: 20),
                child: Column(
                  children: [
                    const UserHeader(),
                    const Gap(20),
                    const SearchField(),
                  
                  ],
                ),
              ),
            ),


           ///Header and search field
            SliverToBoxAdapter(
              child:FoodCategory(category: category, selectedIndex: selectedIndex
              )),

            ///GridView
            SliverPadding(
              
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid.builder(  
                itemCount: 6,
                itemBuilder: (context, index) {
                                                                                                           
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the product details view when a card is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProductDetailsView()),
                      );
                    },
                    child: const CardItem(
                      image: "assets/test/test1.png",
                      name: "chicken burger",
                      description: "Wenday, 2.5km",
                      rating: "4.5",
                    ),
                  );
                },
                                                             
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
