import 'dart:async';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';

class NavigationBloc extends SafeBloC {
 NavigationBlocBloc() : super(const NavigationBlocState.verifyIndex(index: 0)) {
   
   
    on<ResetPageView>(
      (event, emit) => emit(
        const NavigationBlocState.verifyIndex(index: 0),
      ),
    );
  

  // late PageController pageController = PageController();

  Stream<NavigationBlocState> _mapHandleAddIndex(int index) async* {
    final int value = index + 1;
    doNavigation(value);
    yield NavigationBlocState.verifyIndex(index: value);
  }

  Stream<NavigationBlocState> _mapHandleSubtractIndex(int index) async* {
    final int value = index - 1;
    doNavigation(value);
    yield NavigationBlocState.verifyIndex(index: value);
  }

  Stream<NavigationBlocState> _mapHandleSelectedIndex(int index) async* {
    doNavigation(index);
    yield NavigationBlocState.verifyIndex(index: index);
  }

  void doNavigation(int index) {
    switch (index) {
      case 0:
        Modular.to.navigate(AppRoutes.centralHome);
        break;
      case 1:
        Modular.to.navigate(AppRoutes.centralClasses, arguments: {
          'pillar': PillarEntity.empty(),
          'listPillar': null,
        });
        break;
      case 2:
        Modular.to.navigate(AppRoutes.centralSOS);
        break;
      case 3:
        Modular.to.navigate(AppRoutes.centralFavorite);
        break;
      case 4:
        Modular.to.navigate(AppRoutes.centralProfile);
        break;
    }
  }
  }
}
