import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ///The password that will be generated
  String _password = "";
  var settings = {
    'length': 16,
    'includeSymbols': true,
    'includeNumbers': true,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Password Generator"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () async {
              dynamic newSettings = await Navigator.of(context)
                  .pushNamed('/settings', arguments: settings);
              setState(() {
                settings = newSettings;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Your password:",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 25.0),
              InkWell(
                child: Container(
                  child: Text(
                    _password == ""
                        ? "Click the button to generate a password"
                        : _password,
                    style: TextStyle(
                      fontFamily: 'Consolas',
                      fontSize: 25.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  //Copy the password to the clipboard
                  Clipboard.setData(new ClipboardData(text: _password));
                  //Notify user with a snackbar that the passwd has been copied
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Copyed to clipboard"),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.create),
        label: Text("Generate"),
        tooltip: "Generate a new password",
        onPressed: () {
          setState(
            () {
              _password = generatePassword();
            },
          );
        },
      ),
    );
  }

  ///Creates a password with letters, symbols and numbers
  String generatePassword() {
    String letters = "abcdefghijklmnopqrstuvwxyz";
    String upperLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String numbers = "012345789";
    String symbols = "!\"#%&'()*+,-./:;<=>?@[\\]^_`{|}~";
    var buffer = StringBuffer("");
    Random rng = new Random();
    while (buffer.length < settings['length']) {
      var rand = rng.nextInt(16);
      if (rand >= 0 && rand <= 5) {
        buffer.write(letters[rng.nextInt(letters.length)]);
      } else if (rand >= 6 && rand <= 10) {
        buffer.write(upperLetters[rng.nextInt(upperLetters.length)]);
      } else if (rand >= 11 && rand <= 12 && settings['includeNumbers']) {
        buffer.write(numbers[rng.nextInt(numbers.length)]);
      } else if (rand >= 13 && settings['includeSymbols']) {
        buffer.write(symbols[rng.nextInt(symbols.length)]);
      }
    }
    return buffer.toString();
  }
}
