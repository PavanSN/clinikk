import 'package:clinikk/features/home/controllers/home_controller.dart';
import 'package:clinikk/features/home/static/models/post_model.dart';
import 'package:clinikk/features/home/view/edit_delete_bottomsheet.dart';
import 'package:clinikk/features/home/view/home_screen.dart';
import 'package:clinikk/features/home/view/search_screen.dart';
import 'package:clinikk/shared/global_controllers/theme_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseLayout extends StatelessWidget {
  BaseLayout({
    super.key,
  });

  List<Widget> body = [
    const HomeScreen(),
    const SearchScreen(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, homeCont, _) {
        return Scaffold(
          backgroundColor: ThemeHandler().themeData.scaffoldColor,
          bottomNavigationBar: const NavBar(),
          appBar: AppBar(
            backgroundColor: ThemeHandler().themeData.greyColor,
            title: Text(
              homeCont.tabName,
              style: TextStyle(
                color: ThemeHandler().themeData.iconColor,
              ),
            ),
          ),
          body: body[homeCont.tabIndex],
        );
      },
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ColoredBox(
      color: ThemeHandler().themeData.greyColor,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: 80,
              width: screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _button(
                    text: 'Home',
                    onPressed: () {
                      context.read<HomeController>().navToTab(0);
                    },
                    icon: Icons.home,
                  ),
                  _button(
                    text: 'Search',
                    onPressed: () {
                      context.read<HomeController>().navToTab(1);
                    },
                    icon: Icons.search,
                  ),
                  Container(),
                  _button(
                    text: 'Alert',
                    onPressed: () {
                      context.read<HomeController>().navToTab(3);
                    },
                    icon: Icons.alarm,
                  ),
                  _button(
                    text: 'Profile',
                    onPressed: () {
                      context.read<HomeController>().navToTab(4);
                    },
                    icon: Icons.account_circle,
                  ),
                ],
              ),
            ),
            Positioned(
              top: -30,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: ThemeHandler().themeData.primaryColor,
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: ThemeHandler().themeData.iconColor,
                  ),
                  onPressed: () {
                    EditDeleteBottomsheet.showEditSheet(
                      Post(),
                      context,
                      false,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _button({
    required String text,
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            icon,
            color: ThemeHandler().themeData.iconColor,
          ),
          onPressed: onPressed,
        ),
        Text(
          text,
          style: TextStyle(
            color: ThemeHandler().themeData.iconColor,
          ),
        ),
      ],
    );
  }
}
