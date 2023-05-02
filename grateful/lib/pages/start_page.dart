import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  double? _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _titleWidget(),
                Image.asset(
                  'assets/images/grateful_cat.png',
                  height: _deviceHeight! * 0.25,
                  width: _deviceWidth! * 0.25,
                ),
                _startButton(),
                _versionWidget(),
              ],
            )
          )
        )
      ),
    );
  }

  Widget _titleWidget() {
    var colorScheme = Theme.of(context).colorScheme;
    return Text(
      "Grateful",
      style: TextStyle(
        color: colorScheme.primary,
        fontSize: 30,
        fontWeight: FontWeight.w800,
        letterSpacing: 2,
      )
    );
  }

  Widget _startButton() {
    return MaterialButton(
      onPressed: _startGratitude,
      minWidth: _deviceWidth! * 0.70,
      height: _deviceHeight! * 0.06,
      color: Theme.of(context).colorScheme.primary,
      child: Text(
        "Start",
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 2,
        )
      ),
    );
  }

  void _startGratitude() async {
    Navigator.popAndPushNamed(context, 'home');
  }
  
  Widget _versionWidget() {
    return Column(
      children: [
        Text(
          "Alpha",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          )
        ),
        Text(
          "v0.1.0",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary, 
            letterSpacing: 2,
          )
        ),
      ],
    );
  }

}
