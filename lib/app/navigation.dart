import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Navigation extends InheritedWidget {
  const Navigation({
    Key key,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  static Navigation of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Navigation>();

  @override
  bool updateShouldNotify(Navigation old) => false;

  Future<T> _push<T>(BuildContext context, WidgetBuilder builder) =>
      Navigator.push(context, MaterialPageRoute(builder: builder));

  void _pop<T>(BuildContext context, T result) =>
      Navigator.pop(context, result);
}
