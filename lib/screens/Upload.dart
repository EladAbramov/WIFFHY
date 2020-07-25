import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {

  TextEditingController wifName = TextEditingController();
  TextEditingController tagName = TextEditingController();

  File image, wif;
  String imagePath, wifPath;

  StorageReference ref;
  // ignore: non_constant_identifier_names
  var image_down_url, wif_down_url;
  final firestoreInstance = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () => selectImage(),
            child: Text('Select Image'),
          ),
          RaisedButton(
            onPressed: () => selectWif(),
            child: Text('Select Wif'),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              controller: wifName,
              decoration: InputDecoration(
                hintText: 'Enter Wif name:(Uppercase 1st char)'
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              controller: tagName,
              decoration: InputDecoration(
                  hintText: 'Enter Tag name:'
              ),
            ),
          ),
          RaisedButton(
            onPressed: () => finalUpload(),
            child: Text('Upload'),
          ),
        ],
      ),
    );
  }

  void selectImage() async {
    image = (await FilePicker.getFile());
    setState(() {
      image = image;
      imagePath = basename(image.path);

      uploadImageFile(image.readAsBytesSync(), imagePath);

    });
  }

  void selectWif() async {
    wif = (await FilePicker.getFile());
    setState(() {
      wif = wif;
      wifPath = basename(wif.path);

      uploadWifFile(wif.readAsBytesSync(), wifPath);

    });
  }

  finalUpload(){
    var data = {
      'wif_name': wifName.text,
      'tag_name': tagName.text,
      'wif_url': wif_down_url.toString(),
      'image_url': image_down_url.toString(),
      'searchKey': wifName.text.substring(0, 1).toUpperCase(),
    };
    firestoreInstance.collection('wifs').document(wifName.text).setData(data);
  }

  Future<String> uploadImageFile(List<int> image, imagePath) async {
    ref = FirebaseStorage.instance.ref().child(imagePath);
    StorageUploadTask uploadTask = ref.putData(image);
    image_down_url = await (await uploadTask.onComplete).ref.getDownloadURL();
    return 'Success upload Image';
  }

  Future<String> uploadWifFile(List<int> wif, wifPath) async {
    ref = FirebaseStorage.instance.ref().child(wifPath);
    StorageUploadTask uploadTask = ref.putData(wif);
    wif_down_url = await (await uploadTask.onComplete).ref.getDownloadURL();
    return 'Success upload Wif';

  }
}
