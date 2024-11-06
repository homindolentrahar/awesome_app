import 'package:dartz/dartz.dart';
import 'package:awesome_app/core/error/app_error.dart';
import 'package:awesome_app/features/users/domain/model/user_model.dart';

abstract interface class UsersRepository {
  Future<Either<AppError, List<UserModel>>> getUsers({
    int page = 1,
    int limit = 10,
  });
}
