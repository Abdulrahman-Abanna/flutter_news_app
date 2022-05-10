import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr3/layout/news_app/cubit/states.dart';
import 'package:pr3/modules/business/business_screan.dart';
import 'package:pr3/modules/science/science_screan.dart';
import 'package:pr3/modules/sports/sports_screan.dart';
import 'package:pr3/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  static NewsCubit get(context) => BlocProvider.of(context);
  NewsCubit() : super(NewsInitialState());
  int cutrrentindex = 0;
  List<Widget> screan = [
    BusinessScrean(),
    SportScrean(),
    ScienceScrean(),
  ];

  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: "Science",
    ),
  ];

  void ChangeBottomNavBar(int index) {
    cutrrentindex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'business',
      'apiKey': 'fbcfd55584914a44b9c76d9bddc93377'
    }).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);

      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print('Error Dio: ${error.toString()}');

      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'science',
      'apiKey': 'fbcfd55584914a44b9c76d9bddc93377'
    }).then((value) {
      science = value.data['articles'];
      print(science[0]['title']);

      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print('Error Dio: ${error.toString()}');

      emit(NewsGetScienceErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'sports',
      'apiKey': 'fbcfd55584914a44b9c76d9bddc93377'
    }).then((value) {
      sports = value.data['articles'];
      print(sports[0]['title']);

      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print('Error Dio: ${error.toString()}');

      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    search = [];
    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': 'fbcfd55584914a44b9c76d9bddc93377'
    }).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print('Error Dio: ${error.toString()}');

      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
