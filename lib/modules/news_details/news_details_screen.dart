
import 'package:flutter/material.dart';
import 'package:flutter_latest_news/modules/web_view/web_view_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsScreen extends StatelessWidget {
  final  article;
  NewsDetailsScreen(this.article);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${article['title']}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 8.0,),
              Image(
          image : article['urlToImage'] == null ? AssetImage('assets/images/no_news.jpg'): NetworkImage(
    '${article['urlToImage']}',
          ),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
              ),
              SizedBox(height: 16.0,),
              Text(
                '${article['description']==null ? '' :article['description']}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 16.0,),
              Text(
                '${article['publishedAt']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 32.0,),
                Container(
                  width: double.infinity,
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => WebViewScreen(article['url']),
                          ),
                      );

                    },
                    child: Text('Read from original source'),),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
