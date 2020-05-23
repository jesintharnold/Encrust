import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpicks/model/wallpaperdata.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:http/http.dart' as http;



class Overview extends StatefulWidget {
  final imgsrc;
  final id;
  bool view;
  Overview({@required this.id,@required this.imgsrc,@required this.view});

  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {


   downloadIm(url,context) async{
   await ImageDownloader.downloadImage(url,destination:AndroidDestinationType.directoryPictures).then((value) => Scaffold.of(context).showSnackBar(SnackBar(
     content:Text("Downloaded Successfully !",style:TextStyle(
       color:Colors.white,
       fontSize:15.0
     ),),
     duration:Duration(seconds:1),                                              
   )));

  }

   int _progress=0;
  @override
  void initState() {
    super.initState();
    ImageDownloader.callback(onProgressUpdate: (String imageId, int progress) {
      setState(() {
        _progress = progress;
        print(_progress);
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    final prov=Provider.of<FireArray>(context);
    print(widget.imgsrc);
    return Scaffold(
      body: Container(
        child:GridTile(
            child:Image.network(widget.imgsrc,fit:BoxFit.cover,),
            footer:ClipRRect(

              child:GridTileBar(

                    leading:Row(
                      children: <Widget>[
                       Container(                                               
                        color:Colors.black54,
                          child:widget.view?IconButton(
                            icon:Icon(Icons.favorite,color:Colors.red),
                            onPressed:(){
                              Icon(Icons.favorite_border);
                              Navigator.of(context).pop();
                              setState(() {
                                prov.getfireBaseval(widget.id);
                              });
//          //This is for favourite
//
                            },
                          ):IconButton(
                                icon:wallE.firstWhere((element) => element.id==widget.id).favourite?Icon(Icons.favorite,color:Colors.red):Icon(Icons.favorite_border),
                             onPressed:(){
                              setState(() {

                                  wallE.firstWhere((element) => element.id==widget.id).favourite=!wallE.firstWhere((element) => element.id==widget.id).favourite;
                                  wallE.firstWhere((element) => element.id==widget.id).favourite?prov.updatefireBase(widget.imgsrc,widget.id):prov.getfireBaseval(widget.id);


                              });
//          //This is for favourite
//
},
      ),

    ),

    Container(
      color:Colors.black54,
      child: Builder(
        builder:(context)=>IconButton(
          icon:Icon(Icons.save_alt),
          onPressed:(){
           downloadIm(widget.imgsrc,context);
           },
        ),
      ),
    ),

  ],
),

              ),
            ),
        ),
        width:double.infinity,

      ),
    );
  }
}
