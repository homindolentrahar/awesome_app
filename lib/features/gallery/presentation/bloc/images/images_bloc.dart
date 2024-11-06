import 'package:awesome_app/core/constant/gallery_constant.dart';
import 'package:awesome_app/features/gallery/domain/model/image_model.dart';
import 'package:awesome_app/features/gallery/domain/usecase/get_images_uc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../../core/constant/base_constant.dart';

part 'images_event.dart';
part 'images_state.dart';
part 'images_bloc.freezed.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final RefreshController refreshController = RefreshController();
  final GetImagesUc _getImagesUc;

  ImagesBloc({
    required GetImagesUc getImagesUc,
  })  : _getImagesUc = getImagesUc,
        super(const ImagesState()) {
    on<ImagesEvent>((event, emit) async {
      await event.map(
        GetImages: (instance) async {
          emit(state.copyWith(
            status:
                instance.page > 1 ? BaseStatus.loadMore : BaseStatus.loading,
            page: instance.page,
            perPage: instance.perPage,
          ));

          final result = await _getImagesUc(
            page: state.page,
            limit: state.perPage,
          );

          result.fold((error) {
            emit(state.copyWith(
              status: BaseStatus.error,
              statusCode: error.statusCode,
              message: error.message,
            ));
          }, (data) {
            final list = List<ImageModel>.from(state.data);

            if (state.page <= 1) {
              list.clear();
            }

            list.addAll(data);

            emit(state.copyWith(
              status: BaseStatus.success,
              hasMoreData: !(data.length < state.perPage),
              data: list,
            ));

            _completeLoad();
          });

          _completeLoad();
        },
        ChangeView: (instance) {
          emit(state.copyWith(
            viewType: instance.viewType,
          ));

          add(const ImagesEvent.GetImages());
        },
      );
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
