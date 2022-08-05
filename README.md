# bloc_second_part

Bloc (Business Logic Components Pattern)

Contents
       First Chapter -
Introduction of bloc
Events and States
Builders, Listeners, Consumers
Our first bloc application for demo purpose ( Internet bloc )

       Second Chapter -
Cubits
States with enum

       Third Chapter -
Form validation using bloc

       Fourth Chapter -
Phone authentication using bloc
      
       Fifth Chapter -
Generated routes in flutter 

* Second Chapter -
In the first chapter we learned that the bloc received the event and sent the state according to that received event.
In that case both events and states are represented by the Streams.

Cubits -
It is a subset of the bloc package.
A Cubit is similar to Bloc but in Cubit event streams are not there, only state streams are presented.
So in that case we changed the event into functions, Otherwise cubits is similar to bloc. 
Diagram is given below :




Let’s create an internet bloc !

Step 1 -
Add Dependencies In Your Pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: 1.0.5
  google_fonts: 2.2.0
  bloc: 8.0.3
  flutter_bloc: 8.0.1
  connectivity_plus: 2.3.5


Step 2 - 
Initialized the bloc In main.dart
Code :
import 'package:bloc_second_part/application/cubits/internet_cubits.dart';
import 'package:bloc_second_part/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InternetCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}


Step 3 -
Create the home_screen.dart file.
Code :
import 'package:bloc_second_part/application/cubits/internet_cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: BlocConsumer<InternetCubit, InternetState>(
          builder: (context, state) {
          if (state == InternetState.Available) {
            return Text('Connected!',
                textScaleFactor: 1.0,
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                ));
          } else if (state == InternetState.Unavailable) {
            return Text('Disconnected!',
                textScaleFactor: 1.0,
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                ));
          } else {
            return Text('Loading...',
                textScaleFactor: 1.0,
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                ));
          }
        }, listener: (context, state) {
          if (state == InternetState.Available) {
            ScaffoldMessenger.of(context).showSnackBar(
              // ignore: prefer_const_constructors
              SnackBar(
                content: const Text('Internet connected!'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state == InternetState.Unavailable) {
            ScaffoldMessenger.of(context).showSnackBar(
              // ignore: prefer_const_constructors
              SnackBar(
                content: const Text(
                  'Internet connected!',
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        })),
      ),
    );
  }
}


Step 4 -
Create the cubit section in this step.

Create the internet_cubits.dart file.
Code :
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// ignore: constant_identifier_names
enum InternetState { Initial, Available, Unavailable }

class InternetCubit extends Cubit<InternetState> {
  Connectivity connectivity = Connectivity();
  // ignore: unused_field
  StreamSubscription? _streamSubscription;

  InternetCubit() : super(InternetState.Initial) {
    _streamSubscription = connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        emit(InternetState.Available);
      } else {
        emit(InternetState.Unavailable);
      }
    });
  }

@override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}

>>>>>>>>>>>>>>>>>>>BLOC SECOND CHAPTER COMPLETED>>>>>>>>>>>>>>>>>>>>

