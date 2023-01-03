abstract class SafeBloC {
  ///Abertura da pagina
  Future<void> init();

  ///Fechamento da pagina
  Future<void> dispose();

  ///Equivalente a onResume() no Android ou viewDidAppear() no iOS.
  void onFocusGained() {}

  ///Equivalente a onPause() no Android ou viewDidDisappear() em ' 'iOS.',
  void onFocusLost() {}

  ///Isso significa que o widget agora está visível em seu aplicativo
  void onVisibilityGained() {}

  ///Isso significa que o widget não está mais visível em seu aplicativo
  void onVisibilityLost() {}

  ///Significa, que o usuário voltou para seu aplicativo ou religou a tela do dispositivo enquanto seu widget estava
  void onForegroundGained() {}

  ///Segundo Plano ao abrir outro aplicativo ou desligar o dispositivo
  void onForegroundLost() {}
}
