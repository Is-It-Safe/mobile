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

  /// `Início`
  String get textBottomNavBarHome {
    return Intl.message(
      'Início',
      name: 'textBottomNavBarHome',
      desc: '',
      args: [],
    );
  }

  /// `Buscar`
  String get textBottomNavBarSearch {
    return Intl.message(
      'Buscar',
      name: 'textBottomNavBarSearch',
      desc: '',
      args: [],
    );
  }

  /// `Avaliações`
  String get textBottomNavBarReviews {
    return Intl.message(
      'Avaliações',
      name: 'textBottomNavBarReviews',
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

  /// `A confirmação de senha não confere`
  String get textErrorDifferentPasswords {
    return Intl.message(
      'A confirmação de senha não confere',
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

  /// `Algo deu errado!`
  String get textError {
    return Intl.message(
      'Algo deu errado!',
      name: 'textError',
      desc: '',
      args: [],
    );
  }

  /// `Tente novamente em alguns instantes.`
  String get textErrorTryAgain {
    return Intl.message(
      'Tente novamente em alguns instantes.',
      name: 'textErrorTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Não achamos nenhum local com esse nome.\nQue tal adicionar ele?`
  String get textErrorSearch {
    return Intl.message(
      'Não achamos nenhum local com esse nome.\nQue tal adicionar ele?',
      name: 'textErrorSearch',
      desc: '',
      args: [],
    );
  }

  /// `Nenhum lugar próximo encontrado, comece a avaliar seu bairro!`
  String get textErrorHome {
    return Intl.message(
      'Nenhum lugar próximo encontrado, comece a avaliar seu bairro!',
      name: 'textErrorHome',
      desc: '',
      args: [],
    );
  }

  /// `Nenhum lugar encontrado, comece a avaliar!`
  String get textErrorHomeBestRated {
    return Intl.message(
      'Nenhum lugar encontrado, comece a avaliar!',
      name: 'textErrorHomeBestRated',
      desc: '',
      args: [],
    );
  }

  /// `Nenhum lugar próximo encontrado, ative as permissões de localização!`
  String get textErrorLocationPermission {
    return Intl.message(
      'Nenhum lugar próximo encontrado, ative as permissões de localização!',
      name: 'textErrorLocationPermission',
      desc: '',
      args: [],
    );
  }

  /// `Você não fez nenhuma review ainda, comece assim que puder!`
  String get textErrorProfile {
    return Intl.message(
      'Você não fez nenhuma review ainda, comece assim que puder!',
      name: 'textErrorProfile',
      desc: '',
      args: [],
    );
  }

  /// `Este local não possui nenhuma review ainda, escreva uma!`
  String get textErrorEmptyReviews {
    return Intl.message(
      'Este local não possui nenhuma review ainda, escreva uma!',
      name: 'textErrorEmptyReviews',
      desc: '',
      args: [],
    );
  }

  /// `Algo de errado aconteceu, tente novamente em alguns instantes.`
  String get textErrorUnknown {
    return Intl.message(
      'Algo de errado aconteceu, tente novamente em alguns instantes.',
      name: 'textErrorUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Não foi possível deletar a review!`
  String get textErrorDeleteReview {
    return Intl.message(
      'Não foi possível deletar a review!',
      name: 'textErrorDeleteReview',
      desc: '',
      args: [],
    );
  }

  /// `Ocorreu um erro ao obter sua localização!`
  String get textErrorGetLocation {
    return Intl.message(
      'Ocorreu um erro ao obter sua localização!',
      name: 'textErrorGetLocation',
      desc: '',
      args: [],
    );
  }

  /// `Usuário ou senha inválido!`
  String get textErrorLoginUnauthorized {
    return Intl.message(
      'Usuário ou senha inválido!',
      name: 'textErrorLoginUnauthorized',
      desc: '',
      args: [],
    );
  }

  /// `Não foi possível fazer login, tente novamente em alguns instantes.`
  String get textErrorLoginFailed {
    return Intl.message(
      'Não foi possível fazer login, tente novamente em alguns instantes.',
      name: 'textErrorLoginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Erro ao carregar as informações do usuário.`
  String get textErrorToLoadTheUsersInformation {
    return Intl.message(
      'Erro ao carregar as informações do usuário.',
      name: 'textErrorToLoadTheUsersInformation',
      desc: '',
      args: [],
    );
  }

  /// `'Erro ao realizar o cadastro. Tente novamente mais tarde.'`
  String get textErrorToRegisterUser {
    return Intl.message(
      '\'Erro ao realizar o cadastro. Tente novamente mais tarde.\'',
      name: 'textErrorToRegisterUser',
      desc: '',
      args: [],
    );
  }

  /// `'Erro ao carregar os gêneros. Tente novamente mais tarde.'`
  String get textErrorToGetGender {
    return Intl.message(
      '\'Erro ao carregar os gêneros. Tente novamente mais tarde.\'',
      name: 'textErrorToGetGender',
      desc: '',
      args: [],
    );
  }

  /// `'Erro ao carregar as orientações sexuais. Tente novamente mais tarde.'`
  String get textErrorToGetSexualOrientation {
    return Intl.message(
      '\'Erro ao carregar as orientações sexuais. Tente novamente mais tarde.\'',
      name: 'textErrorToGetSexualOrientation',
      desc: '',
      args: [],
    );
  }

  /// `'Erro ao verificar a disponibilidade do nome de usuário. Tente novamente mais tarde.'`
  String get textErrorToCheckUsernameAvailability {
    return Intl.message(
      '\'Erro ao verificar a disponibilidade do nome de usuário. Tente novamente mais tarde.\'',
      name: 'textErrorToCheckUsernameAvailability',
      desc: '',
      args: [],
    );
  }

  /// `'Erro ao verificar a disponibilidade do e-mail. Tente novamente mais tarde.'`
  String get textErrorToCheckEmailAvailability {
    return Intl.message(
      '\'Erro ao verificar a disponibilidade do e-mail. Tente novamente mais tarde.\'',
      name: 'textErrorToCheckEmailAvailability',
      desc: '',
      args: [],
    );
  }

  /// `'Erro ao carregar as informações do usuário. Tente novamente mais tarde.'`
  String get textErrorToGetUserInformation {
    return Intl.message(
      '\'Erro ao carregar as informações do usuário. Tente novamente mais tarde.\'',
      name: 'textErrorToGetUserInformation',
      desc: '',
      args: [],
    );
  }

  /// `'Erro ao desativar o usuário. Tente novamente mais tarde.'`
  String get textErrorToDeactivateUser {
    return Intl.message(
      '\'Erro ao desativar o usuário. Tente novamente mais tarde.\'',
      name: 'textErrorToDeactivateUser',
      desc: '',
      args: [],
    );
  }

  /// `'Erro ao atualizar as informações do usuário. Tente novamente mais tarde.'`
  String get textErrorToUpdateUserInformation {
    return Intl.message(
      '\'Erro ao atualizar as informações do usuário. Tente novamente mais tarde.\'',
      name: 'textErrorToUpdateUserInformation',
      desc: '',
      args: [],
    );
  }

  /// `'Erro ao deletar a review. Tente novamente mais tarde.'`
  String get textErrorToDeleteReview {
    return Intl.message(
      '\'Erro ao deletar a review. Tente novamente mais tarde.\'',
      name: 'textErrorToDeleteReview',
      desc: '',
      args: [],
    );
  }

  /// `'Erro ao buscar o local pelo nome. Tente novamente mais tarde.'`
  String get textErrorToSearchPlaceByName {
    return Intl.message(
      '\'Erro ao buscar o local pelo nome. Tente novamente mais tarde.\'',
      name: 'textErrorToSearchPlaceByName',
      desc: '',
      args: [],
    );
  }

  /// `Pesquise locais para avaliar`
  String get textInitialSearch {
    return Intl.message(
      'Pesquise locais para avaliar',
      name: 'textInitialSearch',
      desc: '',
      args: [],
    );
  }

  /// `Review deletada com sucesso!`
  String get textDefaultDeleteReviewMessage {
    return Intl.message(
      'Review deletada com sucesso!',
      name: 'textDefaultDeleteReviewMessage',
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

  /// `Sua review foi publicada!`
  String get textPublishedReview {
    return Intl.message(
      'Sua review foi publicada!',
      name: 'textPublishedReview',
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

  /// `Permitir`
  String get textAllow {
    return Intl.message(
      'Permitir',
      name: 'textAllow',
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

  /// `Negar`
  String get textDeny {
    return Intl.message(
      'Negar',
      name: 'textDeny',
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

  /// `Buscar`
  String get textSearch {
    return Intl.message(
      'Buscar',
      name: 'textSearch',
      desc: '',
      args: [],
    );
  }

  /// `Configurações`
  String get textConfiguration {
    return Intl.message(
      'Configurações',
      name: 'textConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Privacidade`
  String get textPrivacy {
    return Intl.message(
      'Privacidade',
      name: 'textPrivacy',
      desc: '',
      args: [],
    );
  }

  /// `Termos de Uso`
  String get textTermsOfUse {
    return Intl.message(
      'Termos de Uso',
      name: 'textTermsOfUse',
      desc: '',
      args: [],
    );
  }

  /// `Sobre`
  String get textAbout {
    return Intl.message(
      'Sobre',
      name: 'textAbout',
      desc: '',
      args: [],
    );
  }

  /// `Contato`
  String get textContact {
    return Intl.message(
      'Contato',
      name: 'textContact',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get textOk {
    return Intl.message(
      'Ok',
      name: 'textOk',
      desc: '',
      args: [],
    );
  }

  /// `Avaliações`
  String get textReviews {
    return Intl.message(
      'Avaliações',
      name: 'textReviews',
      desc: '',
      args: [],
    );
  }

  /// `Suas Avaliações`
  String get textYourReviews {
    return Intl.message(
      'Suas Avaliações',
      name: 'textYourReviews',
      desc: '',
      args: [],
    );
  }

  /// `Irritado`
  String get textAngry {
    return Intl.message(
      'Irritado',
      name: 'textAngry',
      desc: '',
      args: [],
    );
  }

  /// `Chateado`
  String get textUpset {
    return Intl.message(
      'Chateado',
      name: 'textUpset',
      desc: '',
      args: [],
    );
  }

  /// `Regular`
  String get textRegular {
    return Intl.message(
      'Regular',
      name: 'textRegular',
      desc: '',
      args: [],
    );
  }

  /// `Neutro`
  String get textNeutral {
    return Intl.message(
      'Neutro',
      name: 'textNeutral',
      desc: '',
      args: [],
    );
  }

  /// `Satisfeito`
  String get textSatisfied {
    return Intl.message(
      'Satisfeito',
      name: 'textSatisfied',
      desc: '',
      args: [],
    );
  }

  /// `Incrível`
  String get textIncredible {
    return Intl.message(
      'Incrível',
      name: 'textIncredible',
      desc: '',
      args: [],
    );
  }

  /// `Contente`
  String get textHappy {
    return Intl.message(
      'Contente',
      name: 'textHappy',
      desc: '',
      args: [],
    );
  }

  /// `Alegre`
  String get textExcited {
    return Intl.message(
      'Alegre',
      name: 'textExcited',
      desc: '',
      args: [],
    );
  }

  /// `Ver mais`
  String get textSeeMore {
    return Intl.message(
      'Ver mais',
      name: 'textSeeMore',
      desc: '',
      args: [],
    );
  }

  /// `Ver menos`
  String get textSeeLess {
    return Intl.message(
      'Ver menos',
      name: 'textSeeLess',
      desc: '',
      args: [],
    );
  }

  /// `Remover`
  String get textDelete {
    return Intl.message(
      'Remover',
      name: 'textDelete',
      desc: '',
      args: [],
    );
  }

  /// `Compartilhar`
  String get textShare {
    return Intl.message(
      'Compartilhar',
      name: 'textShare',
      desc: '',
      args: [],
    );
  }

  /// `Informações Pessoais`
  String get textPersonalInformation {
    return Intl.message(
      'Informações Pessoais',
      name: 'textPersonalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Editar Perfil`
  String get textEditProfile {
    return Intl.message(
      'Editar Perfil',
      name: 'textEditProfile',
      desc: '',
      args: [],
    );
  }

  /// `Editar Conta`
  String get textEditAccount {
    return Intl.message(
      'Editar Conta',
      name: 'textEditAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sair`
  String get textLogout {
    return Intl.message(
      'Sair',
      name: 'textLogout',
      desc: '',
      args: [],
    );
  }

  /// `Desativar Conta`
  String get textDisableAccount {
    return Intl.message(
      'Desativar Conta',
      name: 'textDisableAccount',
      desc: '',
      args: [],
    );
  }

  /// `Excluir Conta`
  String get textDeleteAccount {
    return Intl.message(
      'Excluir Conta',
      name: 'textDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Alterar E-mail`
  String get textChangeEmail {
    return Intl.message(
      'Alterar E-mail',
      name: 'textChangeEmail',
      desc: '',
      args: [],
    );
  }

  /// `Alterar Senha`
  String get textChangePassword {
    return Intl.message(
      'Alterar Senha',
      name: 'textChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Informações da Conta`
  String get textAccountInformation {
    return Intl.message(
      'Informações da Conta',
      name: 'textAccountInformation',
      desc: '',
      args: [],
    );
  }

  /// `Estrutura`
  String get textStructure {
    return Intl.message(
      'Estrutura',
      name: 'textStructure',
      desc: '',
      args: [],
    );
  }

  /// `Segurança`
  String get textSecurity {
    return Intl.message(
      'Segurança',
      name: 'textSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Atendimento`
  String get textService {
    return Intl.message(
      'Atendimento',
      name: 'textService',
      desc: '',
      args: [],
    );
  }

  /// `LGBTfobia`
  String get textLGBTFobia {
    return Intl.message(
      'LGBTfobia',
      name: 'textLGBTFobia',
      desc: '',
      args: [],
    );
  }

  /// `Escreva aqui...`
  String get textWriteHere {
    return Intl.message(
      'Escreva aqui...',
      name: 'textWriteHere',
      desc: '',
      args: [],
    );
  }

  /// `Enviar`
  String get textSend {
    return Intl.message(
      'Enviar',
      name: 'textSend',
      desc: '',
      args: [],
    );
  }

  /// `Voltar ao local`
  String get textBackToLocation {
    return Intl.message(
      'Voltar ao local',
      name: 'textBackToLocation',
      desc: '',
      args: [],
    );
  }

  /// `Review Completa!`
  String get textReviewCompleted {
    return Intl.message(
      'Review Completa!',
      name: 'textReviewCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Continuar`
  String get textContinue {
    return Intl.message(
      'Continuar',
      name: 'textContinue',
      desc: '',
      args: [],
    );
  }

  /// `Editar informações pessoais`
  String get textEditPersonalInformation {
    return Intl.message(
      'Editar informações pessoais',
      name: 'textEditPersonalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Atualizar informações`
  String get textUpdateInformation {
    return Intl.message(
      'Atualizar informações',
      name: 'textUpdateInformation',
      desc: '',
      args: [],
    );
  }

  /// `Informações atualizadas com sucesso!`
  String get textInformationChangedSuccessfully {
    return Intl.message(
      'Informações atualizadas com sucesso!',
      name: 'textInformationChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Não foi possível atualizar as informações!`
  String get textUnableToChangeInformation {
    return Intl.message(
      'Não foi possível atualizar as informações!',
      name: 'textUnableToChangeInformation',
      desc: '',
      args: [],
    );
  }

  /// `Adicionar Local`
  String get textAddLocation {
    return Intl.message(
      'Adicionar Local',
      name: 'textAddLocation',
      desc: '',
      args: [],
    );
  }

  /// `Opções`
  String get textOptions {
    return Intl.message(
      'Opções',
      name: 'textOptions',
      desc: '',
      args: [],
    );
  }

  /// `Estamos processando os detalhes do estabelecimento para tornar sua experiência ainda mais incrível. Em breve, ele estará visível para todos!`
  String get textSuccessSaveLocation {
    return Intl.message(
     'Estamos processando os detalhes do estabelecimento para tornar sua experiência ainda mais incrível. Em breve, ele estará visível para todos!',
      name: 'textSuccessSaveLocation',
      desc: '',
      args: [],
    );
  }

  /// `Explorar outros locais`
  String get textExploreOtherLocations {
    return Intl.message(
      'Explorar outros locais',
      name: 'textExploreOtherLocations',
      desc: '',
      args: [],
    );
  }

  /// `Funcionalidade disponível em breve`
  String get textFeatureAvailableSoon {
    return Intl.message(
      'Funcionalidade disponível em breve',
      name: 'textFeatureAvailableSoon',
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

  /// `Digite o nome de um local para buscar.`
  String get textTypeTheNameOfAPlaceToSearch {
    return Intl.message(
      'Digite o nome de um local para buscar.',
      name: 'textTypeTheNameOfAPlaceToSearch',
      desc: '',
      args: [],
    );
  }

  /// `Sua senha deve conter 8 caracteres ou mais,\n incluindo letras, números e símbolos.`
  String get textPasswordSpecifications {
    return Intl.message(
      'Sua senha deve conter 8 caracteres ou mais,\n incluindo letras, números e símbolos.',
      name: 'textPasswordSpecifications',
      desc: '',
      args: [],
    );
  }

  /// `Selecione uma foto antes de salvar.`
  String get textSelectAPicture {
    return Intl.message(
      'Selecione uma foto antes de salvar.',
      name: 'textSelectAPicture',
      desc: '',
      args: [],
    );
  }

  /// `Cadastro realizado com sucesso!`
  String get textRegisterSuccess {
    return Intl.message(
      'Cadastro realizado com sucesso!',
      name: 'textRegisterSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Você será redirecionado para a página de login.`
  String get textRegisterSuccessMessage {
    return Intl.message(
      'Você será redirecionado para a página de login.',
      name: 'textRegisterSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Como você se sentiu nesse local?`
  String get textHowDoYouFeelAboutThisPlace {
    return Intl.message(
      'Como você se sentiu nesse local?',
      name: 'textHowDoYouFeelAboutThisPlace',
      desc: '',
      args: [],
    );
  }

  /// `Como as pessoas se sentiram nesse local:`
  String get textHowDoPeopleFellAboutThisPlace {
    return Intl.message(
      'Como as pessoas se sentiram nesse local:',
      name: 'textHowDoPeopleFellAboutThisPlace',
      desc: '',
      args: [],
    );
  }

  /// `O que estão falando sobre esse local:`
  String get textWhatPeopleAreTalkingAboutThisPlace {
    return Intl.message(
      'O que estão falando sobre esse local:',
      name: 'textWhatPeopleAreTalkingAboutThisPlace',
      desc: '',
      args: [],
    );
  }

  /// `Escolha uma classificação para este local!`
  String get textChooseAClassification {
    return Intl.message(
      'Escolha uma classificação para este local!',
      name: 'textChooseAClassification',
      desc: '',
      args: [],
    );
  }

  /// `Seguro para pessoas LGBTQIA+`
  String get textSafeForLGBT {
    return Intl.message(
      'Seguro para pessoas LGBTQIA+',
      name: 'textSafeForLGBT',
      desc: '',
      args: [],
    );
  }

  /// `Não recomendo este lugar`
  String get textDontRecomendThisPlace {
    return Intl.message(
      'Não recomendo este lugar',
      name: 'textDontRecomendThisPlace',
      desc: '',
      args: [],
    );
  }

  /// `Alguns problemas aconteceram`
  String get textSomeProblemsHappend {
    return Intl.message(
      'Alguns problemas aconteceram',
      name: 'textSomeProblemsHappend',
      desc: '',
      args: [],
    );
  }

  /// `Escolha uma classificação para esse lugar levando em conta as qualidades listadas!`
  String get textChooseAClassificationForThisPlace {
    return Intl.message(
      'Escolha uma classificação para esse lugar levando em conta as qualidades listadas!',
      name: 'textChooseAClassificationForThisPlace',
      desc: '',
      args: [],
    );
  }

  /// `Você pode nos dar mais detalhes?`
  String get textCanYouGiveMoreDetails {
    return Intl.message(
      'Você pode nos dar mais detalhes?',
      name: 'textCanYouGiveMoreDetails',
      desc: '',
      args: [],
    );
  }

  /// `Texto copiado!`
  String get textShareUserReview {
    return Intl.message(
      'Texto copiado!',
      name: 'textShareUserReview',
      desc: '',
      args: [],
    );
  }

  /// `Não encontrou o local que estava procurando?`
  String get textDontFoundThePlace {
    return Intl.message(
      'Não encontrou o local que estava procurando?',
      name: 'textDontFoundThePlace',
      desc: '',
      args: [],
    );
  }

  /// `Crie ele aqui.`
  String get textCreateHere {
    return Intl.message(
      'Crie ele aqui.',
      name: 'textCreateHere',
      desc: '',
      args: [],
    );
  }

  /// `Usuário deletado com sucesso`
  String get textDeleteUser {
    return Intl.message(
      'Usuário deletado com sucesso',
      name: 'textDeleteUser',
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

  /// `Confirme sua senha`
  String get textConfirmPassword {
    return Intl.message(
      'Confirme sua senha',
      name: 'textConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Insira sua senha novamente`
  String get textReenterPassword1_0 {
    return Intl.message(
      'Insira sua senha novamente',
      name: 'textReenterPassword1_0',
      desc: '',
      args: [],
    );
  }

  /// `para continuar.`
  String get textReenterPassword1_1 {
    return Intl.message(
      'para continuar.',
      name: 'textReenterPassword1_1',
      desc: '',
      args: [],
    );
  }

  /// `Confirme sua senha atual`
  String get textConfirmCurrentPassword {
    return Intl.message(
      'Confirme sua senha atual',
      name: 'textConfirmCurrentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Não foi possível confirmar sua senha!`
  String get textErrorConfirmPassword {
    return Intl.message(
      'Não foi possível confirmar sua senha!',
      name: 'textErrorConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `A maioria das pessoas\n considera esse local seguro\n para comunidade LGBTQIA+`
  String get textMostPeopleSafePlace {
    return Intl.message(
      'A maioria das pessoas\n considera esse local seguro\n para comunidade LGBTQIA+',
      name: 'textMostPeopleSafePlace',
      desc: '',
      args: [],
    );
  }

  /// `Algumas pessoas\n reportaram problemas\n associados a esse local para\n comunidade LGBTQIA+`
  String get textMostPeopleAlertPlace {
    return Intl.message(
      'Algumas pessoas\n reportaram problemas\n associados a esse local para\n comunidade LGBTQIA+',
      name: 'textMostPeopleAlertPlace',
      desc: '',
      args: [],
    );
  }

  /// `Local não recomendado.\n A maioria das pessoas não\n considera esse local seguro\n para comunidade LGBTQIA+`
  String get textMostPeopleDangerPlace {
    return Intl.message(
      'Local não recomendado.\n A maioria das pessoas não\n considera esse local seguro\n para comunidade LGBTQIA+',
      name: 'textMostPeopleDangerPlace',
      desc: '',
      args: [],
    );
  }

  /// `Avatar alterado com sucesso!`
  String get textAvatarSuccessUpated {
    return Intl.message(
      'Avatar alterado com sucesso!',
      name: 'textAvatarSuccessUpated',
      desc: '',
      args: [],
    );
  }

  /// `Não foi possível alterar o avatar!`
  String get textFailedToUpdateAvatar {
    return Intl.message(
      'Não foi possível alterar o avatar!',
      name: 'textFailedToUpdateAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Não foi possível salvar o local! Tente novamente mais tarde.`
  String get textFailedToSaveLocation {
    return Intl.message(
      'Não foi possível salvar o local! Tente novamente mais tarde.',
      name: 'textFailedToSaveLocation',
      desc: '',
      args: [],
    );
  }

  /// `Sucesso!`
  String get textSafeDialogTypeSucces {
    return Intl.message(
      'Sucesso!',
      name: 'textSafeDialogTypeSucces',
      desc: '',
      args: [],
    );
  }

  /// `Atenção!`
  String get textSafeDialogTypeAlert {
    return Intl.message(
      'Atenção!',
      name: 'textSafeDialogTypeAlert',
      desc: '',
      args: [],
    );
  }

  /// `Erro!`
  String get textSafeDialogTypeError {
    return Intl.message(
      'Erro!',
      name: 'textSafeDialogTypeError',
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

  /// `Configurações`
  String get textAddLocationTitle {
    return Intl.message(
      'Configurações',
      name: 'textAddLocationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Adicionar Local`
  String get textAddLocationSubTitle {
    return Intl.message(
      'Adicionar Local',
      name: 'textAddLocationSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Nome do local`
  String get textAddLocationNameTextFieldTitle {
    return Intl.message(
      'Nome do local',
      name: 'textAddLocationNameTextFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `CEP`
  String get textAddLocationCepFieldTitle {
    return Intl.message(
      'CEP',
      name: 'textAddLocationCepFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `Endereço`
  String get textAddLocationAddressFieldTitle {
    return Intl.message(
      'Endereço',
      name: 'textAddLocationAddressFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tipo de local`
  String get textAddTypeLocationFieldTitle {
    return Intl.message(
      'Tipo de local',
      name: 'textAddTypeLocationFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `Adicionar Foto (opcional)`
  String get textAddLocationPhotoFieldTitle {
    return Intl.message(
      'Adicionar Foto (opcional)',
      name: 'textAddLocationPhotoFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `ADICIONAR LOCAL`
  String get textAddLocationConfirm {
    return Intl.message(
      'ADICIONAR LOCAL',
      name: 'textAddLocationConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Local adicionado com sucesso!`
  String get textAddLocationSuccess {
    return Intl.message(
      'Local adicionado com sucesso!',
      name: 'textAddLocationSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Mensagem enviada com sucesso!`
  String get textContactMessageSentSuccess {
    return Intl.message(
      'Mensagem enviada com sucesso!',
      name: 'textContactMessageSentSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Bar`
  String get textAddLocationTypePub {
    return Intl.message(
      'Bar',
      name: 'textAddLocationTypePub',
      desc: '',
      args: [],
    );
  }

  /// `Restaurante`
  String get textAddLocationTypeRestaurant {
    return Intl.message(
      'Restaurante',
      name: 'textAddLocationTypeRestaurant',
      desc: '',
      args: [],
    );
  }

  /// `Local público`
  String get textAddLocationTypePublicLocation {
    return Intl.message(
      'Local público',
      name: 'textAddLocationTypePublicLocation',
      desc: '',
      args: [],
    );
  }

  /// `Casa noturna`
  String get textAddLocationTypeNightClub {
    return Intl.message(
      'Casa noturna',
      name: 'textAddLocationTypeNightClub',
      desc: '',
      args: [],
    );
  }

  /// `Ex: Bar santa maria`
  String get textAddLocationExample {
    return Intl.message(
      'Ex: Bar santa maria',
      name: 'textAddLocationExample',
      desc: '',
      args: [],
    );
  }

  /// `Ex: 04.553-434`
  String get textAddLocationCepExample {
    return Intl.message(
      'Ex: 04.553-434',
      name: 'textAddLocationCepExample',
      desc: '',
      args: [],
    );
  }

  /// `Ex: Rua Clodomiro`
  String get textAddLocationAddress {
    return Intl.message(
      'Ex: Rua Clodomiro',
      name: 'textAddLocationAddress',
      desc: '',
      args: [],
    );
  }

  /// `Abrir Permissões`
  String get textOpenPermissions {
    return Intl.message(
      'Abrir Permissões',
      name: 'textOpenPermissions',
      desc: '',
      args: [],
    );
  }

  /// `Nos conte como podemos te ajudar`
  String get textContacHowToHelpYou {
    return Intl.message(
      'Nos conte como podemos te ajudar',
      name: 'textContacHowToHelpYou',
      desc: '',
      args: [],
    );
  }

  /// `Não foi possível realizar a ação.`
  String get textContacActionError {
    return Intl.message(
      'Não foi possível realizar a ação.',
      name: 'textContacActionError',
      desc: '',
      args: [],
    );
  }

  /// `Senha alterada com sucesso!`
  String get textPasswordSuccessChanged {
    return Intl.message(
      'Senha alterada com sucesso!',
      name: 'textPasswordSuccessChanged',
      desc: '',
      args: [],
    );
  }

  /// `Não foi possível alterar sua senha!`
  String get textPasswordFailureChanged {
    return Intl.message(
      'Não foi possível alterar sua senha!',
      name: 'textPasswordFailureChanged',
      desc: '',
      args: [],
    );
  }

  /// `O nome não pode ter menos que 3 letras.`
  String get textRegisterValidateUserName {
    return Intl.message(
      'O nome não pode ter menos que 3 letras.',
      name: 'textRegisterValidateUserName',
      desc: '',
      args: [],
    );
  }

  /// `Atualizar senha`
  String get textUpdatePassword {
    return Intl.message(
      'Atualizar senha',
      name: 'textUpdatePassword',
      desc: '',
      args: [],
    );
  }

  /// `Seu e-mail atual é`
  String get textYourCurrentEmailIs {
    return Intl.message(
      'Seu e-mail atual é',
      name: 'textYourCurrentEmailIs',
      desc: '',
      args: [],
    );
  }

  /// `Qual será o novo endereço de e-mail?`
  String get textWhatWillBeYourEmailAddress {
    return Intl.message(
      'Qual será o novo endereço de e-mail?',
      name: 'textWhatWillBeYourEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Ocorreu um erro inesperado!`
  String get textCriticalErrorPageTitle {
    return Intl.message(
      'Ocorreu um erro inesperado!',
      name: 'textCriticalErrorPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Encontramos uma situação inesperada na aplicação. Estamos trabalhando o mais rápido possivel para corrigi-la!`
  String get textCriticalErrorPageBody {
    return Intl.message(
      'Encontramos uma situação inesperada na aplicação. Estamos trabalhando o mais rápido possivel para corrigi-la!',
      name: 'textCriticalErrorPageBody',
      desc: '',
      args: [],
    );
  }

  /// `Reportar erro`
  String get textCriticalErrorPageGoToReport {
    return Intl.message(
      'Reportar erro',
      name: 'textCriticalErrorPageGoToReport',
      desc: '',
      args: [],
    );
  }

  /// `CEP inválido`
  String get textErrorZipCode {
    return Intl.message(
      'CEP inválido',
      name: 'textErrorZipCode',
      desc: '',
      args: [],
    );
  }

  /// `Digite apenas números`
  String get textInfoZipCode {
    return Intl.message(
      'Digite apenas números',
      name: 'textInfoZipCode',
      desc: '',
      args: [],
    );
  }

  /// `Deseja desativar sua conta?`
  String get textWantDeactivateAccount {
    return Intl.message(
      'Deseja desativar sua conta?',
      name: 'textWantDeactivateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Você pode restaurar sua conta em até 30 dias após a desativação se ela foi desativada por engano ou incorretamente.`
  String get textDeactivateAccountWarnning {
    return Intl.message(
      'Você pode restaurar sua conta em até 30 dias após a desativação se ela foi desativada por engano ou incorretamente.',
      name: 'textDeactivateAccountWarnning',
      desc: '',
      args: [],
    );
  }

  /// `Desativar conta`
  String get textDeactivateAccount {
    return Intl.message(
      'Desativar conta',
      name: 'textDeactivateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Conta desativada com sucesso!`
  String get textDeactivatedAccountSuccess {
    return Intl.message(
      'Conta desativada com sucesso!',
      name: 'textDeactivatedAccountSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Não foi possível desativar sua conta, tente novamente mais tarde.`
  String get textNotPossibleDeativateAccount {
    return Intl.message(
      'Não foi possível desativar sua conta, tente novamente mais tarde.',
      name: 'textNotPossibleDeativateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Alterar`
  String get textChange {
    return Intl.message(
      'Alterar',
      name: 'textChange',
      desc: '',
      args: [],
    );
  }

  /// `Para exibir os lugares próximos, por favor libere o acesso a localização.`
  String get textDeniedPermissionLocation {
    return Intl.message(
      'Para exibir os lugares próximos, por favor libere o acesso a localização.',
      name: 'textDeniedPermissionLocation',
      desc: '',
      args: [],
    );
  }

  /// `O serviço de localização está desativado. Para exibir lugares próximos, habilite essa função.`
  String get textDeniedServiceLocation {
    return Intl.message(
      'O serviço de localização está desativado. Para exibir lugares próximos, habilite essa função.',
      name: 'textDeniedServiceLocation',
      desc: '',
      args: [],
    );
  }

  /// `User denied permissions to access the device's location.`
  String get textErrorDeniedPermissionLocation {
    return Intl.message(
      'User denied permissions to access the device\'s location.',
      name: 'textErrorDeniedPermissionLocation',
      desc: '',
      args: [],
    );
  }

  /// `The location service on the device is disabled.`
  String get textErrorDeniedServiceLocation {
    return Intl.message(
      'The location service on the device is disabled.',
      name: 'textErrorDeniedServiceLocation',
      desc: '',
      args: [],
    );
  }

  /// `Permitir o app ‘IS IT SAFE?’ acesse a sua localização?`
  String get textLocationDialogTitle {
    return Intl.message(
      'Permitir o app ‘IS IT SAFE?’ acesse a sua localização?',
      name: 'textLocationDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sua localização é utilizada  para customizar sua experiência e oferecer opções relevantes perto de você.`
  String get textLocationDialogcontent {
    return Intl.message(
      'Sua localização é utilizada  para customizar sua experiência e oferecer opções relevantes perto de você.',
      name: 'textLocationDialogcontent',
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
