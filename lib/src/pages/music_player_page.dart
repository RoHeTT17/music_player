
import 'package:flutter/material.dart';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

import 'package:music_player/src/helpers/helpers.dart';
import 'package:music_player/src/widgets/custom_appbar.dart';
import 'package:music_player/src/models/audioplayer_model.dart';


class MusicPlayerPage extends StatelessWidget {
 
  const MusicPlayerPage({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          const BackGround(), 

          Column(
            children:  const [
                              CustomAppBar(),
                              ImagenDiscoDuracion(),
                              TituloPlay(),
                              Lyrics()
                            ],
          ),
        ],
      )
   );
  }
}

class BackGround extends StatelessWidget {
  const BackGround({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Container(

      width: double.infinity,
      height: screenSize.height * 0.8,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.center,
          colors: [
                    Color(0xff33333E),
                    Color(0xff201E28)
                  ]
        )
      ),
    );
  }
}

class ImagenDiscoDuracion extends StatelessWidget {
  const ImagenDiscoDuracion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin:  const EdgeInsets.only(top: 40),
      child: Row(
        children:const [

                   ImagenDisco(),
                   SizedBox(width: 50,),
                   BarraProgreso(),
                   SizedBox(width: 10,),
                 ],
      ),
    );
  }
}

class ImagenDisco extends StatelessWidget {
  const ImagenDisco({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      width:  225,
      height: 225,
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          colors: [
                  Color(0xff484750),
                  Color(0xff1E1C24)
                  ]
        )
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
                    alignment: Alignment.center,
                    children: [
                                
                                SpinPerfect(
                                  duration: const Duration(seconds: 10),
                                  infinite: true,
                                  manualTrigger: true, //Para qie se anime cuando se indique. 
                                                       //Al estar en true, se debe asiganar un controller
                                  controller: (aController) => audioPlayerModel.controller = aController, 
                                  child: Image.asset('assets/aurora.jpg')
                                ),

                                Container(
                                  width:  25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.circular(100)
                                  ),
                                ),
                                Container(
                                  width:  18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff1C1C25),
                                    borderRadius: BorderRadius.circular(100)
                                  ),
                                )                                
                              ],
                    ),
      ),
    );
  }
}

class BarraProgreso extends StatelessWidget {
  const BarraProgreso({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final estilo =  TextStyle(color: Colors.white.withOpacity(0.4));
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    final porcentaje = audioPlayerModel.getPorcentajeSong;

    return Column(
      children: [
        Text(audioPlayerModel.getTotalSongDuration, style: estilo),
        Stack(
          children: [
                       Container(
                        width: 3,
                        height: 225,
                        color: Colors.white.withOpacity(0.1),
                       ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: 3,
                          //225 es la totalidad. Es el tamaño del container que esta arriba
                          height: 225 * porcentaje,
                          color: Colors.white.withOpacity(0.8),
                         ),
                      ),
                    ],
        ),
        Text(audioPlayerModel.getCurrentSecond, style: estilo),
      ],
    );
  }
}

class TituloPlay extends StatefulWidget {
  const TituloPlay({
    Key? key,
  }) : super(key: key);

  @override
  State<TituloPlay> createState() => _TituloPlayState();
}

class _TituloPlayState extends State<TituloPlay> with SingleTickerProviderStateMixin {
  
  bool isPlaying   = false;
  bool isFirstTime = true;
  
  late AnimationController playAnimation;

  final assetAduiPlayer = new AssetsAudioPlayer();

  @override
    void initState() {
      
      //super.initState();
      playAnimation = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
      super.initState();
    }

  @override
    void dispose() {
      this.playAnimation.dispose();
      super.dispose();
    }

  void openAudio(){
    //Para leer la canción, establecer valores, etc.
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context,listen: false);

    //Cargar el audio
    assetAduiPlayer.open(
      Audio('assets/Breaking-Benjamin-Far-Away.mp3'),
      autoStart: true,
      showNotification: true
    );
    
    //Listener para el momento actual de la canción
    assetAduiPlayer.currentPosition.listen((duration) {
      audioPlayerModel.momentoActualSong = duration;
    }); 

    //Duración completa de la canción  
    assetAduiPlayer.current.listen((playingaudio) {
       audioPlayerModel.songDuration = playingaudio?.audio.duration ?? const Duration(seconds: 0);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 20),
      margin:  const EdgeInsets.only(top: 20),
      child: Row(
        children: [
                    Column(
                      children: [     
                                  Text('Far Away', style: TextStyle(fontSize:  30, color: Colors.white.withOpacity(0.8)),),
                                  Text('-Breakin Benjamin-', style: TextStyle(fontSize:  15, color: Colors.white.withOpacity(0.5)),),
                                ],
                    ),

                    const Spacer(),

                    FloatingActionButton(
                      elevation: 0,
                      highlightElevation: 0,
                      backgroundColor: const Color(0xffF8CB51),
                      child: AnimatedIcon(
                        icon: AnimatedIcons.play_pause, 
                        progress: playAnimation,
                      ),//Icon(Icons.play_arrow),
                      onPressed: (){

                        final audioPlayerModel = Provider.of<AudioPlayerModel>(context,listen: false);

                        if(isPlaying){
                            playAnimation.reverse();
                            isPlaying = false;
                            audioPlayerModel.controller.stop();
                            
                        }else{
                          playAnimation.forward();
                          isPlaying = true;
                          audioPlayerModel.controller.repeat();
                        }

                        if(isFirstTime){
                          openAudio();
                          isFirstTime = false;
                        }  else{
                          assetAduiPlayer.playOrPause();
                        }

                      }
                    ),

                  ],
      ),
    );
  }
}

class Lyrics extends StatelessWidget {
  const Lyrics({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final lyrics = getLyrics();

    return Expanded(
      child: ListWheelScrollView(
        physics: const BouncingScrollPhysics(),
        diameterRatio: 1.5, //Que tan curvo queremos que se muestre el texto
        itemExtent: 42, //La separación estre los elementos
        //La lista debe ser de Widgets, por lo que se transforma la letra un Text
        children: lyrics.map(
          (verso) => Text(verso,style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.6)),)
        ).toList()
      ),
    );
  }
}