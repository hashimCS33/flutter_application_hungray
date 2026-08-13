import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/Features/cart/view/CartView.dart';
import 'package:flutter_application_hungray/Features/auth/view/profile_view.dart';
import 'package:flutter_application_hungray/Features/home/views/HomeView.dart';
import 'package:flutter_application_hungray/Features/orderHistory/view/order_history_view.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late PageController cntroller;
  int currentScreen = 0;

  static const int _pageCount = 4;

  @override
  void initState() {
    super.initState();
    cntroller = PageController(initialPage: currentScreen);
  }

  @override
  void dispose() {
    cntroller.dispose();
    super.dispose();
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const CartView();
      case 2:
        return const OrderHistoryView();
      case 3:
      default:
        return const ProfileView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.custom(
        controller: cntroller,
        physics: const NeverScrollableScrollPhysics(),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => _buildPage(index),
          childCount: _pageCount,
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade700,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                currentIndex: currentScreen,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey.shade400.withValues(
                  alpha: 0.5,
                ),
                onTap: (index) {
                  cntroller.animateToPage(
                    index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  setState(() {
                    currentScreen = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.cart),
                    label: "Cart",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.local_restaurant_sharp),
                    label: "Orders History",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person),
                    label: "Profile",
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
