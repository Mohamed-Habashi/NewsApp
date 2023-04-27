import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/news_cubit.dart';
import '../cubit/news_states.dart';
import 'news_screen.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: NewsCubit.get(context).newsModel!=null,
          builder: (context)=>ListView.separated(
              itemBuilder: (context,index)=>getData(NewsCubit.get(context).newsModel!,index, context),
              separatorBuilder: (context,index)=>Container(
                color: Colors.grey,
                width: double.infinity,
                height: 1,
              ),
              itemCount: NewsCubit.get(context).newsModel!.articles!.length
          ),
          fallback: (context)=>const Center(child: CircularProgressIndicator(
            color: Colors.deepPurpleAccent,
          ),),
        );
      },
    );
  }
}
