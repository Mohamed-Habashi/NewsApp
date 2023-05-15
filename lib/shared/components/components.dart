
import 'package:flutter/material.dart';

import '../../web/web_view.dart';

Widget defaultButton({
  double width=double.infinity,
  double height=40,
  double radius=20,
   Color backColor=Colors.blue,
   Color textColor=Colors.white,
  required String label,
  required void Function()? function,
}){
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(backColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
      onPressed: function,
      child:  Text(
        label.toUpperCase(),
        style: TextStyle(
            color: textColor,
        ),
      ),
    ),
  );
}
Future navigateTo({
  required BuildContext context,
  required Widget screen
})=>Navigator.push(context, MaterialPageRoute(
  builder: (context)=>screen,
));

Future navigateToFinish({
  required BuildContext context,
  required Widget screen,
})=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
  builder: (context)=>screen
), (route) => false);

Widget defaultFormField({
  required var controller,
  required bool obscure,
  required var keyboardType,
  required String label,
   String? Function(String?)? validator,
   String? Function(String?)? onChange,
  void Function()? onTap,
  Icon ? prefixIcon,
  var  suffixIcon,
  double radius=10,
  bool isClickable=true,
  void Function(String)? onSubmit,
  context,
}){
  return TextFormField(
    decoration:  InputDecoration(
      labelText: label,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
    controller: controller,
    onFieldSubmitted: onSubmit,
    keyboardType: keyboardType,
    enabled: isClickable,
    obscureText: obscure,
    onChanged: onChange,
    validator: validator,
    onTap: onTap,
  );
}

Widget buildArticleItem(article,context)=>InkWell(
  onTap: (){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context){
              return WebViewScreen('${article['url']}');
            }
        ),
    );
  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image:  DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: SizedBox(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                Expanded(
                  child: Text (
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);
  