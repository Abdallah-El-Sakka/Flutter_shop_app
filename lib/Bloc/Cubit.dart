import 'package:Aqua/models/favorites_model.dart';
import 'package:Aqua/models/search_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Dio/DioHelper.dart';
import '../models/categories_model.dart';
import '../Dio/end_points.dart';
import '../models/get_favourites_model.dart';
import '../models/home_model.dart';
import '../models/shopping_model.dart';
import '../fixed_materials/fixed.dart';
import 'States.dart';

class ShoppingCubit extends Cubit<ShoppingStates>
{
  ShoppingCubit() : super(InitialState());

  static ShoppingCubit get(context) => BlocProvider.of(context);

  ShoppingModel? loginModel;

  ShoppingModel? registerModel;

  void changeVisibility()
  {
    emit(ChangePassVisibility());
  }

  void userLogin({
    required String email,
    required String password,
  })
  {

    emit(LoginLoadingState());

    DioHelper.postData(
        url: LOGIN,
        data:
        {
          'email' : email,
          'password' : password
        }


    ).then((value)
    {
      loginModel = ShoppingModel.fromJson(value.data);
      print(value.data);

      emit(LoginSuccessState(loginModel!));

    }).catchError((onError)
    {
      print(onError.toString());
      emit(LoginFailedState(loginModel!));
    });
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone
  })
  {
    emit(RegisterLoadingState());

    DioHelper.postData(
        url: REGISTER,
        data:
        {
          'name' : name,
          'email' : email,
          'password' : password,
          'phone' : phone,
        }
    ).then((value)
    {
      registerModel = ShoppingModel.fromJson(value.data);

      emit(RegisterSuccessState(registerModel!));

    }).catchError((onError)
    {
      emit(RegisterFailedState(registerModel!));
    });

  }

  HomeModel? homeModel;

  Map<int? , bool?> favourites = {};

  void getHomeData()
  {
    emit(HomeLoadingDataState());

    DioHelper.getData(
      token: token,
      url: HOME
    )
        .then((value)
    {
      
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products.forEach((element)
      {
        favourites.addAll({
          element.id : element.in_favourites
        });
      });

      emit(HomeSuccessDataState());
      
    })
        .catchError((onError)
    {
      
      print('error : ' + onError.toString());

      emit(HomeErrorDataState());
      
    });

  }

  CategoriesModel? categoriesModel;

  void getCategoriesData()
  {

    DioHelper.getData(
        url: CATEGORIES
    )
        .then((value)
    {

      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(CategoriesSuccessDataState());

    })
        .catchError((onError)
    {

      print('error : ' + onError.toString());

      emit(CategoriesErrorDataState());

    });

  }

  ChangeFavourite? changeFavouriteModel;

  void changeFavourite(int id)
  {

    favourites[id] = !favourites[id]!;

    emit(ChangeFavouriteSuccess());

    DioHelper.postData(
        url: FAVOURITES,
        token: token,
        data:
        {
          'product_id' : id,
        },
    )
        .then((value)
    {

      changeFavouriteModel = ChangeFavourite.fromJson(value.data);

      if(!changeFavouriteModel!.status!)
      {
        favourites[id] = !favourites[id]!;
      }
      else
      {
        getFavouritesData();
      }

      showToast(msg: changeFavouriteModel!.message!, state: ToastStates.success);

      //print(value.data);

      emit(ChangeFavouriteSuccess());
    })
        .catchError(
            (onError)
        {

          favourites[id] = !favourites[id]!;

          emit(ChangeFavouriteError());
        });
  }

  FavouritesModel? favouritesModel;

  void getFavouritesData()
  {

    emit(FavouritesLoadingDataState());

    DioHelper.getData(
        url: FAVOURITES,
        token: token,
    )
        .then((value)
    {

      favouritesModel = FavouritesModel.fromJson(value.data);

      //print(value.data);

      emit(FavouritesSuccessDataState());

    })
        .catchError((onError)
    {

      print('error : ' + onError.toString());

      emit(FavouritesErrorDataState());

    });

  }

  ShoppingModel? userModel;

  void getUserData()
  {

    emit(ProfileLoadingDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    )
        .then((value)
    {

      userModel = ShoppingModel.fromJson(value.data);

      print(userModel?.data?.name);

      emit(ProfileSuccessDataState());

    })
        .catchError((onError)
    {

      print('error : ' + onError.toString());

      emit(ProfileErrorDataState());

    });

  }

  void updateUserData({
    required name,
    required email,
    required phone
  })
  {
    emit(UpdateUserDataLoadingDataState());
    
    DioHelper.putData(
        url: UPDATE_PROFILE,
        data:
        {
          'name'  : name,
          'email' : email,
          'phone' : phone
        }
    ).then(
            (value)
        {
          userModel = ShoppingModel.fromJson(value.data);

          emit(UpdateUserDataSuccessDataState());
        });
  }

}

///////////////////////////////////////////////////////////////////////


class SearchCubit extends Cubit<SearchState>
{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search({required String text})
  {

    emit(SearchLoadingState());

    DioHelper.postData(
        url: SEARCH,
        token: token,
        data:
        {
          'text' : text
        }
    ).then(
            (value)
        {

          model = SearchModel.fromJson(value.data);

          //print(value.data);

          emit(SearchSuccessState());
        })
        .catchError(
            (onError)
        {
          print('error : ' + onError.toString());

          emit(SearchErrorState());
        });
  }

}