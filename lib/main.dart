import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caesar Cipher',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController inputController = TextEditingController();
  final TextEditingController keyController = TextEditingController();
  String encryptionResult = '';
  String decryptionResult = '';
  int key = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caesar Cipher'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/justin-bieber.png'), 
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Zidane Romandhon Putra',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    '21120121140115',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Aplikasi ini dibuat untuk memnuhi tugas remedial kriptografi 2023'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: inputController,
              decoration: InputDecoration(labelText: 'Input Text'),
            ),
            TextField(
              controller: keyController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Key'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  key = int.tryParse(keyController.text) ?? 0;
                  encryptionResult = caesarCipher(inputController.text, key, true);
                });
              },
              child: Text('Encrypt'),
            ),
            SizedBox(height: 20),
            Text('Encryption Result: $encryptionResult'),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  key = int.tryParse(keyController.text) ?? 0;
                  decryptionResult = caesarCipher(inputController.text, key, false);
                });
              },
              child: Text('Decrypt'),
            ),
            SizedBox(height: 20),
            Text('Decryption Result: $decryptionResult'),
          ],
        ),
      ),
    );
  }

  String caesarCipher(String input, int key, bool isEncryption) {
    int factor = isEncryption ? 1 : -1;
    String result = '';
    for (int i = 0; i < input.length; i++) {
      if (RegExp(r'[a-zA-Z]').hasMatch(input[i])) {
        String char =
            String.fromCharCode((input.codeUnitAt(i) - 'A'.codeUnitAt(0) + factor * key) % 26 + 'A'.codeUnitAt(0));
        result += input[i] == input[i].toUpperCase() ? char : char.toLowerCase();
      } else {
        result += input[i];
      }
    }
    return result;
  }
}
