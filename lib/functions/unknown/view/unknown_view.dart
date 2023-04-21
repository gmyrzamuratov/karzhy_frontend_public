import 'package:flutter/material.dart';

class UnknownView extends StatefulWidget {

  UnknownView({Key? key});

  @override
  State<UnknownView> createState() => _UnknownViewState();
}

class _UnknownViewState extends State<UnknownView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("404")
        ),
        body: Center(
          child: Text("404 Error"),
        ),
    );
  }

}
