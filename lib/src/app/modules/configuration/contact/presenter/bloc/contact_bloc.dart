import 'package:flutter/cupertino.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/usecases/get_user_name_use_case.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/core/util/string_util.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactBloc extends SafeBloC {
  final GetUserNameUseCase getUserNameUseCase;

  final messageController = TextEditingController();
  final isMessageSent = SafeStream<bool>(data: false);

  ContactBloc({
    required this.getUserNameUseCase,
  });

  @override
  Future<void> init() async {}

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
    final userName = await getUserName();

    final emailLaunchUri = Uri(
      scheme: StringConstants.schemeMailTo,
      path: Uri.encodeFull(StringConstants.contactEmail),
      queryParameters: {
        StringConstants.subject: Uri.encodeFull(
          StringUtil.getContactEmailSubject(userName),
        ),
        StringConstants.body: Uri.encodeFull(message),
      },
    );
    isMessageSent.loading();
    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
        isMessageSent.data = true;
        safeSnackBar.success(S.current.textContactMessageSentSuccess);
      } else {
        isMessageSent.data = false;
        throw S.current.textContacActionError;
      }
    } catch (e) {
      isMessageSent.show();
      safeSnackBar.error(e.toString());
    }
  }

  @override
  Future<void> dispose() async {
    messageController.clear();
    isMessageSent.data = false;
  }
}
