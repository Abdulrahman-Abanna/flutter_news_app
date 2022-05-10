import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/news_app/cubit/cubit.dart';
import '../../layout/news_app/cubit/states.dart';
import '../../shared/components/components.dart';

class ScienceScrean extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var list = NewsCubit.get(context).science;

        return articalBuilder(list,context);
      },
    );
  }
}
