import 'package:dartz/dartz.dart';
import 'package:awesome_app/core/error/app_error.dart';
import 'package:awesome_app/features/users/data/data_source/users_remote_data_source.dart';
import 'package:awesome_app/core/util/logger_util.dart';
import 'package:awesome_app/features/users/domain/model/user_model.dart';
import 'package:awesome_app/features/users/domain/repository/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDataSource remoteDataSource;

  UsersRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<AppError, List<UserModel>>> getUsers({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final result = await remoteDataSource.getUsers(
        page: page,
        limit: limit,
      );
      final models = result.map((e) => e.toModel()).toList();

      return Right(models);
    } on AppError catch (e) {
      LoggerUtil.instance().error(e.toString());
      return Left(e);
    }
  }
}
