import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:flutter/services.dart';
// import 'package:clipboard_manager/clipboard_manager.dart';
// import 'package:url_launcher/url_launcher.dart';
// import './privacy.dart';


class Contact extends StatefulWidget {
  // name({Key key}) : super(key: key);

  AwareState createState() => AwareState();
}

class AwareState extends State<Contact> {
  String quote = "+233204200444";
  bool Iscopied= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact",style: TextStyle(fontSize: 18),),
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
                                      // Container(
                                      //   alignment: Alignment.center,
                                      //   child: ListTile(
                                      //   title: Text("Fraudulent Use of the CCL Brand",style:GoogleFonts.gabriela() ,),
                                      //   subtitle: Text("Attempts have been made to defraud Internet shoppers by the unauthorized use of the CCL name and brand via email communications and graphics which appear, on the surface, to have originated from CCL. \n In most cases the communications concern the sale of consumer goods over the Internet where payment may be requested before the goods are delivered. \n Please be advised that CCL does not request payment in this manner. CCL only collects money due for official CCL related shipping expenses. \n This security notice does not affect the obligation of a consignee to pay shipping, customs, VAT or similar charges, where these are properly payable at the time of delivery. \n CCL accepts no responsibility for any costs, charges or payments made which were improperly incurred as a result of fraudulent activity."),
                                      // ),
                                      // ),
                                      

                                      
                                      Container(
                                        alignment: Alignment.center,
                                        child: ListTile(
                                          onTap: (){
                                          }
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