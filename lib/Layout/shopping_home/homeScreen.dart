import 'package:Aqua/Layout/shopping_home/search_screen.dart';
import 'package:Aqua/models/categories_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import '../../Bloc/Cubit.dart';
import '../../Bloc/States.dart';
import '../../cache/shared_preferences.dart';
import '../../fixed_materials/fixed.dart';

class HomeScreen extends StatefulWidget
{

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  @override
  Widget build(BuildContext context)
  {

    name = CacheHelper.getData(key: 'name')??'';

    return BlocConsumer<ShoppingCubit, ShoppingStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var cubit = ShoppingCubit.get(context);

        return
          cubit.homeModel != null && cubit.categoriesModel != null
            ?
          Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        AppBar(
                          automaticallyImplyLeading: false,
                          titleSpacing: 20,
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            textBaseline: TextBaseline.ideographic,
                            children: [
                              Text(
                                'Aqua',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                child: Text(
                                    'EG',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsetsDirectional.all(10),
                          child: Column(
                            children: [
                              Text(
                                'Hello There, ${capFirstLetter(name)}!',
                                style: GoogleFonts.actor(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Here's our latest deals.",
                                style: GoogleFonts.actor(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),

                        CarouselSlider(
                            items: cubit.homeModel?.data?.banners
                                .map((e) => Container(
                                      margin: EdgeInsetsDirectional.all(10),
                                      child: Image(
                                        image: NetworkImage('${e.image}'),
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ))
                                .toList(),
                            options: CarouselOptions(
                              height: 250.0,
                              viewportFraction: 1.0,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(milliseconds: 4000),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 1000),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              scrollDirection: Axis.horizontal,
                            )),

                        Container(
                          margin: EdgeInsetsDirectional.all(10),
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            'Categories',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        Container(
                          height: 120,
                          child: ListView.builder(
                              itemBuilder: (context, index) => categoriesBuilder(cubit.categoriesModel!.data!.data[index] , index),
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.categoriesModel!.data!.data.length,
                            shrinkWrap: true,
                          ),
                        ),

                        Container(
                          margin: EdgeInsetsDirectional.all(10),
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            'Last Products',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsetsDirectional.all(10),
                          child: GridView.count(
                            childAspectRatio: 1 / 1.98,
                            mainAxisSpacing: 20.0,
                            crossAxisSpacing: 20.0,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            children: List.generate(
                                cubit.homeModel!.data!.products.length,
                                (index) => Column(
                                  children: [
                                    Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.white
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              cubit.homeModel!.data!.products[index].discount != 0 ?
                                              Container(
                                                  padding: EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(10),
                                                        bottomRight: Radius.circular(10)
                                                    ),
                                                    color: Colors.orange.withOpacity(0.5),
                                                  ),
                                                  margin: EdgeInsetsDirectional.only(
                                                    top: 15
                                                  ),
                                                  child: Text(
                                                    'Special Offer',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10
                                                    ),
                                                  )
                                              )
                                                  :
                                              Container(
                                                margin: EdgeInsetsDirectional.only(
                                                  top: 15
                                                ),
                                                  color: Colors.amber.withOpacity(0.5),
                                                  child: Text('')
                                              ),

                                              Container(
                                                padding: EdgeInsetsDirectional.all(20),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children:
                                                  [
                                                    Image(
                                                      image: NetworkImage(cubit.homeModel!.data!.products[index].image!),
                                                      width: 100,
                                                      height: 100,
                                                      ),

                                                    SizedBox(height: 5,),

                                                    Text(
                                                      cubit.homeModel!.data!.products[index].name!,
                                                      overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.center,
                                                      maxLines: 2,
                                                      style:
                                                          GoogleFonts.poppins(height: 1.2),
                                                    ),

                                                    SizedBox(height: 5,),

                                                    Column(
                                                      children: [
                                                        Text(
                                                          '${cubit.homeModel!.data!.products[index].price.toInt().round()}',
                                                          style: GoogleFonts.lato(
                                                            color: Colors.pink,
                                                            fontSize: 25,
                                                            fontWeight: FontWeight.w700
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        cubit.homeModel!.data!.products[index].discount != 0
                                                            ?
                                                        Text(
                                                                '${cubit.homeModel!.data!.products[index].old_price.toInt().round().toString()}',
                                                                style: TextStyle(
                                                                    color: Colors.grey,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough),
                                                              )
                                                            :
                                                        Text(''),

                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children:
                                                          [
                                                            IconButton(
                                                                onPressed: ()
                                                                {
                                                                  cubit.changeFavourite(cubit.homeModel!.data!.products[index].id!);
                                                                },
                                                                icon: cubit.favourites[cubit.homeModel!.data!.products[index].id]! ? Icon(Icons.favorite_rounded, color: Colors.pink,) : Icon(Icons.favorite_outline_rounded)
                                                            ),
                                                            IconButton(
                                                                onPressed: (){},
                                                                icon: Icon(LineIcons.addToShoppingCart)
                                                            )
                                                          ],
                                                        )
                                                      ],

                                                    ),


                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  ],
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            :
          Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget categoriesBuilder(DataModel model, int index) =>
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          color: Colors.amber.withOpacity(0.1),
        ),
        margin: EdgeInsetsDirectional.all(10),
        padding: EdgeInsetsDirectional.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:
          [
            Icon(
              categoriesIcons[index],
              size: 30,
              color: Colors.black.withOpacity(0.8),
            ),
            SizedBox(height: 10,),
            Text(
              '${model.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            )
          ],
        ),
      );

  List<IconData?> categoriesIcons =
  [
    Icons.sports_esports_outlined,
    Icons.masks_outlined,
    Icons.sports_tennis_rounded,
    Icons.light_rounded,
    Icons.checkroom_rounded,
  ];
}
