
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_latest_news/modules/news_details/news_details_screen.dart';

Widget buildArticleItem({
  @required Map<String , dynamic> article,
  @required BuildContext context
})=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>NewsDetailsScreen(article),));
    },
    child: Row(
      children: [
        Container(
          height: 120.0,
          width: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: article['urlToImage'] == null ? AssetImage('assets/images/no_news.jpg'): NetworkImage(
                '${article['urlToImage']}',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 20.0,),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
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

Widget articlesBuider(list , context , {bool isSearch = false})=>  ConditionalBuilder(
  condition: list.length > 0 ,
  builder:(context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context,index) => buildArticleItem(
          article :list[index],context: context),
      separatorBuilder: (context,index) => Padding(
        padding: const EdgeInsetsDirectional.only(start: 20.0),
        child: Container(
          width: double.infinity,
          height: 1.0,
          color: Colors.grey[400],
        ),
      ),
      itemCount: list.length),
  fallback: (context) => isSearch ? Container():Center(child: CircularProgressIndicator()),
);