
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_latest_news/shared/components/components.dart';
import 'package:flutter_latest_news/shared/cubit/cubit.dart';
import 'package:flutter_latest_news/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {

  TextEditingController searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context, state) {  },
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: searchController,
                      validator:(String value) {
                        if(value.isEmpty){
                          return 'Required Field';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if(formKey.currentState.validate())
                        NewsCubit.get(context).getSearch(value: value);
                      },

                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                        color: Colors.grey,),
                        labelText: 'Search',
                        labelStyle: TextStyle(
                          color: Colors.grey
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                           // width: 2.0
                          )
                        ),

                      ),
                    ),
                  ),
                ),
                Expanded(child: articlesBuider(list, context, isSearch: true)),
              ],
            ),
          ),
        );
      },

    );
  }
}
