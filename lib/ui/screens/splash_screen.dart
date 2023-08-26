import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calender/bloc/calendar_bloc.dart';
import 'package:flutter_calender/di/get_it.dart';
import 'package:flutter_calender/ui/screens/calender_screen.dart';
import 'package:flutter_calender/utilities/const_colors.dart';
import 'package:flutter_calender/ui/widgets/custom_animate_icon.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToScreen();
  }

  Future _navigateToScreen() {
    return Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => locator.get<CalendarBloc>(),
              child: const CalenderScreen(),
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          SizedBox(
            height: 70,
            width: 70,
            child: CustomAnimatedIcon(
              color: AppColors.whiteColor,
              animateIcon: AnimateIcons.calendar,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Calendar',
            style: TextStyle(
              fontSize: 32,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
