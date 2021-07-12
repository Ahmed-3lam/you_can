import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_can/HomeView/Provider/home_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, _) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: <IconData>[
              Icons.home_outlined,
              Icons.article_outlined,
              Icons.view_carousel_outlined,
              Icons.account_circle_outlined
            ],

            activeIndex: homeProvider.pageIndex,
            activeColor: Colors.red,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.smoothEdge,
            onTap: (index) {
              homeProvider.changePages(index);
            },
            //other params
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              homeProvider.changePages(5);
            },
            child: Icon(
              Icons.add,
              size: 30,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: homeProvider.changeWidget(),
        );
      },
    );
  }
}
