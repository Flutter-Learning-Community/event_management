import 'package:flutter/material.dart';

void main() => runApp(user_detail());

class user_detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Event Details",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(
            child: Text("Event Details"),
          ),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  var val;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.person),
                hintText: 'Enter your full name',
                labelText: 'Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              maxLength: 10,
              decoration: const InputDecoration(
                icon: const Icon(Icons.phone),
                hintText: 'Enter a phone number',
                labelText: 'Phone',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter valid phone number';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.calendar_today),
                hintText: 'mm/dd/yyyy',
                labelText: ' Event Date',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter valid date';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.watch),
                hintText: 'hh/mm/ss',
                labelText: ' Event Time',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Time';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.home),
                hintText: 'Event Address',
                labelText: 'Event Address',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Container(
              child: Text(
                "Food Choice",
              ),
              padding: EdgeInsets.only(
                left: 39,
                top: 30,
                right: 50,
                bottom: 30,
              ),
            ),
            ListTile(
              title: Text("With Food"),
              leading: Radio(
                value: 1,
                groupValue: val,
                onChanged: (value) {
                  setState(() {
                    val = value;
                  });
                },
                activeColor: Colors.black,
              ),
            ),
            ListTile(
              title: Text("Without Food"),
              leading: Radio(
                value: 2,
                groupValue: val,
                onChanged: (value) {
                  setState(() {
                    val = value;
                  });
                },
                activeColor: Colors.black,
              ),
            ),
            new Container(
                padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                child: new RaisedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Submitted')));
                    }
                  },
                )),
          ],
        ));
  }
}
