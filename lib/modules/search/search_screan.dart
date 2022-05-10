import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr3/layout/news_app/cubit/cubit.dart';
import 'package:pr3/layout/news_app/cubit/states.dart';
import 'package:pr3/shared/components/components.dart';

class SearchScrean extends StatelessWidget {
  var searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: searchcontroller,
                decoration: InputDecoration(
                  labelText: 'Search',
                  hintText: 'Enter search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text, // or any other type of input
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Search must not be null';
                  }
                  return null;
                },
                onChanged: (value) {
                  NewsCubit.get(context).getSearch(value);
                },
              ),
            ),
            Expanded(child: articalBuilder(list, context, isSearch: true))
          ]),
        );
      },
    );
  }
}
