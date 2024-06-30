import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alice/alice.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:next_starter/data/datasources/local_datasources/book_local/book_local.dart';
import 'package:next_starter/data/datasources/local_datasources/book_local/book_local_impl.dart';
import 'package:next_starter/data/datasources/remote_datasources/book_remote/book_remote.dart';
import 'package:next_starter/data/datasources/remote_datasources/book_remote/book_remote_impl.dart';
import 'package:next_starter/data/repositories/book_repository.dart';
import 'package:next_starter/presentation/layouts/book/bloc/book_layout_bloc.dart';
import 'package:next_starter/presentation/layouts/home/bloc/home_bloc.dart';
import 'package:next_starter/presentation/pages/book/detail/bloc/book_detail_bloc.dart';

import 'common/network/network_info.dart';
import 'common/permission/permission.dart';
import 'common/permission/permission_impl.dart';
import 'common/storage/shared_pref_storage.dart';
import 'common/storage/storage.dart';
import 'common/storage/storage_path.dart';
import 'common/utils/image_resize.dart';
import 'data/datasources/network/network_source.dart';
import 'data/datasources/session/session_source.dart';
import 'presentation/router/app_router.dart';

final locator = GetIt.instance;

class ApiServiceImpl extends ApiService {}

Future<void> initializeDependencies(GlobalKey<NavigatorState> navigatorKey) async {
  final apiService = ApiServiceImpl();
  final alice = Alice(showNotification: true, navigatorKey: navigatorKey);

  locator.registerLazySingleton<AppRouter>(() => AppRouter());
  locator.registerLazySingleton<Dio>(() => apiService.dio()..interceptors.add(alice.getDioInterceptor()));
  locator.registerLazySingleton<ImagePicker>(() => apiService.imagePicker);
  locator.registerFactoryAsync<StoragePathInterface>(apiService.init);
  locator.registerLazySingleton<ImageResizeUtils>(() => ImageResizeUtils());
  locator.registerLazySingleton<Connectivity>(() => apiService.internetConnectionChecker());
  locator.registerSingleton<NetworkInfo>(NetworkInfoImpl(locator.get()));
  locator.registerLazySingleton<PermissionInterface>(() => const KendaliPermission());
  locator.registerSingleton<SharedPrefStorageInterface>(SharedPreferenceStorage());
  locator.registerLazySingleton<StorageInterface>(() => Storage(permission: locator.get(), storagePath: locator.get()));
  locator.registerLazySingleton<SessionSource>(() => SessionSource(shared: locator()));

  locator.registerSingleton<BookRemote>(BookRemoteImpl(locator.get(), locator.get()));
  locator.registerSingleton(BookRepository(locator.get(), locator.get()));

  locator.registerSingleton<HomeBloc>(HomeBloc(locator.get()));

  locator.registerLazySingleton<BookLocal>(() => BookLocalImpl(box: GetStorage()));

  locator.registerSingleton<BookDetailBloc>(BookDetailBloc(locator.get()));

  locator.registerSingleton<BookLayoutBloc>(BookLayoutBloc(locator.get()));
}
