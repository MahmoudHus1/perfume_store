import 'package:flutter/material.dart';
import 'package:perfume_store/app_router/app_router.dart';
import 'package:perfume_store/component/custom_text.dart';
import 'package:perfume_store/core/constant/colors.dart';
import 'package:perfume_store/view/admin/add_category.dart';
import 'package:perfume_store/view/admin/display_categories.dart';
import 'package:perfume_store/view/admin/profile_page.dart';
import 'package:provider/provider.dart';

import '../../component/my_drawer_header.dart';
import '../../providers/auth_provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  var currentPage = DrawerSection.myProfile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).signOut();
              },
              icon: const Icon(Icons.logout, color: AppColors.primaryColor,))
        ],
        title: const Center(
            child: CustomText(
                text: 'Admin Profile',
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.secondColor,
      ),
      body: ProfilePage(),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [const MyHeaderDrawer(), const Divider(color: AppColors.primaryColor,),MyDrawerList()],
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(1, 'My profile', Icons.dashboard_outlined,
              currentPage == DrawerSection.myProfile ? true : false),
          menuItem(2, 'Add new category', Icons.category_outlined,
              currentPage == DrawerSection.addNewCategory ? true : false),
          menuItem(3, 'Show all category', Icons.list_alt_outlined,
              currentPage == DrawerSection.listAllCategory ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? AppColors.primaryColor : Colors.transparent,
      child: InkWell(
        onTap: () {
          AppRouter.appRouter.hideDialoug();
          setState(() {
            if (id == 1) {
              currentPage = DrawerSection.myProfile;
              AppRouter.appRouter.goToWidgetAndReplace(AdminPage());
            } else if (id == 2) {
              currentPage = DrawerSection.addNewCategory;
              AppRouter.appRouter.goToWidget(AddNewCategory());
            } else if (id == 3) {
              currentPage = DrawerSection.listAllCategory;
              AppRouter.appRouter.goToWidget(AllCategoriesScreen());
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(
                  child: Icon(
                icon,
                size: 20,
                color: AppColors.secondColor,
              )),
              Expanded(
                  flex: 3,
                  child: CustomText(
                    text: title,
                    fontSize: 16,
                    color: AppColors.secondColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSection {
  myProfile,
  addNewCategory,
  listAllCategory,
}
