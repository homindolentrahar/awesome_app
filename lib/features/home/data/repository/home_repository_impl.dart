import 'package:dartz/dartz.dart';
import '../../../../core/error/app_error.dart';
import '../../../../core/util/logger_util.dart';
import '../../../../features/home/data/data_source/home_remote_data_source.dart';
import '../../../../features/home/data/data_source/home_local_data_source.dart';
import '../../../../features/home/domain/model/home_model.dart';
import '../../../../features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<AppError, List<HomeModel>>> getHome({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      // Do API call and cache the result here

      return Right([]);
    } on AppError catch (e) {
      LoggerUtil.instance().error(e.toString());
      return Left(e);
    }
  }
}
