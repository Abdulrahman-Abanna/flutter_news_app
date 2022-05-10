import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr3/layout/news_app/cubit/cubit.dart';
import 'package:pr3/layout/news_app/cubit/states.dart';
import 'package:pr3/shared/components/components.dart';

class BusinessScrean extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var list = NewsCubit.get(context).business;

        return articalBuilder(list,context);
      },
    );
  }
}
