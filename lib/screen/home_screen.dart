import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_ps/screen/screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final items = const [
    Icon(
      Icons.list,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.map_sharp,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.home,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.add,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.account_box,
      size: 30,
      color: Colors.white,
    ),
  ];

  int index = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.blue[300],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: const Color(0xff3e13b5),
          items: items,
          index: index,
          onTap: (selctedIndex) {
            setState(() {
              index = selctedIndex;
            });
          },
          height: 70,
          //backgroundColor: Colors.blue,
          animationDuration: const Duration(milliseconds: 300),
          // animationCurve: ,
        ),
        body: getSelectedWidget(index: index));
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const ListReportScreen();
        break;
      case 1:
        widget = const Maps();
        break;
      case 2:
        widget = const WelcomeScreen();
        break;
      case 3:
        widget = const ReportScreen();
        break;
      case 4:
        widget = const ProfileScreen();
        break;
      default:
        widget = const WelcomeScreen();
        break;
    }
    return widget;
  }
}
