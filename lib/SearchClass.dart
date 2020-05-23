import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './presentation/my_flutter_app_icons.dart' as CustomIcon ;
import 'appdrawer.dart';
import 'package:wallpicks/model/wallpaperdata.dart';
import 'overviewPage.dart';
class SearchClass extends StatefulWidget {

  final searchcontent;
  SearchClass({@required this.searchcontent});

  @override
  _SearchClassState createState() => _SearchClassState();
}

class _SearchClassState extends State<SearchClass> {


  TextEditingController searchQuery=TextEditingController();

  Future<void>getSearchWallpapers(String searchQuery) async{
    wallE.clear();
    final read_val=await http.get("https://api.pexels.com/v1/search?query=${searchQuery}&per_page=50",headers:{
      "Authorization":"563492ad6f917000010000017700a88a8e93434fad942ea622eb1b1f"
    }).then((value) {
      Map<String,dynamic> update_val=jsonDecode(value.body);
      update_val["photos"].forEach((element) {
        Map<String,dynamic> _appinsidedata=element;
        final state_add=Wallpaper(id:_appinsidedata["id"],url:_appinsidedata["url"],photographer:_appinsidedata["photographer"],src:_appinsidedata["src"],favourite:false);
        wallE.add(state_add);
      });
    });
    print(wallE.length);
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getSearchWallpapers(widget.searchcontent);
    searchQuery.text=widget.searchcontent;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:AppDraw(),
      appBar:AppBar(
        leading:IconButton(
          icon:Icon(Icons.navigate_before),
          onPressed:(){
            wallE.clear();
            Navigator.popAndPushNamed(context,"/");
            },
        ),
        title:TextField(
          controller:searchQuery,
          onSubmitted:(text){
            //Search query submission here
            getSearchWallpapers(searchQuery.text);
            //for Debug purposes only it is shown
          },
          decoration:InputDecoration(
            hintText:"Enter your search query",
          ),
        ),

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
