import 'package:flutter/material.dart';
import 'package:you_can/Constants/color_constants.dart';
import 'package:you_can/ViewsView/MainChallengeScreen.dart';
import 'package:you_can/ViewsView/challenges_page.dart';
import 'package:you_can/ViewsView/real_life_page.dart';

class ViewsPage extends StatefulWidget {
  const ViewsPage({Key key}) : super(key: key);

  @override
  _ViewsPageState createState() => _ViewsPageState();
}

class _ViewsPageState extends State<ViewsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Views', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: ColorsConstants.lightBlueColor,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(text: 'Challenges'),
                    Tab(text: 'Real life '),
                  ],
                ),
              ),
              // tab bar view here
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [MainChallengeScreen(), HomeScreen()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
