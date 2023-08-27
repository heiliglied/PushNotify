import 'package:flutter/cupertino.dart';

class CommonRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  PageRoute? checkPageRoute(Route<dynamic>? route) {
    return (route is PageRoute) ? route : null;
  }

  @override
  void didPop(Route route, Route? previousRoute) {

  }

  @override
  void didPush(Route route, Route? previousRoute) {

  }

  @override
  void didRemove(Route route, Route? previousRoute) {

  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {

  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {

  }

  @override
  void didStopUserGesture() {

  }


}