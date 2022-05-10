import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr3/layout/news_app/cubit/cubit.dart';
import 'package:pr3/layout/news_app/cubit/states.dart';
import 'package:pr3/modules/search/search_screan.dart';
import 'package:pr3/shared/components/components.dart';
import 'package:pr3/shared/cubit/cubit.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("News App"),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    navigationTo(context, SearchScrean());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.brightness_4_outlined),
                  onPressed: () {
                    AppCubit.get(context).ChangeModeTheme();
                  },
                ),
              ],
            ),
            body: cubit.screan[cubit.cutrrentindex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.cutrrentindex,
              onTap: (index) {
                cubit.ChangeBottomNavBar(index);
              },
              items: cubit.bottomItem,
            ),
          );
        },
        listener: (context, state) {});
  }
}
