import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Models/news_model.dart';
import 'package:newsapp/cubit/news_states.dart';
import 'package:newsapp/screens/business_screen.dart';
import 'package:newsapp/screens/news_screen.dart';
import 'package:newsapp/screens/sports_screen.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{

  NewsCubit():super(NewsInitialState());

  static NewsCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;

  List<Widget>screens=[
    const NewsScreen(),
    const BusinessScreen(),
    const SportsScreen(),
  ];

  bottomNavigation(index){
    currentIndex=index;
    if(index==1){
      newsModel=null;
      getBusinessData();
    }else if(index==2){
      newsModel=null;
      getSportsData();
    }else if(index==0){
      newsModel=null;
      getPoliticsData();
    }
    emit(BottomNavigationBarState());
  }
  
  NewsModel? newsModel;

  getPoliticsData(){
    emit(GetScienceDataLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
      query: {
          'country':'us',
        'category':'science',
        'apiKey':'2c51b6b52a6f492d9ece64d398f42a78',
      }
    ).then((value){
      newsModel=NewsModel.fromJson(value.data);
      emit(GetScienceDataSuccessState());
    }).catchError((error){
      emit(GetScienceDataErrorState());
    });
  }

  getBusinessData(){
    emit(GetBusinessDataLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
      query: {
          'country':'us',
        'category':'business',
        'apiKey':'2c51b6b52a6f492d9ece64d398f42a78',
      }
    ).then((value){
      newsModel=NewsModel.fromJson(value.data);
      emit(GetBusinessDataSuccessState());
    }).catchError((error){
      emit(GetSportsDataErrorState());
    });
  }

  getSportsData(){
    emit(GetSportsDataLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
      query: {
          'country':'us',
        'category':'sports',
        'apiKey':'2c51b6b52a6f492d9ece64d398f42a78',
      }
    ).then((value){
      newsModel=NewsModel.fromJson(value.data);
      emit(GetSportsDataSuccessState());
    }).catchError((error){
      emit(GetSportsDataErrorState());
    });
  }

  bool isDark=false;

  changeThemeMode({bool ?fromShared}){
    if(fromShared!=null){
      isDark=fromShared;
      emit(ChangeThemeModeSuccessState());
    }else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value){
        emit(ChangeThemeModeSuccessState());
      });
    }
  }
}