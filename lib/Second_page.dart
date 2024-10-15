import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondPage extends StatefulWidget {
  final String name;
  final String email;
  SecondPage({Key? key, required this.name, required this.email}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late String _name;
  late String _email;
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _name = widget.name;
    _email = widget.email;
    _nameController = TextEditingController(text: _name);
    _emailController = TextEditingController(text: _email);
  }

  Future<void> _updateData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    setState(() {
      if (key == 'name') {
        _name = value;
        _nameController.text = value;
      } else if (key == 'email') {
        _email = value;
        _emailController.text = value;
      }
    });
  }

  void _deleteData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('email');
    setState(() {
      _name = ''; // Clear the name
      _email = ''; // Clear the email
      _nameController.text = ''; // Clear the text field
      _emailController.text = ''; // Clear the text field
    });
  }

  void _showUpdateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'New Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'New Email'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String newName = _nameController.text;
                String newEmail = _emailController.text;
                if (newName.isNotEmpty) _updateData('name', newName);
                if (newEmail.isNotEmpty) _updateData('email', newEmail);
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second page'),
        backgroundColor: Colors.brown,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'Update') {
                _showUpdateDialog();
              } else if (result == 'Delete') {
                _deleteData();
              }
            },
            itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Update',
                child: Text('Update'),
              ),
              const PopupMenuItem<String>(
                value: 'Delete',
                child: Text('Delete'),
                
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(_name),
            Text(_email),
          ],
        ),
      ),
    );
  }
}