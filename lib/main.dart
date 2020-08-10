import 'package:cupertinostore/app.dart';
import 'package:cupertinostore/model/app_state_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<AppStateModel>(
    create: (_) => AppStateModel()..loadProduct(),
      child: CupertinoStoreApp()));
}

