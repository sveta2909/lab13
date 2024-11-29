@@ -1,18 +1,27 @@
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'note_provider.dart';
import 'home.dart';

void main() {
runApp(MyApp());
runApp(
ChangeNotifierProvider(
create: (context) => NoteProvider(),
child: MyApp(),
),
);
}

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Notes App',
theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen)),
theme: ThemeData(
colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
),
home: HomeScreen(),
debugShowCheckedModeBanner: false,
);
}
}
}