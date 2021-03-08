import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  ///Represents if the password should contain symbols such as /:;<=
  bool includeSymbols;

  ///Represents if the password should contain numbers
  bool includeNumbers;

  ///Class constructor
  Settings({this.includeSymbols, this.includeNumbers});
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _includeSymbols;
  bool _includeNumbers;

  @override
  void initState() {
    super.initState();
    _includeSymbols = widget.includeSymbols;
    _includeNumbers = widget.includeNumbers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, {
              'length': 16,
              'includeSymbols': _includeSymbols,
              'includeNumbers': _includeNumbers,
            });
          },
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 16.0, 0.0, 3.0),
                  child: Text(
                    "Include characters:",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _includeSymbols,
                    onChanged: (value) {
                      setState(() {
                        _includeSymbols = !_includeSymbols;
                      });
                    },
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "Include symbols (e.g. >?@[\\]^)",
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _includeNumbers,
                    onChanged: (value) {
                      setState(() {
                        _includeNumbers = !_includeNumbers;
                      });
                    },
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "Include numbers (e.g. 1234..)",
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
