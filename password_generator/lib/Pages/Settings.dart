import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  ///Represents if the password should contain symbols such as /:;<=
  final bool includeSymbols;

  ///Represents if the password should contain numbers
  final bool includeNumbers;

  ///Password's length
  final int length;

  ///Class constructor
  Settings({this.includeSymbols, this.includeNumbers, this.length});
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  ///Set to true if we want to include symbols
  bool _includeSymbols;

  ///Set to true if we want to include numbers
  bool _includeNumbers;

  ///Password's length
  int _length;

  ///Minimum password's length allowed
  int _minLength = 16;

  ///Maximum password's length allowed
  int _maxLength = 64;

  ///Controller associated with the TextInput used to set the length
  var _lengthController = new TextEditingController();

  ///Text value of the controller
  String _lengthControllerText;

  @override
  void initState() {
    super.initState();
    _includeSymbols = widget.includeSymbols;
    _includeNumbers = widget.includeNumbers;
    _length = widget.length;
    _lengthControllerText = _length.toString();
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
            Navigator.pop(
              context,
              {
                'length': _length,
                'includeSymbols': _includeSymbols,
                'includeNumbers': _includeNumbers,
              },
            );
          },
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
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
              CheckboxListTile(
                title: Text(
                  "Include symbols (e.g. >?@[\\]^)",
                  style: TextStyle(
                    fontSize: 22.0,
                  ),
                ),
                value: _includeSymbols,
                onChanged: (_) {
                  setState(() {
                    _includeSymbols = !_includeSymbols;
                  });
                },
              ),
              CheckboxListTile(
                title: Text(
                  "Include numbers (e.g. 1234..)",
                  style: TextStyle(
                    fontSize: 22.0,
                  ),
                ),
                value: _includeNumbers,
                onChanged: (_) {
                  setState(() {
                    _includeNumbers = !_includeNumbers;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 16.0, 0.0, 3.0),
                  child: Text(
                    "Password length:",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 4.0, 0.0, 4.0),
                  child: Text(
                    "- Minimum length: $_minLength",
                    style: TextStyle(
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 4.0, 0.0, 4.0),
                  child: Text(
                    "- Maximum length: $_maxLength",
                    style: TextStyle(
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 4.0, 0.0, 8.0),
                  child: Text(
                    "- Current length: $_lengthControllerText",
                    style: TextStyle(
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: TextField(
                  controller: _lengthController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Length",
                    labelStyle: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      // Validate the value before assign it to _length
                      if (_lengthController.text == "") {
                        _lengthControllerText = _length.toString();
                      } else if (int.parse(_lengthController.text) <
                          _minLength) {
                        _lengthControllerText = _minLength.toString();
                      } else if (int.parse(_lengthController.text) >
                          _maxLength) {
                        _lengthControllerText = _maxLength.toString();
                      } else {
                        _lengthControllerText = _lengthController.text;
                      }
                      _lengthController.clear();
                      _length = int.parse(_lengthControllerText);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
