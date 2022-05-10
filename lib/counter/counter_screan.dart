import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr3/counter/cubit/cubit.dart';
import 'package:pr3/counter/cubit/states.dart';

class CounterScrean extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (BuildContext context, state) {
                    if (state is CounterPlusState) 
                    {
                      print('Plus state ${state.counter}');
                    }
                    if (state is CounterMinusState)
                    {
                      print('Minus state ${state.counter}');
                    }

            },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Counter',
              ),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).Minus();
                      },
                      child: Text('MINUS')),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      '${CounterCubit.get(context).counter}',
                      style: TextStyle(
                          fontSize: 50.0, fontWeight: FontWeight.w900),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      CounterCubit.get(context).Plus();
                    },
                    child: Text('PLUS'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
