// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Is It Safe?`
  String get textIsItSafe {
    return Intl.message(
      'Is It Safe?',
      name: 'textIsItSafe',
      desc: '',
      args: [],
    );
  }

  /// `Perfil`
  String get textAppBarProfileRegisterPage {
    return Intl.message(
      'Perfil',
      name: 'textAppBarProfileRegisterPage',
      desc: '',
      args: [],
    );
  }

  /// `Escolha seu avatar!`
  String get textAppBarChooseProfilePhotoPage {
    return Intl.message(
      'Escolha seu avatar!',
      name: 'textAppBarChooseProfilePhotoPage',
      desc: '',
      args: [],
    );
  }

  /// `Cadastro`
  String get textAppBarSignUp {
    return Intl.message(
      'Cadastro',
      name: 'textAppBarSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Vamos entrar.`
  String get textPageTitleLogin {
    return Intl.message(
      'Vamos entrar.',
      name: 'textPageTitleLogin',
      desc: '',
      args: [],
    );
  }

  /// `Sentimos sua falta!`
  String get textPageSubtitleLogin {
    return Intl.message(
      'Sentimos sua falta!',
      name: 'textPageSubtitleLogin',
      desc: '',
      args: [],
    );
  }

  /// `Escolha seu avatar`
  String get textPageTitleProfileRegisterPage {
    return Intl.message(
      'Escolha seu avatar',
      name: 'textPageTitleProfileRegisterPage',
      desc: '',
      args: [],
    );
  }

  /// `Não se esqueça de sorrir!`
  String get textPageSubtitleProfileRegisterPage {
    return Intl.message(
      'Não se esqueça de sorrir!',
      name: 'textPageSubtitleProfileRegisterPage',
      desc: '',
      args: [],
    );
  }

  /// `Esqueceu sua senha?`
  String get textButtonForgotPassword {
    return Intl.message(
      'Esqueceu sua senha?',
      name: 'textButtonForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Não possui uma conta?`
  String get textButtonDontHaveAccount {
    return Intl.message(
      'Não possui uma conta?',
      name: 'textButtonDontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Por favor, digite um nome de usuário válido`
  String get textErrorLoginUsername {
    return Intl.message(
      'Por favor, digite um nome de usuário válido',
      name: 'textErrorLoginUsername',
      desc: '',
      args: [],
    );
  }

  /// `Por favor, digite uma senha válida`
  String get textErrorLoginPassword {
    return Intl.message(
      'Por favor, digite uma senha válida',
      name: 'textErrorLoginPassword',
      desc: '',
      args: [],
    );
  }

  /// `Campos errados! Tente novamente.`
  String get textErrorWrongFields {
    return Intl.message(
      'Campos errados! Tente novamente.',
      name: 'textErrorWrongFields',
      desc: '',
      args: [],
    );
  }

  /// `Por favor, digite uma data válida`
  String get textErrorInvalidDate {
    return Intl.message(
      'Por favor, digite uma data válida',
      name: 'textErrorInvalidDate',
      desc: '',
      args: [],
    );
  }

  /// `Esse campo não pode ficar vazio`
  String get textErrorEmptyField {
    return Intl.message(
      'Esse campo não pode ficar vazio',
      name: 'textErrorEmptyField',
      desc: '',
      args: [],
    );
  }

  /// `Por favor, digite um e-mail válido`
  String get textErrorEmail {
    return Intl.message(
      'Por favor, digite um e-mail válido',
      name: 'textErrorEmail',
      desc: '',
      args: [],
    );
  }

  /// `ex: Ela/Dela, Ele/Dele, Ela/Elu`
  String get textErrorPronouns {
    return Intl.message(
      'ex: Ela/Dela, Ele/Dele, Ela/Elu',
      name: 'textErrorPronouns',
      desc: '',
      args: [],
    );
  }

  /// `Os campos de senha devem ser iguais`
  String get textErrorDifferentPasswords {
    return Intl.message(
      'Os campos de senha devem ser iguais',
      name: 'textErrorDifferentPasswords',
      desc: '',
      args: [],
    );
  }

  /// `Por favor, selecione seu avatar!`
  String get textErrorEmptyAvatar {
    return Intl.message(
      'Por favor, selecione seu avatar!',
      name: 'textErrorEmptyAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Algo deu errado!`
  String get textErrorDropdown {
    return Intl.message(
      'Algo deu errado!',
      name: 'textErrorDropdown',
      desc: '',
      args: [],
    );
  }

  /// `Usuário Registrado`
  String get textSuccessRegistration {
    return Intl.message(
      'Usuário Registrado',
      name: 'textSuccessRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Adicionar Local`
  String get textDrawerAddLocation {
    return Intl.message(
      'Adicionar Local',
      name: 'textDrawerAddLocation',
      desc: '',
      args: [],
    );
  }

  /// `Minha Conta`
  String get textDrawerMyAccount {
    return Intl.message(
      'Minha Conta',
      name: 'textDrawerMyAccount',
      desc: '',
      args: [],
    );
  }

  /// `Configuracoes`
  String get textDrawerConfiguration {
    return Intl.message(
      'Configurações',
      name: 'textDrawerConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Privacidade`
  String get textDrawerPrivacy {
    return Intl.message(
      'Privacidade',
      name: 'textDrawerPrivacy',
      desc: '',
      args: [],
    );
  }

  /// `Termos de Uso`
  String get textDrawerTerms {
    return Intl.message(
      'Termos de Uso',
      name: 'textDrawerTerms',
      desc: '',
      args: [],
    );
  }

  /// `Sobre`
  String get textDrawerAbout {
    return Intl.message(
      'Sobre',
      name: 'textDrawerAbout',
      desc: '',
      args: [],
    );
  }

  /// `Contato`
  String get textDrawerContact {
    return Intl.message(
      'Contato',
      name: 'textDrawerContact',
      desc: '',
      args: [],
    );
  }

  /// `Nenhum lugar próximo encontrado`
  String get textEmptyCard {
    return Intl.message(
      'Nenhum lugar próximo encontrado',
      name: 'textDrawerContact',
      desc: '',
      args: [],
    );
  }

  /// `Usuário`
  String get textUsername {
    return Intl.message(
      'Usuário',
      name: 'textUsername',
      desc: '',
      args: [],
    );
  }

  /// `Senha`
  String get textPassword {
    return Intl.message(
      'Senha',
      name: 'textPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirmar senha`
  String get textPasswordConfirmation {
    return Intl.message(
      'Confirmar senha',
      name: 'textPasswordConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get textLogin {
    return Intl.message(
      'Login',
      name: 'textLogin',
      desc: '',
      args: [],
    );
  }

  /// `Cadastre-se`
  String get textSignUp {
    return Intl.message(
      'Cadastre-se',
      name: 'textSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Data de nascimento`
  String get textDateOfBirth {
    return Intl.message(
      'Data de nascimento',
      name: 'textDateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Gênero`
  String get textGender {
    return Intl.message(
      'Gênero',
      name: 'textGender',
      desc: '',
      args: [],
    );
  }

  /// `Orientação Sexual`
  String get textSexualOrientation {
    return Intl.message(
      'Orientação Sexual',
      name: 'textSexualOrientation',
      desc: '',
      args: [],
    );
  }

  /// `Esqueci algum? Por favor`
  String get textForgotGender {
    return Intl.message(
      'Esqueci algum? Por favor',
      name: 'textForgotGender',
      desc: '',
      args: [],
    );
  }

  /// `me avise!`
  String get textforgotGenderSubtext {
    return Intl.message(
      'me avise!',
      name: 'textforgotGenderSubtext',
      desc: '',
      args: [],
    );
  }

  /// `Pular`
  String get textSkipForNow {
    return Intl.message(
      'Pular',
      name: 'textSkipForNow',
      desc: '',
      args: [],
    );
  }

  /// `Cadastrar`
  String get textRegister {
    return Intl.message(
      'Cadastrar',
      name: 'textRegister',
      desc: '',
      args: [],
    );
  }

  /// `Pronomes`
  String get textPronouns {
    return Intl.message(
      'Pronomes',
      name: 'textPronouns',
      desc: '',
      args: [],
    );
  }

  /// `Nome`
  String get textName {
    return Intl.message(
      'Nome',
      name: 'textName',
      desc: '',
      args: [],
    );
  }

  /// `Endereço de E-mail`
  String get textEmailAddress {
    return Intl.message(
      'Endereço de E-mail',
      name: 'textEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Pronto`
  String get textReady {
    return Intl.message(
      'Pronto',
      name: 'textReady',
      desc: '',
      args: [],
    );
  }

  /// `Cancelar`
  String get textCancel {
    return Intl.message(
      'Cancelar',
      name: 'textCancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirmar`
  String get textConfirm {
    return Intl.message(
      'Confirmar',
      name: 'textConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Avançar`
  String get textAdvance {
    return Intl.message(
      'Avançar',
      name: 'textAdvance',
      desc: '',
      args: [],
    );
  }

  /// `Carregando...`
  String get textLoading {
    return Intl.message(
      'Carregando...',
      name: 'textLoading',
      desc: '',
      args: [],
    );
  }

  /// `Finalizar`
  String get textFinish {
    return Intl.message(
      'Finalizar',
      name: 'textFinish',
      desc: '',
      args: [],
    );
  }

  /// `Lugares Próximos`
  String get textClosePlaces {
    return Intl.message(
      'Lugares Próximos',
      name: 'textClosePlaces',
      desc: '',
      args: [],
    );
  }

  /// `Melhores Avaliados`
  String get textBestRates {
    return Intl.message(
      'Melhores Avaliados',
      name: 'textBestRates',
      desc: '',
      args: [],
    );
  }

  /// `Agora escolha um nome para todos verem, seja criativo!`
  String get textDontBeAfraidToBeCreative {
    return Intl.message(
      'Agora escolha um nome para todos verem, seja criativo!',
      name: 'textDontBeAfraidToBeCreative',
      desc: '',
      args: [],
    );
  }

  /// `Como prefere que as pessoas se refiram a você?`
  String get textHowDoYouPreferWeReferToYou {
    return Intl.message(
      'Como prefere que as pessoas se refiram a você?',
      name: 'textHowDoYouPreferWeReferToYou',
      desc: '',
      args: [],
    );
  }

  /// `Sua segurança é muito importante para nós.`
  String get textWeCareAboutYourSafety {
    return Intl.message(
      'Sua segurança é muito importante para nós.',
      name: 'textWeCareAboutYourSafety',
      desc: '',
      args: [],
    );
  }

  /// `- Sua senha deve ter mais de 8 caracteres`
  String get textAtLeast8Characteres {
    return Intl.message(
      '- Sua senha deve ter mais de 8 caracteres',
      name: 'textAtLeast8Characteres',
      desc: '',
      args: [],
    );
  }

  /// `- letras e números`
  String get textLettersAndNumbers {
    return Intl.message(
      '- letras e números',
      name: 'textLettersAndNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Eu li e aceito os `
  String get textIReadAndAcceptThe {
    return Intl.message(
      'Eu li e aceito os ',
      name: 'textIReadAndAcceptThe',
      desc: '',
      args: [],
    );
  }

  /// `termos e condições`
  String get textTermsAndConditions {
    return Intl.message(
      'termos e condições',
      name: 'textTermsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Olá!,`
  String get textWelcome {
    return Intl.message(
      'Olá!,',
      name: 'textWelcome',
      desc: '',
      args: [],
    );
  }

  /// `Será um prazer te conhecer.`
  String get textMeetingYouWillBeAPleasure {
    return Intl.message(
      'Será um prazer te conhecer.',
      name: 'textMeetingYouWillBeAPleasure',
      desc: '',
      args: [],
    );
  }

  /// `Nos diga seu nome!\nEssa informação aparecerá apenas para você.`
  String get textSayYourNameThisInfoIsPrivate {
    return Intl.message(
      'Nos diga seu nome!\nEssa informação aparecerá apenas para você.',
      name: 'textSayYourNameThisInfoIsPrivate',
      desc: '',
      args: [],
    );
  }

  /// `Nos diga seu e-mail, ele será associado a sua conta`
  String get textTellUsTheEmailAssociatedWithYourAccount {
    return Intl.message(
      'Nos diga seu e-mail, ele será associado a sua conta',
      name: 'textTellUsTheEmailAssociatedWithYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Uma representação sua aqui dentro!`
  String get textYourRepresentationHereInside {
    return Intl.message(
      'Uma representação sua aqui dentro!',
      name: 'textYourRepresentationHereInside',
      desc: '',
      args: [],
    );
  }

  /// `Exemplo: Ela/Dela, Elu/Delu, Ela/Elu`
  String get textExamplePronouns {
    return Intl.message(
      'Exemplo: Ela/Dela, Elu/Delu, Ela/Elu',
      name: 'textExamplePronouns',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get textSearchForm {
    return Intl.message(
      'Search',
      name: 'textSearchForm',
      desc: '',
      args: [],
    );
  }  

  /// `Foco em`
  String get textOnBoarding1_0 {
    return Intl.message(
      'Foco em',
      name: 'textOnBoarding1_0',
      desc: '',
      args: [],
    );
  }

  /// `segurança`
  String get textOnBoarding1_1 {
    return Intl.message(
      'segurança',
      name: 'textOnBoarding1_1',
      desc: '',
      args: [],
    );
  }

  /// `e`
  String get textOnBoarding1_2 {
    return Intl.message(
      'e',
      name: 'textOnBoarding1_2',
      desc: '',
      args: [],
    );
  }

  /// `comunidade`
  String get textOnBoarding1_3 {
    return Intl.message(
      'comunidade',
      name: 'textOnBoarding1_3',
      desc: '',
      args: [],
    );
  }

  /// `Saiba onde frequentar com`
  String get textOnBoarding2_0 {
    return Intl.message(
      'Saiba onde frequentar com',
      name: 'textOnBoarding2_0',
      desc: '',
      args: [],
    );
  }

  /// `segurança`
  String get textOnBoarding2_1 {
    return Intl.message(
      'segurança',
      name: 'textOnBoarding2_1',
      desc: '',
      args: [],
    );
  }

  /// `Descreva suas`
  String get textOnBoarding3_0 {
    return Intl.message(
      'Descreva suas',
      name: 'textOnBoarding3_0',
      desc: '',
      args: [],
    );
  }

  /// `experiências`
  String get textOnBoarding3_1 {
    return Intl.message(
      'experiências',
      name: 'textOnBoarding3_1',
      desc: '',
      args: [],
    );
  }

  /// `e avalie locais`
  String get textOnBoarding3_2 {
    return Intl.message(
      'e avalie locais',
      name: 'textOnBoarding3_2',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
