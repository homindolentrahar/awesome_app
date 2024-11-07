import 'package:awesome_app/core/constant/base_constant.dart';
import 'package:awesome_app/core/error/app_error.dart';
import 'package:awesome_app/features/gallery/domain/usecase/get_images_uc.dart';
import 'package:awesome_app/features/gallery/presentation/bloc/images/images_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../core/constant/dummy_test_data.dart';

@GenerateMocks([GetImagesUc])
import 'images_bloc_test.mocks.dart';

void main() {
  group(ImagesBloc, () {
    late ImagesBloc bloc;
    late MockGetImagesUc getImagesUc;

    setUp(() {
      getImagesUc = MockGetImagesUc();
      bloc = ImagesBloc(
        getImagesUc: getImagesUc,
      );
    });

    tearDown(() {
      bloc.close();
    });

    test('emit status BaseStatus.init when first initialized', () {
      expect(bloc.state.status, BaseStatus.init);
    });

    blocTest(
      'emit list of images when event ImagesEvent.GetImages is added',
      setUp: (() {
        when(getImagesUc.call()).thenAnswer(
          (_) async => Right(successCurratedModels),
        );
      }),
      build: () => bloc,
      act: (bloc) => bloc.add(const ImagesEvent.GetImages()),
      expect: () => [
        equals(const ImagesState(status: BaseStatus.loading)),
        equals(ImagesState(
          status: BaseStatus.success,
          data: successCurratedModels,
        )),
      ],
    );

    blocTest(
      'emit list of images with status of BaseStatus.loadMore when event ImagesEvent.GetImages is added with page more than 1',
      setUp: (() {
        when(getImagesUc.call(page: 2)).thenAnswer(
          (_) async => Right(successCurratedModels),
        );
      }),
      build: () => bloc,
      act: (bloc) => bloc.add(const ImagesEvent.GetImages(page: 2)),
      expect: () => [
        equals(const ImagesState(status: BaseStatus.loadMore, page: 2)),
        equals(ImagesState(
          status: BaseStatus.success,
          data: successCurratedModels,
          page: 2,
        )),
      ],
    );

    blocTest(
      'emit statusCode and message with status BaseSttus.error when event ImagesEvent.GetImages is added',
      setUp: (() {
        when(getImagesUc.call()).thenAnswer(
          (_) async => Left(AppError(
            message: 'Error',
            statusCode: 500,
          )),
        );
      }),
      build: () => bloc,
      act: (bloc) => bloc.add(const ImagesEvent.GetImages()),
      expect: () => [
        equals(const ImagesState(status: BaseStatus.loading)),
        equals(const ImagesState(
          status: BaseStatus.error,
          statusCode: 500,
          message: 'Error',
        )),
      ],
    );
  });
}
