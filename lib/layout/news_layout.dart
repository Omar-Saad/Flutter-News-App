import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_latest_news/modules/search/search_screen.dart';
import 'package:flutter_latest_news/shared/cubit/cubit.dart';
import 'package:flutter_latest_news/shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (BuildContext context, state) {},
     builder: (context, state) {
       var cubit = NewsCubit.get(context);
       return  Scaffold(
         appBar: AppBar(
           title: Text('Latest News'),
           actions: [
             IconButton(
               icon: Icon(Icons.search,),
               onPressed: () {
                 Navigator.push(context, MaterialPageRoute(
                   builder: (context) => SearchScreen(),
                 ));
               },
             ),
             IconButton(
               icon: Icon(Icons.brightness_4_outlined,),
               onPressed: () {
                  AppCubit.get(context).changeMode();
               },
             ),
           ],
         ),
         body: cubit.screens[cubit.currentIndex],
         bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
           items: cubit.bottomItems,
           onTap: (index){
              cubit.changeBottomNavItem(index);
           },
         ),

       );
     },
    );
  }
}
