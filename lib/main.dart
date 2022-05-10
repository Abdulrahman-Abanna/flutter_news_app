import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:hexcolor/hexcolor.dart';
//import 'package:intl/intl.dart';
import 'package:pr3/layout/news_app/news_layout.dart';
import 'package:pr3/screan_show_data.dart';
import 'package:pr3/shared/cubit/cubit.dart';
import 'package:pr3/shared/cubit/states.dart';
import 'package:pr3/shared/network/local/cache_helper.dart';
import 'package:pr3/shared/network/remote/dio_helper.dart';
import 'layout/news_app/cubit/cubit.dart';
import 'shared/bloc_observe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => NewsCubit()
              ..getBusiness()
              ..getScience()
              ..getSports(),
          ),
          BlocProvider(
            create: (BuildContext context) =>
                AppCubit()..ChangeModeTheme(fromshared: isDark),
          ),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
          builder: (BuildContext context, state) {
            return MaterialApp(
              theme: ThemeData(
                primarySwatch: Colors.orange,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  actionsIconTheme: IconThemeData(
                    color: Colors.black,
                    size: 30.0,
                  ),
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  elevation: 20.0,
                  selectedItemColor: Colors.orange,
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                )),
              ),
              darkTheme: ThemeData(
                primarySwatch: Colors.orange,
                scaffoldBackgroundColor: Color.fromARGB(255, 74, 80, 91),
                appBarTheme: AppBarTheme(
                  actionsIconTheme: IconThemeData(
                    color: Colors.white,
                    size: 30.0,
                  ),
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Color.fromARGB(255, 74, 80, 91),
                    statusBarIconBrightness: Brightness.light,
                  ),
                  backgroundColor: Color.fromARGB(255, 74, 80, 91),
                  elevation: 0.0,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  elevation: 20.0,
                  selectedItemColor: Colors.orange,
                  backgroundColor: Color.fromARGB(255, 74, 80, 91),
                  //backgroundColor: HexColor('333739'),
                  unselectedItemColor: Colors.grey,
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                )),
              ),
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: NewsLayout(),
            );
          },
          listener: (BuildContext context, Object? state) {},
        ));
  }
}

class MyHomePage extends StatelessWidget {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              title: Text("database"),
            ),
            body: Screan_Show_Data(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottumSheetShow) {
                  cubit.insertDatabase(
                    title: titleController.text,
                    date: dateController.text,
                    time: timeController.text,
                  );
                  cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                  // then((value) {
                  //   getDataFromDatabase(database).then((value) {
                  //     Navigator.pop(context);

                  //     // setState(() {
                  //     //   task = value;
                  //     // });
                  //   });
                  // });

                } else {
                  scaffoldkey.currentState!.showBottomSheet(
                    (context) => Container(
                      color: Colors.grey[100],
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        key: formkey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: titleController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.title),
                                hintText: 'Task Title',
                              ),
                              onTap: () {
                                print('data tapping');
                              },
                            ),
                            TextFormField(
                              controller: timeController,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.watch_later),
                                hintText: 'Task Time',
                              ),
                              onTap: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                    .then((value) {
                                  timeController.text =
                                      value!.format(context).toString();
                                });
                              },
                            ),
                            TextFormField(
                              controller: dateController,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.calendar_today),
                                hintText: 'Task Date',
                              ),
                              onTap: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2023-12-12'))
                                    .then((value) => {
                                          // dateController.text =
                                          //     DateFormat.yMMMd().format(value!)
                                        });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }
                //insertDatabase();
              },
              child: Icon(cubit.fabicon),
            ),
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//    DateTime _selectedate=DateTime.now();

//   void _datepicker() {
//     showDatePicker(
//       context: context,
//       initialDate: DateTime.utc(2018,2,8),
//       firstDate: DateTime(2018),
//       lastDate: DateTime.now(),
//     ).then((value) {
//       if (value == null) {
//         return;
//       }
//       setState(() {
//         _selectedate = value;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Pr3"),
//       ),
//       body: Center(
//         child: RaisedButton(
//           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
//           child: Text(
//             "$_selectedate",
//             style: TextStyle(color: Colors.white, fontSize: 30),
//           ),
//           color: Colors.black,
//           onPressed: _datepicker,
//         ),
//       ),
//     );
//   }
// }
