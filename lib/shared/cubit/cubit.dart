import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_latest_news/modules/business/business_screen.dart';
import 'package:flutter_latest_news/modules/science/science_screen.dart';
import 'package:flutter_latest_news/modules/settings/settings_screen.dart';
import 'package:flutter_latest_news/modules/sports/sports_screen.dart';
import 'package:flutter_latest_news/modules/top_headlines/top_headlines_screen.dart';
import 'package:flutter_latest_news/shared/cubit/states.dart';
import 'package:flutter_latest_news/shared/network/local/cahe_helper.dart';
import 'package:flutter_latest_news/shared/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context)=> BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens =
  [
    TopHeadlinesScreen(),
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  //  SettingsScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems =
      [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.view_list,
          ),
          label: 'Top Headlines',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.business,
          ),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.sports_soccer,
          ),
          label: 'Sports',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.science,
          ),
          label: 'Science',
        ),
      ];
  void changeBottomNavItem(int index){
    currentIndex = index;

    if(index == 1)
      getBusiness();
      else if(index == 2)
        getSports();
    else if(index == 3)
      getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> topHeadlines = [];

  void getTopHeadlines(){
    emit(NewsGetTopHeadlinesLoadingState());
    if(topHeadlines.length==0){
    DioHelper.getData(
        path: 'v2/top-headlines'
        , query:
    {
          'country' : 'eg',
           'apiKey' : 'b58872cb9673426582535ea5d7c9f17f'

    },
    ).then((value) {
      topHeadlines = value.data['articles'];

      //print(topHeadlines[0]['title']);
      emit(NewsGetTopHeadlinesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetTopHeadlinesErrorState(error.toString()));
    });}
    else{
      emit(NewsGetTopHeadlinesSuccessState());
    }
  }

  List<dynamic> business = [];

  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    if(business.length==0){
    DioHelper.getData(
      path: 'v2/top-headlines'
      , query:
    {
      'country' : 'eg',
      'category' : 'business',
      'apiKey' : 'b58872cb9673426582535ea5d7c9f17f'
    },
    ).then((value) {
      business = value.data['articles'];

      //print(topHeadlines[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });}
    else{
      emit(NewsGetBusinessSuccessState());
    }
  }

  List<dynamic> sports = [];

  void getSports(){
    emit(NewsGetSportsLoadingState());
    if(sports.length==0){
    DioHelper.getData(
      path: 'v2/top-headlines'
      , query:
    {
      'country' : 'eg',
      'category' : 'sports',
      'apiKey' : 'b58872cb9673426582535ea5d7c9f17f'
    },
    ).then((value) {
      sports = value.data['articles'];

      //print(topHeadlines[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });}
    else{
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience(){
    emit(NewsGetScienceLoadingState());
    if(science.length==0){
    DioHelper.getData(
      path: 'v2/top-headlines'
      , query:
    {
      'country' : 'eg',
      'category' : 'science',
      'apiKey' : 'b58872cb9673426582535ea5d7c9f17f'
    },
    ).then((value) {
      science = value.data['articles'];

      //print(topHeadlines[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });}
    else{
    emit(NewsGetScienceSuccessState());

    }
  }

  List<dynamic> search = [];

  void getSearch({
  @required String value
}){
    emit(NewsGetSearchLoadingState());
    if(search.length==0){
      DioHelper.getData(
        path: 'v2/everything'
        , query:
      {
        'q' : '$value',
        'sortBy' : 'publishedAt',
        'apiKey' : 'b58872cb9673426582535ea5d7c9f17f'
      },
      ).then((value) {
        search = value.data['articles'];

        //print(topHeadlines[0]['title']);
        emit(NewsGetSearchSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });}
    else{
      emit(NewsGetSearchSuccessState());

    }
  }

}

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context)=> BlocProvider.of(context);

  bool isDark = false;
  void changeMode({bool isDark}){
    if(isDark!=null){
      this.isDark = isDark;
      print('chng mod is null? ');
      emit(AppChangeModeState());
    }
    else {
      this.isDark = !this.isDark;
      CacheHelper.putBool(key: 'isDark', value: this.isDark).then((value) {
        print('chng then? ${this.isDark}');

        emit(AppChangeModeState());
      });
    }

  }
}
