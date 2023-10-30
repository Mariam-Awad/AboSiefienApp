
import 'package:abosiefienapp/network/network_manager.dart';
import 'package:dio/dio.dart';

abstract class BaseRepo {
  CancelToken? cancelToken;
  late NetworkManager networkManager;


  BaseRepo() {
    cancelToken = CancelToken();
    networkManager = NetworkManager(cancelToken: cancelToken);
  }

  void dispose() {
    cancelToken!.cancel();
  }
}
