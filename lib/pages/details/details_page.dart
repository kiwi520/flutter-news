import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final String? title;
  final String? url;
  const DetailsPage({Key? key,this.title,this.url}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'DetailsPage'
      ),
    );
  }
}
