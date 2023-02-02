import 'package:flutter/cupertino.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_name_use_case.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactBloc extends SafeBloC {
  final GetUserNameUseCase getUserNameUseCase;
  late TextEditingController textController;

  ContactBloc({
    required this.getUserNameUseCase,
  }) {
    init();
  }

  @override
  Future<void> init() async {
    textController = TextEditingController();
  }

  validateText(String? value) {
    if (value?.trim().isEmpty ?? false) {
      return S.current.textErrorEmptyField;
    }
    return null;
  }

  Future<String> getUserName() {
    return Future<String>.value(getUserNameUseCase.call());
  }

  Future launchEmail({required String message}) async {
    String toEmail = 'contato@isitsafe.com.br';
    final userName = await getUserName();
    String subject = '[Feedback-App] - @$userName';
    final url = Uri.parse(
      'mailto:$toEmail?subject=$subject&body=$message',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw S.current.textContacActionError;
    }
  }

  @override
  Future<void> dispose() async {
    textController = TextEditingController();
  }
}
