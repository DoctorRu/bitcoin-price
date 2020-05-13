import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String _url = "https://blockchain.info/ticker";
  String _bitcoinPrice = "";

  void _getPrice() async {
    http.Response urlResponse = await http.get(_url);

    Map<String, dynamic> result = json.decode(urlResponse.body);

    setState(() {
      _bitcoinPrice = result["BRL"]["buy"].toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/bitcoin.png",
              width: 400,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "R\$ $_bitcoinPrice",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: RaisedButton(
                onPressed: _getPrice,
                child: Text(
                  "Get",
                  style: TextStyle(fontSize: 26, color: Colors.white),
                ),
                color: Colors.orange,
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
