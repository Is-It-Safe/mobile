import 'package:is_it_safe_app/src/domain/use_case/get_user_name_use_case.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactBloc {
  final getUserNameUseCase = GetUserNameUseCase();

  Future<String> getUserName() {
    return Future<String>.value(getUserNameUseCase.call());
  }

  Future launchEmail({
    required String message,
  }) async {
    String toEmail = 'contato@isitsafe.com.br';
    final userName = await getUserName();
    String subject = '[Feedback-App] - @$userName';
    final url = Uri.parse(
      'mailto:$toEmail?subject=$subject&body=$message',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Não foi possível realizar a ação.';
    }
  }
}
