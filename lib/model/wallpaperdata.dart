import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Wallpaper {
  final id;
  final url;
  final photographer;
  final  Map<String,dynamic> src;
  bool favourite=false;
  Wallpaper({this.id,this.url,this.photographer,this.src,this.favourite});
}


List<Wallpaper>wallE=[];

void clearwall(){
  wallE.clear();
}

class Firebase{
  final key_ID;
  final ID;
  final Fav_Img;

  Firebase({@required this.ID,@required this.Fav_Img,@required this.key_ID});
}

class FireArray with ChangeNotifier{
  List <Firebase>fireBase=[];
  updatefireBaseArray()async{
    fireBase.clear();
    final area=await http.get("https://encrust-b7381.fireBaseio.com/favourites.json");
    final nvidia=json.decode(area.body) as Map<String,dynamic>;
    if(nvidia!=null){
      nvidia.forEach((key, value) {
        fireBase.add(Firebase(ID:value["ID"],Fav_Img:value["Imgurl"],key_ID:key));
      });
      for(int i=0;i<fireBase.length;i++){
        print( fireBase[i].key_ID);
      }
    };
    notifyListeners();
  }
  updatefireBase(String imgurl,int Id)async{

    await http.post("https://encrust-b7381.fireBaseio.com/favourites.json",body:json.encode(
        {
          "Imgurl":imgurl,
          "ID":Id,

        })).then((value) => updatefireBaseArray());

  }
  getfireBaseval(int img_id) async{
    print("------------------------");
    for(int i=0;i<fireBase.length;i++){
      print(fireBase[i].ID);
      print(fireBase[i].key_ID);
      print(fireBase[i].Fav_Img);
    }
    print("------------------------");
    final key_log=fireBase.firstWhere((element) =>element.ID==img_id);
    await http.delete("https://encrust-b7381.fireBaseio.com/favourites/${key_log.key_ID}.json").then((value) =>updatefireBaseArray() );
  }

}

