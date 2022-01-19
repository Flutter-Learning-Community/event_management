import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'bottompicker_sheet';

import 'AlertDialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  late File _image;
  bool uploadStatus = false;

  _imageFromCamera() async {
    final PickedFile? pickedImage =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);
    if (pickedImage == null) {
      showAlertDialog(
          context: context,
          title: "Error Uploading!",
          content: "No Image was selected.");
      return;
    }
    final File fileImage = File(pickedImage.path);

    if (imageConstraint(fileImage))
      setState(() {
        _image = fileImage;
      });
  }

  _imageFromGallery() async {
    final PickedFile? pickedImage =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedImage == null) {
      showAlertDialog(
          context: context,
          title: "Error Uploading!",
          content: "No Image was selected.");
      return;
    }
    final File fileImage = File(pickedImage.path);
    if (imageConstraint(fileImage))
      setState(() {
        _image = fileImage;
      });
  }

  bool imageConstraint(File image) {
    if (!['bmp', 'jpg', 'jpeg']
        .contains(image.path.split('.').last.toString())) {
      showAlertDialog(
          context: context,
          title: "Error Uploading!",
          content: "Image format should be jpg/jpeg/bmp.");
      return false;
    }
    if (image.lengthSync() > 100000) {
      showAlertDialog(
          context: context,
          title: "Error Uploading!",
          content: "Image Size should be less than 100KB.");
      return false;
    }
    return true;
  }

  uploadImage() async {
    if (_image == null) {
      showAlertDialog(
          context: context,
          title: "Error Uploading!",
          content: "No Image was selected.");
      return;
    }

    setState(() {
      uploadStatus = true;
    });
    var response = await http
        .post(Uri.parse('https://pcc.edu.pk/ws/file_upload.php'), body: {
      "image": _image.readAsBytes().toString(),
      "name": _image.path.split('/').last.toString()
    });
    print('response');
    if (response.statusCode != 200) {
      showAlertDialog(
          context: context,
          title: "Error Uploading!",
          content: "Server Side Error.");
    } else {
      var result = jsonDecode(response.body);
      print(result);
      showAlertDialog(
          context: context, title: "Image Sent!", content: result['message']);
    }
    setState(() {
      uploadStatus = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _isObsecure = true;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: uploadStatus
              ? Container(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    strokeWidth: 7,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          bottomPickerSheet(
                              context, _imageFromCamera, _imageFromGallery);
                        },
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width / 8,
                          backgroundColor: Colors.grey,
                          backgroundImage: AssetImage('assets/cameraa_img.png'),
                        ),
                      ),
                      Positioned(
                          child: RawMaterialButton(
                        onPressed: uploadImage,
                        fillColor: Color(0xFFF5F6F9),
                        child: Icon(
                          Icons.file_upload,
                          color: Colors.blue,
                        ),
                        padding: EdgeInsets.all(5.0),
                        shape: CircleBorder(),
                      )),
                      const SizedBox(
                        //Use of SizedBox
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: _isObsecure,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Name',
                          hintText: 'Name of the Person',
                        ),
                      ),
                      const SizedBox(
                        //Use of SizedBox
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: _isObsecure,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone_android),
                          labelText: 'Phone Number',
                          hintText: '789-852-8568',
                        ),
                      ),
                      const SizedBox(
                        //Use of SizedBox
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: _isObsecure,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.home),
                          labelText: 'Address',
                          hintText: 'Address',
                        ),
                      ),
                      const SizedBox(
                        //Use of SizedBox
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: _isObsecure,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email',
                          hintText: 'mani@gmail.com',
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

void bottomPickerSheet(BuildContext context, Function() imageFromCamera,
    Function() imageFromGallery) {}
