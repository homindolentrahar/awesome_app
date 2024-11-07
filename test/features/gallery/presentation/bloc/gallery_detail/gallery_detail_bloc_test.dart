import 'package:awesome_app/core/error/app_error.dart';
import 'package:awesome_app/features/gallery/domain/usecase/get_image_detail_uc.dart';
import 'package:awesome_app/features/gallery/presentation/bloc/gallery_detail/gallery_detail_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../core/constant/dummy_test_data.dart';
import 'gallery_detail_bloc_test.mocks.dart';

@GenerateMocks([GetImageDetailUc])
void main() {
  group(GalleryDetailBloc, () {
    late GalleryDetailBloc bloc;
    late MockGetImageDetailUc getImageDetailUc;

    setUp(() {
      getImageDetailUc = MockGetImageDetailUc();
      bloc = GalleryDetailBloc(
        getImageDetailUc: getImageDetailUc,
      );
    });

    tearDown(() {
      bloc.close();
    });

    test('emit status BaseStatus.init when first initialized', () {
      expect(bloc.state, GalleryDetailState.init());
    });

    blocTest(
      'emit single photo when event GalleryDetailEvent.GetGalleryDetail is added',
      setUp: (() {
        when(getImageDetailUc.call(3573351)).thenAnswer(
          (_) async => Right(successCurratedModels.first),
        );
      }),
      build: () => bloc,
      act: (bloc) => bloc.add(
        const GalleryDetailEvent.GetGalleryDetail(3573351),
      ),
      expect: () => [
        equals(GalleryDetailState.loading()),
        equals(GalleryDetailState.success(successCurratedModels.first)),
      ],
    );

    blocTest(
      'emit statusCode and message with status BaseSttus.error when event GalleryDetailEvent.GetGalleryDetail is added',
      setUp: (() {
        when(getImageDetailUc.call(3573351)).thenAnswer(
          (_) async => Left(AppError(
            message: 'Error',
            statusCode: 500,
          )),
        );
      }),
      build: () => bloc,
      act: (bloc) => bloc.add(
        const GalleryDetailEvent.GetGalleryDetail(3573351),
      ),
      expect: () => [
        equals(GalleryDetailState.loading()),
        equals(const GalleryDetailState.error(
          statusCode: 500,
          message: 'Error',
        )),
      ],
    );
  });
}
