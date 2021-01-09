import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class WidgetAudio extends StatefulWidget{
  @override
  _WidgetAudioState createState() => _WidgetAudioState();
}

class _WidgetAudioState extends State<WidgetAudio> {

  @override Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(right: 25, top: 10),
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
              child: Image.asset("assets/icons/btnlink.png")),
          SizedBox(
            width: 10,
          ),
          InkWell(
              child: Image.asset("assets/icons/btnlike.png")),

       SizedBox(
              width: 10,
            ),
          InkWell(
              onTap: onplayAudio,
              child:Image.asset("assets/icons/btnonvolume.png"))
        ],
      ),
    );
  }
  void onplayAudio() async {
     AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
     assetsAudioPlayer.stop();
   }
}