import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpicks/model/wallpaperdata.dart';
import 'package:wallpicks/overviewPage.dart';
import 'SearchClass.dart';
import 'appdrawer.dart';
import './presentation/my_flutter_app_icons.dart' as CustomIcon ;
import 'package:http/http.dart' as http;



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void>getWallpapers() async{

 final read_val=await http.get("https://api.pexels.com/v1/curated/?page=2&per_page=50",headers:{
   "Authorization":"563492ad6f917000010000017700a88a8e93434fad942ea622eb1b1f"
 }).then((value) {
   Map<String,dynamic> update_val=jsonDecode(value.body);
   update_val["photos"].forEach((element) {
     Map<String,dynamic> _appinsidedata=element;
     final state_add=Wallpaper(id:_appinsidedata["id"],url:_appinsidedata["url"],photographer:_appinsidedata["photographer"],src:_appinsidedata["src"],favourite:false);
     wallE.add(state_add);
   });
 });
 setState(() {


    });
  }
  bool searchArea;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getWallpapers();
    searchArea=false;
  }
  //-----------------------------------


  //-----------------------------------
  @override
  Widget build(BuildContext context) {
    TextEditingController searchQuery=TextEditingController();
    return Scaffold(
        drawer:AppDraw(),
      appBar:AppBar(
        leading:Builder(
          builder:(BuildContext context){
            return IconButton(
              icon:Icon(CustomIcon.MyFlutterApp.waves_outline),
              color:Colors.yellow[600],
              onPressed:(){
                Scaffold.of(context).openDrawer();
              },

            );
          },
        ),


        backgroundColor:Colors.grey[500],
        title:searchArea?TextField(
          controller:searchQuery,
          onSubmitted:(text){
            //Search query submission here
            Navigator.of(context).push(
              MaterialPageRoute(
                builder:(_){
                  return SearchClass(searchcontent:searchQuery.text,);
                }
              )
            );

            //for Debug purposes only it is shown\
            ///////////////////////////////////////
            //////////////////////////////////////
            /////////////////////////////////////
          },
          decoration:InputDecoration(
            hintText:"Enter your search query",
          ),
        ):Center(
          child:Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: <Widget>[
              Text("e",style:TextStyle(
                color:Colors.blueAccent,
                fontSize:34.0,

              ),
              ),
              Text("NCRUST"),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.search),
            onPressed: (){
              setState(() {
                searchArea=!searchArea;
              });
            },
          )
        ],
      ),

      body:GridView.builder(
        padding:EdgeInsets.all(5.0),

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:2,
          childAspectRatio:2/4,
          crossAxisSpacing:2,
          mainAxisSpacing:2.0,

        ), itemBuilder:(ctx,index){
        return GestureDetector(
          onTap:(){
//            "Imgsrc":wallE[index].src["portrait"],
//            "Id":wallE[index].id
          searchArea=false;
            Navigator.of(context).push(
              MaterialPageRoute(
              builder:(_){
                return Overview(imgsrc:wallE[index].src["portrait"],
                id:wallE[index].id,
                view:false,
                );
              }
              )
            );
          },
          child: GridTile(
              child:Container(

                decoration:BoxDecoration(
                    border:Border.all(color:Colors.transparent,width:0.2)

                ),
                child:ClipRRect(
                  borderRadius:BorderRadius.circular(15),
                  child:Image.network(wallE[index].src["portrait"],fit:BoxFit.cover,),
                ),
              )

          ),
        );
      },itemCount:wallE.length,)


    );
  }
}
