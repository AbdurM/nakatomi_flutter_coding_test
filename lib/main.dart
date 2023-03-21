import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nakatomi_flutter_coding_test/constants/string_constants.dart';
import 'package:nakatomi_flutter_coding_test/service_locator.dart';
import 'package:nakatomi_flutter_coding_test/services/container_state_service/container_state.dart';
import 'package:nakatomi_flutter_coding_test/services/container_state_service/i_container_state_service.dart';

void main() {
  initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    _containerStateService = serviceLocator.get<IContainerStateService>();
  }

  late IContainerStateService _containerStateService;

  double height = 72; // FIGURE OUT THIS VALUE
  double width = 72; // FIGURE OUT THIS VALUE
  int maxLines = 1; // FIGURE OUT THIS VALUE

  final textStyle = const TextStyle(fontSize: 13, color: Colors.white);

  String actualText = '';

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () async {
        for (var i = 0; i < StringConstants.fullText.length; i++) {
          _resizeContainer(StringConstants.fullText[i]);
          await Future<void>.delayed(const Duration(milliseconds: 250));
        }
      },
    );
    super.initState();
  }

  void _resizeContainer(String text) {
    final textToDisplay = actualText + text;
    maxLines = _calculateNumberOfLines(textToDisplay, width, textStyle);
    final containerState =
        _containerStateService.getContainerState(width, height, maxLines);

    setState(() {
      switch (containerState) {
        case ContainerState.one:
          width = 72;
          break;
        case ContainerState.two:
          width = 90;
          break;
        case ContainerState.three:
          height = 90;
          break;
        case ContainerState.four:
          width = 196;
          break;
        case ContainerState.none:
          break;
      }

      actualText = textToDisplay;
    });
  }

  int _calculateNumberOfLines(
    String text,
    double fixedWidth,
    TextStyle textStyle,
  ) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: textStyle, // Replace with your desired font size
      ),
      textDirection: TextDirection.ltr,
      maxLines: null, // Unlimited height
    )..layout(
        maxWidth: fixedWidth,
      );

    return textPainter.computeLineMetrics().length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(microseconds: 500),
          padding: const EdgeInsets.all(8.0),
          constraints: BoxConstraints(
              minHeight: 72,
              minWidth: 72,
              maxWidth: width + 10,
              maxHeight: height + 10), // For border
          decoration: BoxDecoration(
            color: Colors.greenAccent.shade700,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 4.0),
                constraints: const BoxConstraints(maxWidth: 300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      child: Text(
                        'AUTHOR',
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(fontSize: 9, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Text(actualText,
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
