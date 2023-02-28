import 'package:auctioncarapp/Screen/Dashbord/dashbord_screen.dart';
import 'package:auctioncarapp/Screen/Galllery/galley_screen.dart';
import 'package:flutter/material.dart';

import '../../components/custom_app_bar.dart';
import '../../constants.dart';
import '../AddProductForm/addproduct_screen.dart';
import '../Analytics/analytics_screen.dart';
import '../Profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomeScreen> {
  var currentIndex = 0;
  final pages = [
    GalleryScreen(),
    DashbordScreen(),
    AddProoductScreen(),
    AnalyticsScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Auction Car",
        backGroundColor: Colors.deepOrange,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Post',
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Profile',
            backgroundColor: kPrimaryColor,
          )
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: pages[currentIndex],
    );
  }
}
