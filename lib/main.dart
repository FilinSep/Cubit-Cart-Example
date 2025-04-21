import 'package:cartexample/cubit/cart_cubit.dart';
import 'package:cartexample/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Cubit Cart Example',
      theme: ThemeData.light(),
      home: BlocProvider(
        create: (context) => CartCubit()..getPizzas(),
        child: const HomePage(),
      ),
    );
  }
}
