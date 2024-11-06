import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:awesome_app/features/users/domain/model/user_model.dart';
import 'package:awesome_app/features/users/domain/usecase/get_users_uc.dart';
import 'package:awesome_app/core/constant/base_constant.dart';

part 'users_event.dart';
part 'users_state.dart';
part 'users_bloc.freezed.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final RefreshController refreshController = RefreshController();
  final GetUsersUc getUsersUc;

  UsersBloc({
    required this.getUsersUc,
  }) : super(const UsersState()) {
    on<UsersEvent>((event, emit) async {
      await event.map(GetUsers: (instance) async {
        emit(state.copyWith(
          status: BaseStatus.loading,
          query: instance.query,
          page: instance.page,
          limit: instance.limit,
        ));

        final result = await getUsersUc(
          page: instance.page,
          limit: instance.limit,
        );

        result.fold(
          (e) {
            emit(state.copyWith(
              status: BaseStatus.error,
              statusCode: e.statusCode,
              message: e.message,
            ));
          },
          (data) {
            final listOfData = List<UserModel>.from(state.data);

            if (instance.page <= 1) {
              listOfData.clear();
            }

            listOfData.addAll(data);

            emit(state.copyWith(
              status: BaseStatus.success,
              data: listOfData,
              hasMoreData: !(data.length < instance.limit),
            ));
          },
        );

        _completeLoad();
      });
    });
  }

  void _completeLoad() {
    if (refreshController.isLoading) {
      refreshController.loadComplete();
    }
    if (refreshController.isRefresh) {
      refreshController.refreshCompleted();
    }
  }
}
