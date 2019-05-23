import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:test_demo/pages/page2.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  String name = 'Hello';
  List results = [];
  bool isLoading = true;

  Future getUser() async {
    var url = "https://randomuser.me/api/?results=50";

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        results = jsonResponse['results'];
        isLoading = false;
      });
    } else {}
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Text('แอปของฉัน $name'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () {
              print('xxxxxx');
              setState(() {
                name = 'Flutter';
              });
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                suffixIcon: IconButton(icon: Icon(Icons.search)),
                fillColor: Colors.white,
                filled: true,
                border: InputBorder.none,
                hintText: 'ค้นหา...'),
          ),
          Expanded(
            child: ModalProgressHUD(
              inAsyncCall: isLoading,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var first = results[index]['name']['first'];
                  var last = results[index]['name']['last'];
                  var email = results[index]['email'];
                  var imageUrl = results[index]['picture']['thumbnail'];

                  return Container(
                    margin:
                        EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: ListTile(
                      title: Text('$first $last'),
                      subtitle: Text('$email'),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => Page2(email),
                          fullscreenDialog: true)),
                    ),
                  );
                },
                itemCount: results.length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_enhance),
        label: Text('ถ่ายภาพ'),
        onPressed: () {
          print(name);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Page2('TEST@MAIL.COM'),
              fullscreenDialog: true));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
