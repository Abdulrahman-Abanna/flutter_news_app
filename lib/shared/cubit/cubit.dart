import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:pr3/shared/cubit/states.dart';
import 'package:pr3/shared/network/local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  static AppCubit get(context) => BlocProvider.of(context);

  AppCubit() : super(AppinitialState());

  late Database database;
  List<Map> task = [];
  bool isBottumSheetShow = false;
  IconData fabicon = Icons.edit;

  void createDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'data.db');

    openDatabase(
      path,
      version: 1,
      onCreate: (Database db, version) async {
        print('database is created !');
        db
            .execute(
                'CREATE TABLE Test (id INTEGER PRIMARY KEY, title TEXT,date Text,time Text, status  Text)')
            .then((value) {
          print('table created !!');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        print('database Opened');

        getDataFromDatabase(database).then((value) {
          task = value;
          print(task);
          emit(AppGetDatabaseState());
        });
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertDatabase({
    required String title,
    required String time,
    required String date,
  }) {
    return database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO Test(title, date, time,status) VALUES("$title", "$date","$time","new")')
          .then((value) {
        print('$value insert succefully');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(database).then((value) {
          task = value;
          print(task);
          emit(AppGetDatabaseState());
        });
      }).catchError((error) {
        print('Error when inserting new Record ${error.toString()}');
      });
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database.rawQuery('SELECT * FROM Test');
  }

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottumSheetShow = isShow;
    fabicon = icon;
    emit(AppChangeBottomSheetState());
  }

  void deleteFromdatabase({
    required int ID,
  }) async {
    database.rawDelete('DELETE FROM Test WHERE id = ?', [ID]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isDark = false;
  void ChangeModeTheme({bool? fromshared}) {
    if (fromshared != null)
    {
      isDark = fromshared;
      emit(AppChangeModeThemeState());
    }
    else
    {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeThemeState());
          });
    }
    
  }
}
