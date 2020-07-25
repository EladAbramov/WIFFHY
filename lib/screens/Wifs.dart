import 'package:flutter/material.dart';
import 'package:music_player/music_player.dart';

// ignore: must_be_immutable
class Wifs extends StatefulWidget {

  // ignore: non_constant_identifier_names
  String wif_name, tag_name, wif_url, image_url, searchKey;
  // ignore: non_constant_identifier_names
  Wifs({this.wif_name, this.tag_name, this.wif_url, this.image_url, this.searchKey});

  @override
  _WifsState createState() => _WifsState();
}

class _WifsState extends State<Wifs> {
  MusicPlayer musicPlayer;
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Initializing the Music Player and adding a single [PlaylistItem]
  Future<void> initPlatformState() async {
    musicPlayer = MusicPlayer();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Wiffs App')
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Text(
              widget.wif_name,
              style: TextStyle(
                fontSize: 25.0
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              widget.tag_name,
              style: TextStyle(
                fontSize: 25.0
              ),
            ),
            Card(
              child: Image.network(widget.image_url, height: 350.0),
              elevation: 10.0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width*0.2,

            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 100.0,
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: (){
                      setState(() {
                        isPlaying = true;
                      });
                      musicPlayer.play(
                        MusicItem(
                          trackName: '',
                          albumName: '',
                          artistName: '',
                          url: widget.wif_url,
                          coverUrl: '',
                          duration: Duration(seconds: 255),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.play_arrow,
                      size: 50.0,
                      color: isPlaying == true ? Colors.blue : Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        isPlaying = false;
                      });
                      musicPlayer.stop();
                    },
                    child: Icon(
                      Icons.stop,
                      size: 50.0,
                      color: isPlaying == true ? Colors.black : Colors.blue
                    ),
                  ),
                ),
                SizedBox(
                  width: 100.0
                ),
              ],
            )
          ],
        ),
      ),
    );

  }
}




