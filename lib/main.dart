import 'package:flutter/material.dart';
import 'package:share_pref/Second_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  var nameContoroller = TextEditingController();
  var emailContoroller = TextEditingController();
  static const String KEYNAME = "name";
  static const String KEYEMAIL = "email";
  var nameValue = "";
  var emailValue = "";
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preference'),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        child: Center(
          child: Column(
          children: [
            Padding(
               padding: const EdgeInsets.only(left: 20,right: 20,top: 50),
               child: TextField(
                 controller: nameContoroller,
                 decoration: InputDecoration(
                   labelText: "Enter your Name"
                 ),
               ),
             ),
             Padding(
                 padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                  child: TextField(
                  controller: emailContoroller,

                 decoration: InputDecoration(
                   labelText: "Enter your Email"
                 ),
               ),
             ),
             SizedBox(
            height: 20,
             ),

             ElevatedButton(
                 onPressed: () async{
                   var prefs = await SharedPreferences.getInstance();
                   prefs.setString(KEYNAME, nameContoroller.text.toString());
                   prefs.setString(KEYEMAIL, emailContoroller.text.toString());
                   Navigator.push(context,MaterialPageRoute(builder: (context) =>
                       SecondPage(name: nameContoroller.text.toString(), email: emailContoroller.text.toString()),));
                   }, child: Text('Save'),
             ),
             SizedBox(
                  height: 20,
             ),
                Text((nameValue)),
                Text((emailValue))
           ],
        ),
      ),
      ),
    );
  }

  void getValue() async{
    var pref = await SharedPreferences.getInstance();
    var getName = pref.getString(KEYNAME);
    var getEmail = pref.getString(KEYEMAIL);
    nameValue = getName ?? "";
    emailValue = getEmail ?? "";
    setState(() {
    });
  }
}
