import 'package:flutter/material.dart';

//TODO concluir SafeState
abstract class SafeState<T extends StatefulWidget, B extends Object>
    extends State<T> {
  // final TBind _scope = Modular.get<TBind>();

  // TBind get bloc => _scope;

  @override
  void initState() {
    //Add init here
    super.initState();
  }

  @override
  void dispose() {
    //Add dispose here
    super.dispose();
  }
}
