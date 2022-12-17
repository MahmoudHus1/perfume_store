import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:perfume_store/core/constant/colors.dart';
import 'package:perfume_store/view/cart_screen.dart';
import 'package:perfume_store/view/profile_screen.dart';
import 'package:perfume_store/view/user_interface_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
      int _selectedIndex = 0;
  static final List<Widget> _navScreens = <Widget>[
    const UserInterface(),
    const CartScreen(),
    const AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
        child: _navScreens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        color: AppColors.secondColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GNav(
            tabBorderRadius: 15,
            tabActiveBorder: Border.all(color: AppColors.secondColor.withOpacity(0.5), width: 1),
            tabBorder: Border.all(color: AppColors.secondColor.withOpacity(0.5), width: 1),
            duration: const Duration(milliseconds: 600),
            backgroundColor: AppColors.secondColor,
            color: AppColors.primaryColor,
            tabBackgroundColor: AppColors.primaryColor.withOpacity(0.1),
            activeColor: AppColors.primaryColor,
            padding: const EdgeInsets.all(10),
            gap: 10,
            tabs: const [
              GButton(icon: Icons.explore, text: 'Explore'),
              GButton(
                icon: Icons.shopping_cart,
                text: 'Cart',
              ),
              GButton(
                icon: Icons.account_circle_outlined,
                text: 'Account',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
          ),
        ),
      ),
    );
  }
}