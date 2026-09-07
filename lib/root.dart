import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  void _onTapNavItem(int index) {
    cntroller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => currentScreen = index);
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData selectedIcon,
    required String label,
  }) {
    final bool selected = currentScreen == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _onTapNavItem(index),
      child:
          selected
              ? Container( 
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(30)
                ),
                child:  Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(selectedIcon, color: Colors.black87, size: 20),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          )

              : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: Colors.grey.shade500, size: 22),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
    );
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.40),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.fromLTRB(20, 14,20, 14),
            child: SafeArea(
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(
                    index: 0,
                    icon: CupertinoIcons.home,
                    selectedIcon: CupertinoIcons.home,
                    label: 'Home',
                  ),
                  _buildNavItem(
                    index: 1,
                    icon: CupertinoIcons.cart,
                    selectedIcon: CupertinoIcons.cart,
                    label: 'Cart',
                  ),
                  _buildNavItem(
                    index: 2,
                    icon: Icons.local_restaurant_sharp,
                    selectedIcon: Icons.local_restaurant_sharp,
                    label: 'History',
                  ),
                  _buildNavItem(
                    index: 3,
                    icon: CupertinoIcons.person,
                    selectedIcon: CupertinoIcons.back,
                    label: 'Profile',
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
