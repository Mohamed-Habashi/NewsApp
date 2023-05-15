import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/news_cubit.dart';
import 'package:newsapp/cubit/news_states.dart';
import 'package:newsapp/screens/search_screen.dart';
import 'package:newsapp/shared/components/components.dart';


class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            centerTitle: false,
            title: const Text(
                'News App'
            ),
            actions: [
              IconButton(
                onPressed: (){
                  NewsCubit.get(context).newsModel=null;
                 navigateTo(context: context, screen: const SearchScreen());
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
              IconButton(
                onPressed: (){
                  NewsCubit.get(context).changeThemeMode();
                },
                icon:cubit.isDark? const Icon(
                  Icons.dark_mode_outlined,
                ):const Icon(
                  Icons.brightness_4,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.deepPurpleAccent,
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.bottomNavigation(index);
            },
            items: const [
              BottomNavigationBarItem(
                  label: 'Main',
                  icon: Icon(
                    Icons.home,
                  )
              ),
              BottomNavigationBarItem(
                  label: 'Business',
                  icon: Icon(
                    Icons.business_sharp,
                  )
              ),
              BottomNavigationBarItem(
                  label: 'Sports',
                  icon: Icon(
                    Icons.sports_baseball,
                  )
              ),
            ],
          ),
        );
      },
    );
  }
}
