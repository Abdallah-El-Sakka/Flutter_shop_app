import 'package:Aqua/models/home_model.dart';

import '../models/shopping_model.dart';

class ShoppingStates
{}

class InitialState extends ShoppingStates
{}

class ChangePassVisibility extends ShoppingStates
{}



class LoginLoadingState extends ShoppingStates
{}

class LoginSuccessState extends ShoppingStates
{
  final ShoppingModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginFailedState extends ShoppingStates
{
  final ShoppingModel loginModel;

  LoginFailedState(this.loginModel);
}



class RegisterLoadingState extends ShoppingStates
{}

class RegisterSuccessState extends ShoppingStates
{
  final ShoppingModel registerModel;

  RegisterSuccessState(this.registerModel);
}

class RegisterFailedState extends ShoppingStates
{
  final ShoppingModel registerModel;

  RegisterFailedState(this.registerModel);
}


class HomeLoadingDataState extends ShoppingStates
{}

class HomeSuccessDataState extends ShoppingStates
{}

class HomeErrorDataState extends ShoppingStates
{}

class CategoriesSuccessDataState extends ShoppingStates
{}

class CategoriesErrorDataState extends ShoppingStates
{}

class ChangeFavouriteSuccess extends ShoppingStates
{}

class ChangeFavouriteError extends ShoppingStates
{}

class FavouritesSuccessDataState extends ShoppingStates
{}

class FavouritesErrorDataState extends ShoppingStates
{}

class FavouritesLoadingDataState extends ShoppingStates
{}

class ProfileLoadingDataState extends ShoppingStates
{}

class ProfileSuccessDataState extends ShoppingStates
{}

class ProfileErrorDataState extends ShoppingStates
{}


class UpdateUserDataLoadingDataState extends ShoppingStates
{}

class UpdateUserDataSuccessDataState extends ShoppingStates
{}

class UpdateUserDataErrorDataState extends ShoppingStates
{}

////////////////////////////////////////////////////////////

class SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {}

class SearchErrorState   extends SearchState {}

class SearchInitialState extends SearchState {}