import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './presentation/my_flutter_app_icons.dart' as cust;
class AppDraw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
         
         child:Container(
           decoration:BoxDecoration(
             border:Border.all(color:Colors.grey[800],
                 width:1.0),

           ),

           child: Column(

             children: <Widget>[
               Container(


                 margin:EdgeInsets.fromLTRB(0.0, 60.0,0.0,0.0),
                 child:CircleAvatar(

                   backgroundColor:Colors.green,
                   radius:65.0,

                   child:CircleAvatar(
                     radius:60,
                     backgroundImage:NetworkImage("https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                   ),
                 ),
               ),
               SizedBox(
                 height:15.0,
               ),
               Center(
                 child: Text("Jesintharnold",style:TextStyle(
                   fontSize:18.0,
                   fontWeight:FontWeight.bold

                 ),),
               ),SizedBox(
                 height:5.0,
               ),
               Text("Jesintharnold@gmail.com",style:TextStyle(
                 fontSize:17.0,
               ),),
               Divider(
                 thickness:1.0,
                 color:Colors.black54,
               ),

               ListTile(
                 leading:IconButton(
                   icon:Icon(Icons.star),
                   onPressed: (){

                   },
                 ),
                 title:Text("Favourites",style:TextStyle(
                   fontSize:18.0
                 ),),
                 subtitle:Text("Tap on to see Favourites"),
                 onTap:(){
                     Navigator.pushNamed(context,"/Favour");
                 },
               ),

               SizedBox(height:50.0,),


                Container(
                  height:200,

//
//                 child: Row(
//                   mainAxisAlignment:MainAxisAlignment.center,
//                   crossAxisAlignment:CrossAxisAlignment.end,
//                   children: <Widget>[
//                     IconButton(
//                       icon:Icon(Icons.insert_emoticon),
//                       onPressed:(){
//
//                       },
//                     ),
//                     IconButton(
//                       icon:Icon(Icons.insert_emoticon),
//                       onPressed:(){
//
//                       },
//                     ),
//                     IconButton(
//                       icon:Icon(Icons.insert_emoticon),
//                       onPressed:(){
//
//                       },
//                     )
//                   ],
//                 ),
               )
             ],
           ),
         ),
    );
  }
}
