import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/src/app/modules/review/domain/models/response/response_delete_review.dart';
import 'package:is_it_safe_app/src/app/modules/review/domain/usecases/delete_review_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/profile/error/safe_profile_error.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/profile_service_mock.dart';

void main() {
  late ProfileServiceMock service;
  late DeleteReviewUseCase useCase;

  setUpAll(() {
    service = ProfileServiceMock();
    useCase = DeleteReviewUseCase(service);
  });

  group('DeleteReviewUseCase <Success>', () {
    test('Retorna [String]', () async {
      when(() => service.deleteReview(1))
          .thenAnswer((_) async => ResponseDeleteReview(message: 'Ok!'));

      final responseUseCase = await useCase(1);

      responseUseCase.fold((success) {
        expect(success, isA<String>());
        expect(success, equals('Ok!'));
      }, (failure) {
        expect(failure, null);
      });
    });
  });

  group('DeleteReviewUseCase <Failure>', () {
    test('Retorna [SafeDioResponseProfileError]', () async {
      when(() => service.deleteReview(1))
          .thenThrow(SafeDioResponseProfileError('safe.dio_response.error'));

      final responseUseCase = await useCase(1);

      responseUseCase.fold((success) {
        expect(success, null);
      }, (failure) {
        expect(failure.message, equals('safe.dio_response.error'));
      });
    });
  });
}
