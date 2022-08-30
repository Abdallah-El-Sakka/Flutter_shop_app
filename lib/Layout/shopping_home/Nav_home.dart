import 'package:Aqua/Bloc/Cubit.dart';
import 'package:Aqua/Layout/shopping_home/profile_screen.dart';
import 'package:Aqua/Layout/shopping_home/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'cart_screen.dart';
import 'favourites_screen.dart';
import 'homeScreen.dart';

class NavHomeScreen extends StatefulWidget
{

  @override
  State<NavHomeScreen> createState() => _NavHomeScreenState();
}

class _NavHomeScreenState extends State<NavHomeScreen>
{

  int currentNavIndex = 0;

  List<Widget> screens =
  [
    HomeScreen(),
    FavouritesScreen(),
    SearchScreen(),
    ProfileScreen()
  ];

  List<Color> navColors =
  [
    Colors.pink.withOpacity(0.6),
    Colors.red.withOpacity(0.6),
    Colors.amber.withOpacity(0.6),
    Colors.green.withOpacity(0.6)
  ];

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (context) => ShoppingCubit()..getHomeData()..getCategoriesData()..getFavouritesData()..getUserData(),
      child: Scaffold(
        body: Center(
          child: screens[currentNavIndex],
        ),
        bottomNavigationBar: Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade200
          ),
          padding: EdgeInsetsDirectional.all(5),

          child: GNav(
              selectedIndex: currentNavIndex,
              onTabChange: (index)
              {
                currentNavIndex = index;
                setState(() {});
              },
              rippleColor: Colors.grey.withOpacity(0.3), // tab button ripple color when pressed
              hoverColor: Colors.grey.withOpacity(0.3), // tab button hover color
              haptic: true, // haptic feedback
              tabBorderRadius: 30,
              //tabActiveBorder: Border.all(color: Colors.black, width: 1), // tab button border
              //tabBorder: Border.all(color: Colors.grey, width: 1), // tab button border
              //tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
              curve: Curves.linear, // tab animation curves
              duration: Duration(milliseconds: 500), // tab animation duration
              gap: 8, // the tab button gap between icon and text
              color: Colors.black.withOpacity(0.8), // unselected icon color
              activeColor: Colors.white, // selected icon and text color
              iconSize: 24, // tab button icon size
              tabBackgroundColor: navColors[currentNavIndex], // selected tab background color
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // navigation bar padding
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'Liked',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ]
          ),
        ),
      ),
    );
  }
}
