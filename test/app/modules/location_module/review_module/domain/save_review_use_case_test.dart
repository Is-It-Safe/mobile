import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_review_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/request/request_save_review.dart';
import 'package:modular_test/modular_test.dart';

import '../mocks/mock_review_service.dart';

class SaveReviewSuccessTestModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => MockReviewService()),
        Bind((i) => SaveReviewUseCase(i.get<MockReviewService>())),
      ];
}

main() {
  setUpAll(() {
    initModule(SaveReviewSuccessTestModule());
  });

  group('SaveReviewUseCase <Success>', () {
    final request = RequestSaveReview(
      review: 'Testes de Dominio - Review',
      grade: 4,
      impressionStatus: 'SAFE',
      locationId: 1,
    );
    test('Retorna review salva com sucesso', () async {
      final useCase = Modular.get<SaveReviewUseCase>();

      final saveReviewUseCase = await useCase(
        review: request.review,
        grade: request.grade,
        impressionStatus: request.impressionStatus,
        locationId: request.locationId,
      );

      saveReviewUseCase.fold(
        (success) {
          expect(success.review, equals("Testes de Dominio - Review"));
        },
        (failure) {},
      );
    });
  });
}
