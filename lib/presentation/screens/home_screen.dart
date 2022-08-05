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
          /* 
                "==" to check / compare the value
                "is" to check / compare the data type
              */
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
                  'Internet disconnected!',
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
