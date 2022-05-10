import 'package:flutter/material.dart';
import 'package:pr3/shared/cubit/cubit.dart';

class BuildTaskItem extends StatelessWidget {
  final index;

  const BuildTaskItem({ required this.index});
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
      Map modle=cubit.task[index];
    return Dismissible(
      key: Key(modle['id'].toString()),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text('${modle['time']}'),
            ),
            SizedBox(
              width: 30.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${modle['title']}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    )),
                Text(
                  '${modle['date']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteFromdatabase(ID: modle['id']);
      },
    );
  }
}
