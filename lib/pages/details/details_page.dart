import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final String? title;
  final String? url;
  // const DetailsPage(@PathParam('title') this.title,@PathParam('url') this.url,{Key? key}) : super(key: key);
  const DetailsPage(@QueryParam('title') this.title,@QueryParam('url') this.url,{Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'DetailsPage${widget.title}｜ ${widget.url}'
      ),
    );
  }
}
