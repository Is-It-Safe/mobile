import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';

//TODO concluir SafeState
abstract class SafeState<T extends StatefulWidget, B extends SafeBloC>
    extends State<T> {
  late B bloc;

  @override
  void initState() {
    super.initState();
    bloc = B as B;
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
