import 'package:sm_to_do_list/data/datasources/db/database_helper.dart';
import 'package:sm_to_do_list/domain/usecases/get_to_do_list.dart';
import 'package:sm_to_do_list/domain/usecases/save_to_do.dart';
import 'package:sm_to_do_list/presentation/bloc/to_do_list_bloc.dart';
import 'package:sm_to_do_list/common/ssl_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';
import 'data/datasources/data.dart';
import 'data/repositories/to_do_list_repository_impl.dart';
import 'domain/repositories/to_do_list_repository.dart';
import 'domain/usecases/remove_to_do.dart';
import 'domain/usecases/update_to_do.dart';

final locator = GetIt.instance;

Future<void> init() async {
  IOClient getClient = await SSLHelper.ioClient;

  //bloc
  locator.registerFactory(
    () => ToDoListBloc(
      getToDoList: locator(),
      saveToDo: locator(),
      deleteToDo: locator(),
      updateToDo: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetToDoList(locator()));
  locator.registerLazySingleton(() => SaveToDo(locator()));
  locator.registerLazySingleton(() => RemoveToDo(locator()));
  locator.registerLazySingleton(() => UpdateToDo(locator()));

  // repository
  locator.registerLazySingleton<ToDoListRepository>(
    () => ToDoListRepositoryImpl(
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<ToDoListDataSource>(
      () => ToDoListDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<ToDoListDatabaseHelper>(
      () => ToDoListDatabaseHelper());

  // external
  locator.registerLazySingleton(() => getClient);
}
