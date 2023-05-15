import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/news_cubit.dart';
import 'package:newsapp/cubit/news_states.dart';
import 'package:newsapp/shared/components/components.dart';

import 'news_screen.dart';

var searchController=TextEditingController();

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                NewsCubit.get(context).currentIndex=0;
                NewsCubit.get(context).newsModel=null;
                searchController.clear();
                NewsCubit.get(context).getPoliticsData();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            backgroundColor: Colors.deepPurpleAccent,
            centerTitle: false,
            title: const Text(
                'Search Screen'
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultFormField(
                    controller: searchController,
                    borderColor: NewsCubit.get(context).isDark?Colors.black:Colors.white,
                    textStyle: TextStyle(
                      color: NewsCubit.get(context).isDark?Colors.black:Colors.white,
                    ),
                    obscure: false,
                    keyboardType: TextInputType.text,
                    label: 'Search here',
                  hintStyle: TextStyle(
                    color: NewsCubit.get(context).isDark?Colors.black:Colors.white,
                  ),
                  onChange: (value){
                      value=searchController.text;
                      NewsCubit.get(context).searchData(search: value);
                  }
                ),
                const SizedBox(
                  height: 20,
                ),
               searchController.text.isNotEmpty? ConditionalBuilder(
                  condition: state is! SearchDataLoadingState,
                  builder: (context)=>Expanded(
                    child: ListView.separated(
                        itemBuilder: (context,index)=>getData(NewsCubit.get(context).newsModel!,index, context),
                        separatorBuilder: (context,index)=>Container(
                          color: Colors.grey,
                          width: double.infinity,
                          height: 1,
                        ),
                        itemCount: NewsCubit.get(context).newsModel!.articles!.length
                    ),
                  ),
                  fallback: (context)=>const Center(child: CircularProgressIndicator(
                    color: Colors.deepPurpleAccent,
                  ),),
                ):Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
