import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  final String email;
  Page2(this.email);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
      ),
      body: Center(
        child: Text('${widget.email ?? 'Hello'} '),
      ),
    );
  }
}
