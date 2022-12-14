import 'package:flutter/material.dart';
import 'package:task_manager/page/calendar_page.dart';
import 'package:task_manager/page/home_page.dart';
import 'package:task_manager/page/notifications_page.dart';
import 'package:task_manager/page/settings_page.dart';
import 'package:task_manager/providers/constants.dart';


class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int currentIndex = 0;
  var child = [
    const HomePage(),
    const CalendarPage(),
    const NotificationPage(),
    const SettingsPage()
  ];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      extendBody: true,
      body: child[currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 8)
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).unselectedWidgetColor,
            elevation: 5.0,
            showSelectedLabels: false,
            currentIndex: currentIndex,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home,',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none_outlined),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              )
            ],
            onTap: onTap,
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    List<String> partsOfFio = user!.fio.split(' ');
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: [
        CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Text(partsOfFio[1][0] + partsOfFio[0][0]),
        )
      ],
    );
  }
}
