import 'package:flutter/cupertino.dart';

enum PageRouteDirection {
  leftInRightOut,
  rightInLeftOut,
  topInBottomOut,
  bottomInTopOut,
}

extension CommonPageRouteAnination on Object {
  Future pushPage(BuildContext context, StatefulWidget nextPage,
      [PageRouteDirection direction = PageRouteDirection.leftInRightOut]) {
    return Navigator.of(context).push(pageRouteBuilder(context, nextPage));
  }

  Future pushAndRemoveUntilPage(BuildContext context, StatefulWidget nextPage, RoutePredicate predicate,
      [PageRouteDirection direction = PageRouteDirection.leftInRightOut]) {
    return Navigator.of(context).pushAndRemoveUntil(pageRouteBuilder(context, nextPage), predicate);
  }

  PageRouteBuilder pageRouteBuilder(BuildContext context, StatefulWidget nextPage,
      [PageRouteDirection direction = PageRouteDirection.leftInRightOut]) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => (nextPage),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
        switch (direction) {
          case PageRouteDirection.leftInRightOut:
            begin = const Offset(1.0, 0.0);
            break;
          case PageRouteDirection.rightInLeftOut:
            begin = const Offset(-1.0, 0.0);
            break;
          case PageRouteDirection.topInBottomOut:
            begin = const Offset(0.0, 1.0);
            break;
          case PageRouteDirection.bottomInTopOut:
            begin = const Offset(0.0, -1.0);
        }
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
