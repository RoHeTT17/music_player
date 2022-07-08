import 'package:flutter/material.dart';
import 'package:music_player/src/widgets/custom_appbar.dart';


class MusicPlayerPage extends StatelessWidget {
 
  const MusicPlayerPage({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
                          CustomAppBar(),
                          ImagenDiscoDuracion()
                        ],
      )
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
      margin:  const EdgeInsets.only(top: 70),
      child: Row(
        children:const [

                   ImagenDisco(),
                   SizedBox(width: 20,),
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
    return Container(
      padding: const EdgeInsets.all(20),
      width:  250,
      height: 250,
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
                                Image.asset('assets/aurora.jpg'),
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

    return Container(
      child: Column(
        children: [
          Text('00:00', style: estilo),
          Stack(
            children: [
                         Container(
                          width: 3,
                          height: 230,
                          color: Colors.white.withOpacity(0.1),
                         ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: 3,
                            height: 100,
                            color: Colors.white.withOpacity(0.8),
                           ),
                        ),
                      ],
          ),
          Text('00:00', style: estilo),
        ],
      ),
    );
  }
}
