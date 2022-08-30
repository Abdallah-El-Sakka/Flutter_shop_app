import 'package:Aqua/Bloc/Cubit.dart';
import 'package:Aqua/Bloc/States.dart';
import 'package:Aqua/fixed_materials/fixed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class ProfileScreen extends StatefulWidget
{

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
{

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShoppingCubit, ShoppingStates>(
      listener: (context, state) {},
      builder: (context, state)
      {

        var cubit = ShoppingCubit.get(context);

        return Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children:
              [

                AppBar(
                  automaticallyImplyLeading: false,
                  titleSpacing: 20,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    textBaseline: TextBaseline.ideographic,
                    children: [
                      Text(
                        'Profile',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsetsDirectional.only(
                      top: 10,
                      end: 20,
                      start: 20,
                      bottom: 10
                  ),
                  padding: EdgeInsetsDirectional.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),

                  child: Row(
                    children:
                    [
                      Icon(
                          Icons.person_outline_rounded,
                          color: Colors.black.withOpacity(0.8)
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Text(
                          capFirstLetter(cubit.userModel!.data!.name.toString()),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 20
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsetsDirectional.only(
                      top: 10,
                      end: 20,
                      start: 20,
                      bottom: 10
                  ),
                  padding: EdgeInsetsDirectional.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),

                  child: Row(
                    children:
                    [
                      Icon(
                          Icons.alternate_email_rounded,
                          color: Colors.black.withOpacity(0.8)
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Text(
                          cubit.userModel!.data!.email.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 15
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsetsDirectional.only(
                      top: 10,
                      end: 20,
                      start: 20,
                      bottom: 10
                  ),
                  padding: EdgeInsetsDirectional.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),

                  child: Row(
                    children:
                    [
                      Icon(
                          Icons.phone_outlined,
                          color: Colors.black.withOpacity(0.8)
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Text(
                          cubit.userModel!.data!.phone.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 15
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsetsDirectional.only(
                      top: 10,
                      end: 20,
                      start: 20,
                      bottom: 10
                  ),
                  padding: EdgeInsetsDirectional.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),

                  child: Row(
                    children:
                    [
                      Icon(Icons.monetization_on_outlined),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Text(
                          cubit.userModel!.data!.credit.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 15
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Spacer(),

                Container(
                  margin: EdgeInsetsDirectional.all(20),
                  child: TextButton(
                    onPressed: ()
                    {
                      signOutUser(context);
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsDirectional>(
                        EdgeInsetsDirectional.all(10)
                      ),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade100),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    color: Colors.pink
                                )
                            )
                        )
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                      [
                        Text('Logout'),
                        SizedBox(width: 5,),
                        Icon(LineIcons.alternateSignOut)
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
        );
      },
    );
  }

}
