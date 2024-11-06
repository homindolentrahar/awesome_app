import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../../core/constant/base_constant.dart';

part 'images_event.dart';
part 'images_state.dart';
part 'images_bloc.freezed.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final RefreshController refreshController = RefreshController();

  ImagesBloc() : super(const ImagesState()) {
    on<ImagesEvent>((event, emit) {
      event.map(GetImages: (instance) async {
        try {
          emit(state.copyWith(
            status: BaseStatus.loading,
            query: instance.query,
            page: instance.page,
            limit: instance.limit,
          ));

          final data = ['User 1', 'User 2', 'User 3'];

          final listOfData = state.data;

          if (instance.page <= 1) {
            listOfData.clear();
          }

          listOfData.addAll(data);

          emit(state.copyWith(
            status: BaseStatus.success,
            data: listOfData,
            hasMoreData: !(data.length < instance.limit),
          ));

          _completeLoad();
        } catch (e) {
          emit(state.copyWith(status: BaseStatus.error, message: e.toString()));

          _completeLoad();
        }
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
