import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:post_req_api/api_requests/submitform.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  var responseDetails;

  TextEditingController _nameController = TextEditingController();

//Call Api request function and set the Loading true
  void _submitForm() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'name': _nameController.text,
    };

    var response = await SubmitForm().postApi('api/endurl', data);
    var body = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        responseDetails = body;
      });
    } else {
      print('Unable to send data');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter Name',
                  labelText: 'Name *',
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String? value) {
                  return (value != null && value.contains('@'))
                      ? 'Do not use the @ char.'
                      : null;
                },
              ),
              Container(
                  padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                  child: new ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: _submitForm,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
