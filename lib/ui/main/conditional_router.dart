import 'dart:collection';

import 'package:chisco/ui/auth/authScreen.dart';
import 'package:chisco/ui/auth/auth_controller.dart';
import 'package:chisco/ui/home/home_controller.dart';
import 'package:chisco/ui/home/home_screen.dart';
import 'package:chisco/ui/main/global_variable.dart';
import 'package:chisco/ui/splash/splash_controller.dart';
import 'package:chisco/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/const.dart';

///in pwa we need Check url or routes when change routes
///we define two type of route [public] and [private]
///[public] is routes that we can access or enter without Tokens
///[private] is routes that we need to Token to enter it such as [Home] [Cooler] [Power]
///also we have isUserLogin that it changes when user logout or login
///if isUserLogin is false we cant access to private routes
///if its true we can

class ConditionalRouter extends MapMixin<String, WidgetBuilder> {
  final Map<String, WidgetBuilder> public;
  final Map<String, WidgetBuilder> private;

  ConditionalRouter({required this.public, required this.private});

  @override
  WidgetBuilder? operator [](Object? key) {

    if (public.containsKey(key)) {
      print(GlobalVariable.isUserLogin);
      if(GlobalVariable.isUserLogin==null){
        return (ctx) => ChangeNotifierProvider(
          create: (context) => SplashController(context),
          child: const SplashScreen(),
        );
      }
      if (GlobalVariable.isUserLogin==true &&  key == loginPage) {
        print('Login Page Public If');
        return (ctx) => ChangeNotifierProvider(
              create: (context) => HomeController(context),
              child: const HomeScreen(),
            );
      }
      print('Public Keyyyyy');
      print(public[key]);
      return public[key];
    }
    if (private.containsKey(key)) {
      if(GlobalVariable.isUserLogin==null){

        return  (ctx) => ChangeNotifierProvider(
          create: (context) => SplashController(context),
          child: const SplashScreen(),
        );

      }else {
        print("#################");
        print("called3");
        print(key);
        if (GlobalVariable.isUserLogin==true){
          
          return private[key];
        }else{
          return (ctx) => ChangeNotifierProvider(
            create: (context) => AuthController(context),
            child: const AuthScreen(),
          );
        }

      }


    }

    return null;
  }

  @override
  void operator []=(key, value) {}

  @override
  void clear() {}

  @override
  Iterable<String> get keys {
    final set = <String>{};
    set.addAll(public.keys);
    set.addAll(private.keys);
    return set;
  }

  @override
  WidgetBuilder? remove(Object? key) {
    return public[key] ?? private[key];
  }
}
