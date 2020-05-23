import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './model/wallpaperdata.dart';
import 'overviewPage.dart';
class Favour extends StatefulWidget {
  @override
  _FavourState createState() => _FavourState();
}
class _FavourState extends State<Favour> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Favourites"),
        leading:IconButton(
          icon:Icon(Icons.navigate_before),
          onPressed: (){
            Navigator.of(context).pop();
            },
        ),
      ),
      body:Provider.of<FireArray>(context).fireBase.length!=0?GridView.builder(

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
                      return Overview(imgsrc:Provider.of<FireArray>(context).fireBase[index].Fav_Img,
                        id:Provider.of<FireArray>(context).fireBase[index].ID,
                        view:true,
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
                  child:Image.network(Provider.of<FireArray>(context).fireBase[index].Fav_Img,fit:BoxFit.cover,),
                ),
              )
          ),
        );

      },itemCount:Provider.of<FireArray>(context).fireBase.length,):Center(child: Text("No favourites",style:TextStyle(
        fontSize:25.0,
        color:Colors.grey
      ),))

    );
  }
}
