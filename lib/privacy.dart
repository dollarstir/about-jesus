import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:flutter/services.dart';
// import 'package:clipboard_manager/clipboard_manager.dart';
// import 'package:url_launcher/url_launcher.dart';
// import './privacy.dart';


class Privacy extends StatefulWidget {
  // name({Key key}) : super(key: key);

  AwareState createState() => AwareState();
}

class AwareState extends State<Privacy> {
  String quote = "+233204200444";
  bool Iscopied= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy",style: TextStyle(fontSize: 18),),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Container(
                            width: 350,
                            height: 500,
                            // color: Colors.black54,
                            margin: EdgeInsets.only(top: 5),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              // color: Colors.blue,
                              elevation: 15,
                              child: Scrollbar(
                                child: ListView(
                                
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: ListTile(
                                        title: Text("Privacy Policy",style:GoogleFonts.gabriela() ,),
                                        subtitle: Text("The app doesn't collect any user personal data as, for example, name, picture or location. \n· Consequently, the app doesn't share any personal information with any other entity or third parties.\n· We allow third-party companies to serve ads and collect certain anonymous information when you visit our app. These companies may use anonymous information such as your Google Advertising ID, your device type and version, browsing activity, location and other technical data relating to your device, in order to provide advertisements. "),
                                      ),
                                      ),
                                      

                                      
                                      


                                      


                                      // 
                                    ],
                                  )
                                ],
                              ),
                              ),
                            ),
                          ),
        ),
      ),

    );
  }
}