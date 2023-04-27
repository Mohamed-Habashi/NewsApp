import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Models/news_model.dart';
import 'package:newsapp/cubit/news_cubit.dart';
import 'package:newsapp/cubit/news_states.dart';
import 'package:newsapp/shared/components/components.dart';
import 'package:newsapp/web/web_view.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

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

Widget getData(NewsModel model,index,context){
  return InkWell(
    onTap: (){
      navigateTo(
          context: context,
          screen: WebViewScreen(model.articles![index].url!),
      );
    },
    child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children:  [
            Expanded(
              flex: 1,
              child: Image(
                image:model.articles![index].urlToImage==null?
                const NetworkImage('https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg'):
                NetworkImage('${model.articles![index].urlToImage}'),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width*0.35,
                height: MediaQuery.of(context).size.height*0.15,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.articles![index].title}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:  TextStyle(
                        fontSize: 16,
                        color: NewsCubit.get(context).isDark?Colors.black:Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      model.articles![index].author==null? '${model.articles![index].publishedAt}': '${model.articles![index].author}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
