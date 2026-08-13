import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Features/cart/widgets/cart_item.dart';
import 'package:flutter_application_hungray/Features/checkout/views/checkout_view.dart';
import 'package:flutter_application_hungray/shared/custom_button.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:gap/gap.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  static const double itemPrice = 12.99;
  late List<int> quantitys;

  @override
  void initState() {
    super.initState();
    quantitys = List.generate(20, (_) => 1);
  }

  void onAdd(int index) {
    setState(() {
      quantitys[index] += 1;
    });
  }

  void onMins(int index) {
    if (quantitys[index] == 1) return;
    setState(() {
      quantitys[index] -= 1;
    });
  }

  void onRemoveItem(int index) {
    setState(() {
      quantitys.removeAt(index);
    });
  }

  double get totalPrice {
    int totalItems = quantitys.fold(0, (sum, count) => sum + count);
    return totalItems * itemPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 16, bottom: 130),
            itemCount: quantitys.length,
            separatorBuilder: (_, __) => const Gap(10),
            itemBuilder: (_, index) {
              return CartItem(
                image: 'assets/test/test1.png',
                text: 'Hamburger',
                desc: 'Veggie Burger',
                onAdd: () => onAdd(index),
                onMins: () => onMins(index),
                onRemoveItem: () => onRemoveItem(index),
                num: quantitys[index],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Color(0xFFEAEAEA)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Total',
                    fontweight: FontWeight.bold,
                    fontsize: 16,
                    color: Colors.grey,
                  ),
                  Gap(4),
                  CustomText(
                    text: '\$${totalPrice.toStringAsFixed(2)}',
                    fontweight: FontWeight.bold,
                    fontsize: 24,
                  ),
                ],
              ),
              CustomButton(
                text: 'Checkout',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>  CheckoutView()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
