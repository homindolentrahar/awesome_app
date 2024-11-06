import 'package:dartz/dartz.dart';
import '../../../../core/error/app_error.dart';
import '../../../../features/home/domain/repository/home_repository.dart';
import '../../../../features/home/domain/model/home_model.dart';

class GetHomeUc {
  final HomeRepository repository;

  GetHomeUc(this.repository);

  Future<Either<AppError, List<HomeModel>>> call({
    int page = 1,
    int limit = 10,
  }) async =>
      repository.getHome(page: page, limit: limit);

}