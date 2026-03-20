import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'services/note_service.dart';

class NoteTakingApp extends StatelessWidget {
  const NoteTakingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NoteService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Note Taking App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black, displayColor: Colors.black),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
