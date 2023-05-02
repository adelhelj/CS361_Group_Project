import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

const String gratitudeInfo = "Practicing Gratitude is Good ❤️";
const String writingInfo = "Writing everyday is Good ✍🏿🧠";

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  double? _deviceHeight, _deviceWidth;
  
  String _quoteText = "Tap the icon to get inspired";
  String _quoteAuthor = "Grateful Team";

  final Dio _dio = Dio();
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body:  Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ExpandedTile(title: gratitudeInfo),
              const Text(
                "🫶🏿",
                style: TextStyle(
                  fontSize: 30,
                )
              ),
              ExpandedTile(title: writingInfo),
              SizedBox(height: _deviceHeight! *0.05),
              _paddedQuoteBanner(context, colorScheme),
              IconButton(
                iconSize: 40.0,
                color: colorScheme.onPrimaryContainer,
                onPressed: () async {
                  await _getQuote();
                }, 
                icon: const Icon(Icons.touch_app),
              ),
            ],
          ),
        ),
      )
    );
  }

  Padding _paddedQuoteBanner(BuildContext context, ColorScheme colorScheme) {
    return Padding(
            padding: EdgeInsets.all(_padding(context)),
            child: Text(
              "$_quoteText\n-$_quoteAuthor",
              softWrap: true,
              style: TextStyle(
                color: colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w200,
              ),
            ),
          );
  }

  double _padding(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return MediaQuery.of(context).size.width * 0.05;
    } else {
      return MediaQuery.of(context).size.width * 0.03;
    }
  }

  Future<void> _getQuote() async {
    const String apiUrl = "http://10.0.2.2:5000/quotes";
    var response = await _dio.get(apiUrl);
    var quoteData = response.data;
    var quote = quoteData[_random.nextInt(quoteData.length)];
    setState(() {
      _quoteText = quote["text"];
      _quoteAuthor = quote["author"];
    });
  } 
}

class ExpandedTile extends StatelessWidget {
  String title = "";
  ExpandedTile({required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      elevation: 2,
      margin: const EdgeInsets.all(12.0),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ExpansionTile(
          title: _buildTile(context, title),
          trailing: Icon(Icons.keyboard_arrow_down),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const <Widget>[
                  Expanded(
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sit amet tristique neque, vel rhoncus est. Donec nisl tortor, hendrerit vitae eleifend nec, mattis sit amet tortor. Curabitur neque neque, accumsan id orci eu, dignissim molestie orci. Vivamus dui magna, lacinia ut tellus vitae, pellentesque tincidunt magna. Cras ac eros vitae neque eleifend semper. Ut a elit quis justo venenatis bibendum a fermentum ex. Maecenas sed lorem iaculis, luctus sem eu, semper massa. Maecenas a sagittis ante. In mollis sapien odio, nec vulputate purus pharetra sit amet.",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTile(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              title, 
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ]
        ),
      ],
    );
  }
}
