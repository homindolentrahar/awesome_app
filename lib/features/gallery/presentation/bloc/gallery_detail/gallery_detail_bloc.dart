import 'package:awesome_app/features/gallery/domain/model/image_model.dart';
import 'package:awesome_app/features/gallery/domain/usecase/get_image_detail_uc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'gallery_detail_event.dart';
part 'gallery_detail_state.dart';
part 'gallery_detail_bloc.freezed.dart';

class GalleryDetailBloc extends Bloc<GalleryDetailEvent, GalleryDetailState> {
  final RefreshController refreshController = RefreshController();
  final GetImageDetailUc _getImageDetailUc;

  GalleryDetailBloc({
    required GetImageDetailUc getImageDetailUc,
  })  : _getImageDetailUc = getImageDetailUc,
        super(GalleryDetailState.init()) {
    on<GalleryDetailEvent>((event, emit) async {
      await event.map(
        GetGalleryDetail: (instance) async {
          emit(GalleryDetailState.loading());

          final result = await _getImageDetailUc(instance.id);

          result.fold(
            (error) {
              emit(GalleryDetailState.error(
                message: error.message,
                statusCode: error.statusCode,
              ));
            },
            (data) {
              emit(GalleryDetailState.success(data));
            },
          );

          if (refreshController.isRefresh) {
            refreshController.refreshCompleted();
          }
        },
      );
    });
  }
}
