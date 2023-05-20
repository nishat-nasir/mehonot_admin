import 'package:auto_route/auto_route.dart';

import '../../../presentation/template/template.dart';
import '../sets/app_state.dart';
import '../states/nav_state.dart';

class NavigationMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    if (action is NavigateToAction) {
      return _navigate(store, action);
      // } else if (action is ShowPopupAction) {
      //   return _showPopup(store.state.navigationState, action);
    } else if (action is DismissPopupAction) {
      return _dismissPopup(store.state.navigationState, action);
    } else {
      return next(action);
    }
  }

  // 의도적으로 next() 하지 않음
  void _navigate(Store<AppState> store, NavigateToAction action) {
    // if (action.replace) {
    //   appRouter.replace(action.to);
    //   return;
    // }
    //
    // appRouter.navigate(action.to);
    var history = store.state.navigationState.history;
    var pages = history.where((v) => v.isPage).map((v) => v.name).toList();
    if (pages.contains(action.to.routeName)) {
      appRouter.popUntil(ModalRoute.withName(action.to.routeName));
    } else {
      _navigateTo(store, action);
    }
  }

  Future<void> _navigateTo(
      Store<AppState> store, NavigateToAction action) async {
    _navigateTo2(store, action);
  }

  //
  Future<void> _navigateTo2(
      Store<AppState> store, NavigateToAction action) async {
    var navState = store.state.navigationState;
    _dismissAllPopups(navState);
    _pushOrReplaceNamed(action.to, action);
  }

  //
  void _pushOrReplaceNamed(PageRouteInfo to, NavigateToAction action) async {
    if (action.replace) {
      // appRouter.replace(to);
      await appRouter.pop();
      appRouter.push(to);
    } else {
      appRouter.push(to);
    }
  }

  void _dismissPopup(NavigationState state, DismissPopupAction action) {
    if (action.all) {
      _dismissAllPopups(state);
    } else {
      if (state.history.isNotEmpty && !state.history.last.isPage) {
        appRouter.pop(action.result);
      }
    }
  }

  // 현재 페이지 위에 떠 있는 팝업 닫기
  void _dismissAllPopups(NavigationState state) {
    if (state.history.isNotEmpty && !state.history.last.isPage) {
      var popupCount = state.history.length -
          state.history.lastIndexWhere((i) => i.isPage) -
          1;

      for (var i = 0; i < popupCount; i++) {
        appRouter.popForced();
      }
    }
  }
}
