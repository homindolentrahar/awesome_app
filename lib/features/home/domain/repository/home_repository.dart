import 'package:dartz/dartz.dart';
import '../../../../core/error/app_error.dart';
import '../../../../features/home/domain/model/home_model.dart';

abstract interface class HomeRepository {
  Future<Either<AppError, List<HomeModel>>> getHome({
    int page = 1,
    int limit = 10,
  });
}