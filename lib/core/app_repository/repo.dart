import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../errors/exceptions.dart';
import '../errors/failures.dart';
import '../network/dio_helper.dart';

abstract class Repository {
  final DioHelper dioHelper = DioHelper();

  Future<Either<Failure, ReturnType>> exceptionHandler<ReturnType>(
      Future<ReturnType> Function() function) async {
    try {
      return Right(await function());
    } catch (e, s) {
      log(s.toString());
      log(e.runtimeType.toString());
      if (e is ServerException) {
        return left(
            ServerFailure(e.toString(), data: e.data, errorCode: e.errorCode));
      }

      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }

      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
}
