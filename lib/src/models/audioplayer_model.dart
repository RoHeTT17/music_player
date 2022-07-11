import 'package:flutter/material.dart';

class AudioPlayerModel with ChangeNotifier{

  bool _playing = false;
  
  late AnimationController _controller;

  Duration _songDuration      = new Duration(milliseconds: 0);
  Duration _momentoActualSong = new Duration(milliseconds: 0);

  bool get playing => this._playing;

  set playing(bool value) { 
    this._playing = value;
    notifyListeners();
  }

  AnimationController  get controller => this._controller;

  set controller(AnimationController value) => this._controller = value;

  Duration get songDuration => this._songDuration;

  set songDuration(Duration value) {
    this._songDuration = value;
    notifyListeners();
  }

  Duration get momentoActualSong => this._momentoActualSong;

  set momentoActualSong(Duration value)  {
    this._momentoActualSong = value;
    notifyListeners();
  }

  //Obtener el porcentaje de cuanto se lleva de la canción
  double get getPorcentajeSong => ( _songDuration.inSeconds > 0)
                                  ?  _momentoActualSong.inSeconds / _songDuration.inSeconds
                                  : 0;  

  String get getTotalSongDuration => printDuration(_songDuration);
  String get getCurrentSecond     => printDuration(_momentoActualSong);

 //Codigo para formatear un duration
  String printDuration(Duration duration) {
  
      String twoDigits(int n) {
        if(n >= 10) return "$n";
        return "0$n";
      }
  
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

      //Para Hora, minuto y segundos  
      //return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";

      return "$twoDigitMinutes:$twoDigitSeconds";
  
  }
}