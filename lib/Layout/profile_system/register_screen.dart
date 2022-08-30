import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Bloc/Cubit.dart';
import '../../Bloc/States.dart';
import '../../cache/shared_preferences.dart';
import '../../fixed_materials/fixed.dart';
import '../shopping_home/Nav_home.dart';

class RegisterScreen extends StatelessWidget
{

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

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
              if(state is RegisterSuccessState)
              {
                if(state.registerModel.status)
                {
                  showToast(
                      msg: state.registerModel.message.toString(),
                      state: ToastStates.success
                  );

                  CacheHelper.saveData(key: 'token', value: state.registerModel.data?.token).then((value)
                  {

                    CacheHelper.saveData(key: 'name', value: state.registerModel.data?.name).then((value)
                    {

                      token = state.registerModel.data!.token.toString();
                      name  = state.registerModel.data!.name.toString();

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
                      msg: state.registerModel.message.toString(),
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
                                'Register',
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
                                'Register now to get our new special offers !',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                ),
                              ),
                            ),

                            SizedBox(height: 20,),

                            Container(
                              margin: EdgeInsetsDirectional.only(
                                  top: 10,
                                  bottom: 10,
                                  start: 30,
                                  end: 30
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.name,
                                validator:
                                    (value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return 'Name is empty.';
                                  }
                                },
                                controller: nameController,
                                decoration: InputDecoration(
                                    label: Text('Name'),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    prefixIcon: Icon(Icons.person_outline_rounded)
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
                                    cubit.userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text
                                    );
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
                            Container(
                              margin: EdgeInsetsDirectional.only(
                                  top: 10,
                                  bottom: 10,
                                  start: 30,
                                  end: 30
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                validator:
                                    (value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return 'Phone is empty.';
                                  }
                                },
                                controller: phoneController,
                                decoration: InputDecoration(
                                    label: Text('Phone'),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    prefixIcon: Icon(Icons.call_outlined)
                                ),
                              ),
                            ),

                            SizedBox(height: 20,),

                            state is RegisterLoadingState
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
                                    cubit.userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text
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
                                    'register now'.toUpperCase(),
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
                                "Already have an account ?",
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
                                  Navigator.pop(context);
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
