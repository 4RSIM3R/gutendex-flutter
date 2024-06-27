import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flavor/flavor.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/storage/storage_path.dart';

abstract class ApiService {
  Dio dio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Flavor.I.getString(Keys.apiUrl) ?? 'https://jsonplaceholder.typicode.com/',
        sendTimeout: const Duration(minutes: 3),
        connectTimeout: const Duration(minutes: 3),
        receiveTimeout: const Duration(minutes: 3),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
      ),
    );

    // enable http
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    };

    return dio;
  }

  Connectivity internetConnectionChecker() => Connectivity();

  ImagePicker get imagePicker => ImagePicker();

  Future<StoragePathInterface> init() async => StoragePath().initialize();
}
