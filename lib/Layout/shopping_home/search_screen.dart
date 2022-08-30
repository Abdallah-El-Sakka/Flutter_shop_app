import 'package:Aqua/Bloc/Cubit.dart';
import 'package:Aqua/Bloc/States.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class SearchScreen extends StatelessWidget
{


  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, builder)
        {

          var cubit = SearchCubit.get(context);

          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                  [

                    AppBar(),

                    Container(
                      margin: EdgeInsetsDirectional.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.05),
                      ),
                      child: TextFormField(
                        onChanged: (value)
                        {
                          cubit.search(text: value);
                        },
                        autocorrect: true,
                        controller: searchController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(LineIcons.search),
                          suffixIcon: IconButton(
                              onPressed: ()
                              {
                                searchController.clear();
                              },
                              icon: Icon(Icons.cancel_outlined)
                          ),
                          fillColor: Colors.grey,
                          label: Text('What are you looking for ?'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                      ),
                    ),

                    cubit.model == null || searchController.text.isEmpty
                        ?
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                      [
                        Icon(
                            LineIcons.search,
                          size: 40,
                        ),
                        Text('Enter text to search.')
                      ],
                    )
                        :
                    ListView.builder(
                      itemBuilder: (context, index) => searchListBuilder(cubit, index),
                      itemCount: cubit.model?.data?.data?.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    )

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget searchListBuilder(cubit, index) => Container(
    height: 120,
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
      mainAxisAlignment: MainAxisAlignment.start,
      children:
      [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          width: 120,
          height: 120,
          child: Image(
              image: NetworkImage(cubit.model!.data!.data![index].image.toString()),
            height: 120,
            width: 120,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cubit.model!.data!.data![index].name.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Text(
                  cubit.model!.data!.data![index].price.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 15
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

}
