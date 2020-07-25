import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Wifs.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
            ),
          );
        }
        else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute
                  (builder: (context) => Wifs(
                    wif_name: snapshot.data[index].data['wif_name'],
                    tag_name: snapshot.data[index].data['tag_name'],
                    wif_url: snapshot.data[index].data['wif_url'],
                    image_url: snapshot.data[index].data['image_url'],
                    searchKey: snapshot.data[index].data['searchKey'],

                ))),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      snapshot.data[index].data['wif_name'],
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  elevation: 10.0,
                ),
              );
            }
          );
        }
      },
    );
  }

  Future getData() async {
    QuerySnapshot qn = await Firestore.instance.collection('wifs').getDocuments();
    return qn.documents;
  }
}
