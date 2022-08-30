import 'package:Aqua/Layout/profile_system/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Bloc/Cubit.dart';
import '../../Bloc/States.dart';
import '../../cache/shared_preferences.dart';
import '../../fixed_materials/fixed.dart';
import '../shopping_home/Nav_home.dart';

class LoginScreen extends StatelessWidget
{
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassVisible = false;

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (context) => ShoppingCubit(),
      child: BlocConsumer<ShoppingCubit , ShoppingStates>(
        listener: (context , state)
        {
          if(state is LoginSuccessState)
          {
            if(state.loginModel.status)
            {
              showToast(
                  msg: state.loginModel.message.toString(),
                  state: ToastStates.success
              );

              CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value)
              {

                CacheHelper.saveData(key: 'name', value: state.loginModel.data?.name).then((value)
                {

                  token = state.loginModel.data!.token.toString();
                  name  = state.loginModel.data!.name.toString();

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavHomeScreen()
                      )
                  );
                });


              });

            }
            else
            {
              showToast(
                  msg: state.loginModel.message.toString(),
                  state: ToastStates.error
              );
            }
          }
        },
        builder: (context, state)
        {

          var cubit = ShoppingCubit.get(context);

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,

                      mainAxisSize: MainAxisSize.max,

                      children:
                      [

                        Container(
                          alignment: AlignmentDirectional.topStart,
                          margin: EdgeInsetsDirectional.only(
                              top: 20,
                              start: 30,
                              end: 30
                          ),
                          child: Text(
                            'Log In',
                            style: GoogleFonts.poppins(
                                fontSize: 35,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.topStart,
                          margin: EdgeInsetsDirectional.only(
                              bottom: 20,
                              start: 30,
                              end: 30
                          ),
                          child: Text(
                            'Sign in now to get our new special offers !',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                            ),
                          ),
                        ),

                        SizedBox(height: 40,),

                        Container(
                          margin: EdgeInsetsDirectional.only(
                              top: 10,
                              bottom: 10,
                              start: 30,
                              end: 30
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator:
                                (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Email is empty.';
                              }
                            },
                            controller: emailController,
                            decoration: InputDecoration(
                                label: Text('Email'),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                prefixIcon: Icon(Icons.alternate_email)
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(
                              top: 10,
                              bottom: 10,
                              start: 30,
                              end: 30
                          ),
                          child: TextFormField(
                            onFieldSubmitted: (value)
                            {
                              if(formKey.currentState!.validate())
                              {
                                cubit.userLogin(email: emailController.text, password: passwordController.text);
                              }
                            },
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !isPassVisible,
                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'password is empty';
                              }
                            },
                            controller: passwordController,
                            decoration: InputDecoration(
                                label: Text('Password'),
                                suffixIcon: IconButton(
                                  onPressed: ()
                                  {
                                    isPassVisible = !isPassVisible;
                                    cubit.changeVisibility();
                                  },
                                  icon: isPassVisible ?  Icon(Icons.visibility_off) : Icon(Icons.remove_red_eye),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                prefixIcon: Icon(Icons.lock_open_rounded)
                            ),
                          ),
                        ),

                        SizedBox(height: 20,),

                        state is LoginLoadingState
                            ?
                        Center(child: Container(margin: EdgeInsetsDirectional.only(
                            top: 27,
                            bottom: 20,
                            start: 30,
                            end: 30
                        ),child: CircularProgressIndicator()))
                            :
                        Container(
                          margin: EdgeInsetsDirectional.only(
                              top: 20,
                              bottom: 10,
                              start: 30,
                              end: 30
                          ),
                          child: TextButton(
                            onPressed: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                );
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsetsDirectional.only(
                                  start: 10,
                                  end: 10,
                                  bottom: 10,
                                  top: 10
                              ),
                              child: Text(
                                'log in'.toUpperCase(),
                                style: GoogleFonts.aBeeZee(
                                    color: Colors.white
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    )
                                )
                            ),
                          ),
                        ),

                        Container(
                          alignment: AlignmentDirectional.center,
                          margin: EdgeInsetsDirectional.only(
                              start: 30,
                              end: 30
                          ),
                          child: Text(
                            "Don't have an account ?",
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(
                              bottom: 10,
                              top: 10,
                              start: 30,
                              end: 30
                          ),
                          child: TextButton(
                            onPressed: ()
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsetsDirectional.only(
                                  start: 10,
                                  end: 10,
                                  bottom: 10,
                                  top: 10
                              ),
                              child: Text(
                                'register now'.toUpperCase(),
                                style: GoogleFonts.aBeeZee(
                                    color: Colors.pink
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: BorderSide(
                                            color: Colors.pink
                                        )
                                    )
                                )
                            ),
                          ),
                        ),

                        TextButton(
                            onPressed: (){},
                            child: Text(
                                'Forgot Password ?',
                              style: GoogleFonts.poppins(
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 12
                              ),
                            )
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      )
    );
  }
}
