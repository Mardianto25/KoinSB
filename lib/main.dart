import 'package:flutter/material.dart';
import 'package:flutter_base/splashscreen.dart';
import 'package:flutter_base/ui/user_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MaterialApp(home: SplashScreen()));
} 


  

class Main extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: TextTheme(
              title:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          primaryColor: Color(0xff27a08b),
          primarySwatch: Colors.teal,
          accentColor: Colors.teal,
          fontFamily: 'NeoSansW1g'),
      home: Scaffold(
        body: Container(
          child: UserWidget(),
        ),
      ),
    );
  }
}
