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
  String _defaultText = "Click the button to generate a password";
  var settings = {
    'length': 16,
    'includeSymbols': false,
    'includeNumbers': false,
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
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    _password == "" ? _defaultText : _password,
                    style: TextStyle(
                      fontFamily: 'Consolas',
                      fontSize: 25.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  if (_password == "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("To copy a password, first generate one"),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                        ),
                      ),
                    );
                  } else {
                    //Copy the password to the clipboard
                    Clipboard.setData(new ClipboardData(text: _password));
                    //Notify user with a snackbar that the passwd has been copied
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Copied to clipboard"),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                        ),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.touch_app,
                    size: 16.0,
                  ),
                  SizedBox(width: 5.0),
                  Text("Tap on the password to copy it to your clipboard"),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.lock),
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
