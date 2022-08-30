import 'package:Aqua/Bloc/Cubit.dart';
import 'package:Aqua/Bloc/States.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class FavouritesScreen extends StatelessWidget
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
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
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
                              'Favourites',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        itemBuilder: (context, index) => favouriteListBuilder(index, context),
                        itemCount: cubit.favouritesModel?.data!.data!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      )
                    ],
                  ),
                ),
              )
          );
        }
    );
  }

  Widget favouriteListBuilder(int index, context)
  {

    var model = ShoppingCubit.get(context).favouritesModel?.data?.data?[index].product;

    return Container(
      height: 150,
      width: double.infinity,
      padding: EdgeInsetsDirectional.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      margin: EdgeInsetsDirectional.only(
          top: 10,
          bottom: 10,
          start: 20,
          end: 20
      ),
      child: Row(
        children:
        [
          Image(
            image: NetworkImage(model!.image),
            height: 120,
            width: 120,
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    model.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.6)
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  children:
                  [
                    Text(
                      model.price.toInt().toString(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.pink
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: ()
                        {
                          ShoppingCubit.get(context).changeFavourite(model.id);
                        },
                        icon:
                        ShoppingCubit.get(context).favourites[model.id]!
                            ?
                        Icon(Icons.favorite_rounded, color: Colors.pink,)
                            :
                        Icon(Icons.favorite_outline_rounded)
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}
