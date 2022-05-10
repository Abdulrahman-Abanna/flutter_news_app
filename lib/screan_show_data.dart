import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr3/build_task_item.dart';
import 'package:pr3/shared/components/components.dart';
import 'package:pr3/shared/cubit/cubit.dart';
import 'package:pr3/shared/cubit/states.dart';

class Screan_Show_Data extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        AppCubit cubit = AppCubit.get(context);
        return ListView.separated(
          itemBuilder: (context, index) =>
              BuildTaskItem(index: index),
          separatorBuilder: (context, indix) =>buildSparate(),
          itemCount: cubit.task.length,
        );
      },
    );
  }

  // Widget buildTaskItem(Map modle) =>
}
