import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_latest_news/shared/components/components.dart';
import 'package:flutter_latest_news/shared/cubit/cubit.dart';
import 'package:flutter_latest_news/shared/cubit/states.dart';

class ScienceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      builder: (BuildContext context, state) {
        var list = NewsCubit.get(context).science;
        return articlesBuider(list, context);
      },
      listener: (context , state){},
    );

  }
}
