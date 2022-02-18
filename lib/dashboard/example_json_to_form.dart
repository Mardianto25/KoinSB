import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:json_to_form/json_to_form.dart';

class JsonToForm extends StatefulWidget {
  @override
  _JsonToFormState createState() => _JsonToFormState();
}

class _JsonToFormState extends State<JsonToForm> {
  final formKey = new GlobalKey<FormState>();

  String form_send_email = json.encode([
    {'type': 'Input', 'title': 'Subject', 'placeholder': "Subject"},
    {'type': 'TareaText', 'title': 'Message', 'placeholder': "Content"},
  ]);
  String form = json.encode([
    {'type': 'Input',
     'required': true,
     'title': 'Hi Group', 
     'placeholder': "Hi Group flutter"
    },
    {
      'type': 'Input', 
      'required': false,
      'title': 'Hi Group', 
      'placeholder': "Hi Group "
    },
    {
      'type': 'Password',
      'required': false,
      'title': 'Password',
    },
    {'type': 'Email','required': true, 'title': 'Email test', 'placeholder': "hola a todos"},
    {
      'type': 'TareaText',
      'title': 'TareaText test',
      'required': false,
      'placeholder': "hola a todos"
    },
    {
      'type': 'RadioButton',
      'title': 'Radio Button tests',
      'value': true,
      'list': [
        {
          'title': "product 1",
          'value': true,
        },
        {
          'title': "product 2",
          'value': false,
        },
      ]
    },
    {
      'type': 'Switch',
      'title': 'Switch test',
      'switchValue': false,
    },
    {
      'type': 'Checkbox',
      'title': 'Checkbox test',
      'list': [
        {
          'title': "product 1",
          'value': true,
        },
        {
          'title': "product 2",
          'value': false,
        },
        {
          'title': "product 3",
          'value': false,
        }
      ]
    },
    {
      'type': 'Checkbox',
      'title': 'Checkbox test 2',
      'list': [
        {
          'title': "product 1",
          'value': true,
        },
        {
          'title': "product 2",
          'value': true,
        },
        {
          'title': "product 3",
          'value': false,
        }
      ]
    },
    {
      'type': 'RadioGroup',
      'title': 'Radio Group tests',
      'value': "Pilih",
      'list': [
        {
          'id': "1",
          'name': "Islam",
          
        },
        {
          'id': "2",
          'name': "Hindu",
        },
        {
          'id': "3",
          'name': "Kristen",
        }
      ]
    },
    {
      'type': 'RadioGroup',
      'title': 'Radio Group tests',
      'value': "Pilih",
      'list': [
        {
          'id': "1",
          'name': "Jawa Barat",
          
        },
        {
          'id': "2",
          'name': "Jawa Tengah",
        },
        {
          'id': "3",
          'name': "Jawa Timur",
        }
      ]
    },
    {
      'type': 'DropDown',
      'title': 'Dropdown',
      'value': "",
      'list': [
        {
          'name': "product 11",
          'id': 11,
        },
        {
          'name': "product 12",
          'id': 12,
        },
        {
          'name': "product 13",
          'id': 13,
        }
      ]
    },

    {
      'type': 'DropDown',
      'title': 'Dropdown1',
      'value': "1",
      'list': [
        {
          'name': "product 1",
          'id': 1,
        },
        {
          'name': "product 2",
          'id': 2,
        },
        {
          'name': "product 3",
          'id': 3,
        }
      ]
    },
  ]);
  dynamic response;

  @override
  Widget build(BuildContext context) {
    print(form);
    return new Scaffold(
      appBar: new AppBar(

        title: new Text("Test"),
      ),
      body: new SingleChildScrollView(
        child: new Container(

          child: Form(
            key: formKey,
            child: new Column(children: <Widget>[
              // new CoreForm(
              //   form: form,
              //   onChanged: (dynamic response) {
              //     this.response = response;
              //   },
              // ),
              Container(
                child: Text(this.response.toString()),
              ),
              new RaisedButton(
                  child: new Text('Send'),
                  onPressed: () {
                    final form = formKey.currentState;
                    if (form.validate()) {
                      print(this.response.toString());
                     
                    }
                  }),
              
            ]),
          ),
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}