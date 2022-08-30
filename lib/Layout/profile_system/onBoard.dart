import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login_screen.dart';

class OnBoardingScreen extends StatelessWidget
{

  var pageViewController = PageController();

  bool isLast = false;

  List<dynamic> photos =
  [
    'assets/images/shopping1.jpg',
    'assets/images/shopping2.jpg',
    'assets/images/shopping3.jpg'
  ];

  List<dynamic> titles =
  [
    'Shop Online With Aqua !',
    'Buy products from anywhere!',
    'Directly from our store!'
  ];

  List<dynamic> bodies =
  [
    'With our best deals you can find whatever you want.',
    'Because we have +100 stores around you can order.',
    'Best delivery service with no fees'
  ];

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions:
        [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(

                onPressed: ()
                {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen())
                  );
                },
                child: Row(
                  children:
                  [
                    Text('Skip'),
                    Icon(Icons.arrow_forward_rounded)
                  ],
                )
            ),
          )
        ],
      ),
      body: Column(
        children:
        [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: PageView.builder(
                onPageChanged: (index)
                {
                  if(index == photos.length - 1)
                  {
                    isLast = true;
                  }
                  else
                  {
                    isLast = false;
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: pageViewController,
                itemBuilder: (context , index) => pageViewListBuilder(index),
                itemCount: photos.length,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Row(
              children:
              [
                SmoothPageIndicator(
                    controller: pageViewController,
                    count: photos.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.pink,
                    dotHeight: 2,
                    dotWidth: 20,
                    expansionFactor: 2
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(isLast)
                    {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    }
                    else
                    {
                      pageViewController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios_rounded),
                )
              ],
            ),
          )
        ],
      )
    );
  }

  Widget pageViewListBuilder(int index) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      children:
      [
        Image.asset(
            photos[index],
          height: 400,
          width: 400,
        ),

        Text(
          titles[index],
          style: GoogleFonts.aBeeZee(
              fontSize: 20,
              fontWeight: FontWeight.w900
          ),
        ),
        SizedBox(height: 20,),
        Text(
          bodies[index],
          style: GoogleFonts.aBeeZee(
            fontSize: 12,
          ),
        ),
      ],
    ),
  );

}
