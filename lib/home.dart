import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_radio/flutter_radio.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter/services.dart';
import './you1.dart';
import './fb.dart';
import './yt.dart';
import './contact.dart';
import 'package:share/share.dart';
import './privacy.dart';
import './location.dart';
import './mess.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import './home.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  var playerState = FlutterRadioPlayer.flutter_radio_paused;

  var volume = 0.8;

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const streamUrl = "http://stream.zeno.fm/c86n9q58e2zuv";

  bool isPlaying = false;

  FlutterRadioPlayer _flutterRadioPlayer = new FlutterRadioPlayer();
  bool isvisible1 = false;
  bool isvisible2 = false;
  bool isvisible3 = false;
  bool isvisible4 = false;
  bool isvisible5 = false;
  bool isvisible6 = false;

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  openwhatsapp() async {
    var whatsapp = "+233204200444";
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // audioStart();
    // playingStatus();
    initRadioService();
  }

  Future<void> initRadioService() async {
    try {
      await _flutterRadioPlayer.init("All About Jesus", "Live",
          "http://stream.zeno.fm/c86n9q58e2zuv", "false");
    } on PlatformException {
      print("Exception occurred while trying to register the services.");
    }
  }

  Future<void> audioStart() async {
    await FlutterRadio.audioStart();
    print('Audio Start OK');
  }

  @override
  Widget build(BuildContext context) {
    var vol = (widget.volume * 100).toStringAsFixed(0);
    return Scaffold(
      // appBar: new AppBar(
      //   title: const Text('Audio Plugin Android'),
      // ),
      body: Container(
          color: Color.fromRGBO(245, 104, 22, 1),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        // topRight: Radius.circular(70),
                        ),

                    //     image: DecorationImage(fit: BoxFit.fill,
                    //   image: AssetImage('assets/images/bg.jpg'),
                    // ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Container(
                      //   margin: EdgeInsets.only(top: 30, left: 20),
                      //   //  height: 200,

                      //   child: ListTile(
                      //     leading: Container(
                      //       decoration: BoxDecoration(
                      //           borderRadius:
                      //               BorderRadius.all(Radius.circular(50))),
                      //       child: Image(
                      //         image: AssetImage('assets/images/wow.gif'),
                      //         height: 230,
                      //       ),
                      //     ),
                      //     title: Text(
                      //       "JESUS IS THE ANSWER",
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //     subtitle: Text("online",
                      //         style: TextStyle(color: Colors.greenAccent)),
                      //   ),
                      // ),
                      // Container(
                      //   width: 260,
                      //   height: 50,
                      //   margin: EdgeInsets.only(top: 20),
                      //   child: RaisedButton.icon(
                      //     onPressed: () {
                      //       FlutterRadio.playOrPause(url: streamUrl);
                      //       if (isPlaying) {
                      //         setState(() {
                      //           isPlaying = false;
                      //         });
                      //         print(isPlaying);
                      //       } else {
                      //         setState(() {
                      //           isPlaying = true;
                      //         });

                      //         print(isPlaying);
                      //       }
                      //     },

                      //     shape: RoundedRectangleBorder(

                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(30.0))),
                      //     label: Text(
                      //       isPlaying ? "STOP" : "PLAY",
                      //       style: TextStyle(color: Colors.black),
                      //     ),
                      //     icon: Icon(
                      //       isPlaying ? Icons.pause : Icons.play_arrow,
                      //       color: Colors.red,
                      //     ),
                      //     textColor: Colors.white,
                      //     // splashColor: Colors.red,
                      //     color: Colors.white,
                      //   ),
                      // ),

                      StreamBuilder(
                          stream: _flutterRadioPlayer.isPlayingStream,
                          initialData: widget.playerState,
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            String returnData = snapshot.data;
                            print("object data: " + returnData);
                            switch (returnData) {
                              case FlutterRadioPlayer.flutter_radio_stopped:
                                return RaisedButton(
                                    child: Text("Start listening now"),
                                    onPressed: () async {
                                      await initRadioService();
                                    });
                                break;
                              case FlutterRadioPlayer.flutter_radio_loading:
                                return Text("Loading stream...");
                              case FlutterRadioPlayer.flutter_radio_error:
                                return RaisedButton(
                                    child: Text("Retry ?"),
                                    onPressed: () async {
                                      await initRadioService();
                                    });
                                break;
                              default:
                                return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.16,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.all(
                                                  (Radius.circular(100))),
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: AssetImage(
                                                    'assets/images/bg.jpg'),
                                              ),
                                            ),
                                          ),
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                // width:50,
                                                // height: 10,
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      245, 104, 22, 1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(100),
                                                  ),
                                                ),

                                                child: IconButton(
                                                  onPressed: () async {
                                                    print(
                                                        "button press data: " +
                                                            snapshot.data
                                                                .toString());
                                                    await _flutterRadioPlayer
                                                        .playOrPause();
                                                  },
                                                  icon: snapshot.data ==
                                                          FlutterRadioPlayer
                                                              .flutter_radio_playing
                                                      ? Icon(
                                                          Icons.pause,
                                                          size: 20,
                                                          color: Colors.white,
                                                        )
                                                      : Icon(
                                                          Icons.play_arrow,
                                                          size: 20,
                                                          color: Colors.white,
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                      // IconButton(
                                      //     onPressed: () async {
                                      //       await _flutterRadioPlayer.stop();
                                      //     },
                                      //     icon: Icon(Icons.stop))
                                    ]);
                                break;
                            }
                          }),

                      // StreamBuilder<String>(
                      // initialData: "",
                      // stream: FlutterRadio.metadataStream(streamUrl),
                      // builder: (context, snapshot) {
                      //   return Text(snapshot.data);
                      // }),
                      Container(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Slider(
                                value: widget.volume,
                                min: 0,
                                max: 1.0,
                                activeColor: Color.fromRGBO(245, 104, 22, 1),
                                onChanged: (value) => setState(() {
                                  widget.volume = value;
                                  _flutterRadioPlayer.setVolume(widget.volume);
                                }),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 1),
                              child: Text(vol + "%"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 40, right: 40, top: 5, bottom: 5),
                        margin: EdgeInsets.only(left: 5, right: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(245, 104, 22, 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: StreamBuilder(
                              initialData: "",
                              stream: _flutterRadioPlayer.metaDataStream,
                              builder: (context, snapshot) {
                                var mss = snapshot.data.toString();
                                var ms1 = mss.replaceAll('ICY', '');
                                var ms2 = ms1.replaceAll("title", '');
                                var ms3 = ms2.replaceAll('"', '');
                                var ms4 = ms3.replaceAll("url\=null,", '');
                                var ms5 = ms4.replaceAll("rawMetadata", '');
                                var ms6 = ms5.replaceAll(".length", '');
                                var ms7 = ms6.replaceAll("=", '');
                                var ms8 = ms7.replaceAll("\:", '');
                                return Text(ms8,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white));
                                // print(snapshot.data[0]);
                              }),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                          top: 45,
                        ),
                        height: 50,
                        padding: EdgeInsets.only(left: 1, right: 1),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(245, 104, 22, 1),
                          // borderRadius: BorderRadius.only(
                          //   topRight: Radius.circular(30),
                          //   topLeft: Radius.circular(30),
                          // ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton.icon(
                              onPressed: () {
                                Share.share(
                                    "http://stream.zeno.fm/c86n9q58e2zuv",
                                    subject: 'Listen to Live radio');
                                // final RenderBox box = context.findRenderObject();
                                // Share.share("dollar",
                                //     subject: "dollar",
                                //     sharePositionOrigin:
                                //         box.localToGlobal(Offset.zero) &
                                //             box.size);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              label: Text(
                                '',
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(
                                Icons.share,
                                color: Colors.white,
                              ),
                              textColor: Colors.white,
                              // splashColor: Colors.red,
                              color: Color(0xffFE5D31),
                            ),
                            RaisedButton.icon(
                              onPressed: () async {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) {
                                //     return Contact();
                                //   }),
                                // );

                                _makePhoneCall("tel:+233204200444");
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              label: Text(
                                '',
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(
                                Icons.call,
                                color: Colors.white,
                              ),
                              textColor: Colors.white,
                              // splashColor: Colors.red,
                              color: Color(0xffFE5D31),
                            ),
                            RaisedButton.icon(
                              onPressed: () {
                                openwhatsapp();
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              label: Text(
                                '',
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(
                                Icons.chat_bubble,
                                color: Colors.white,
                              ),
                              textColor: Colors.white,
                              // splashColor: Colors.red,
                              color: Color(0xffFE5D31),
                            ),
                            RaisedButton.icon(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Mess();
                                }));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              label: Text(
                                '',
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(
                                Icons.folder_open,
                                color: Colors.white,
                              ),
                              textColor: Colors.white,
                              // splashColor: Colors.red,
                              color: Color(0xffFE5D31),
                            ),
                          ],
                          // SizedBox(height: 5,)
                        ),
                        // SizedBox(height: 5,),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),

                    //     image: DecorationImage(fit: BoxFit.fill,
                    //   image: AssetImage('assets/images/bg.jpg'),
                    // ),
                  ),
                  // color: Colors.white,
                  // padding: EdgeInsets.only(top: 10, left: 10),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        // decoration: BoxDecoration(
                        //   border: Border(bottom: BorderSide(width: 1)
                        // ),

                        child: Card(
                          // elevation: 0,
                          child: ListTile(
                            onTap: () async {
                              setState(() {
                                isvisible1 = false;
                                isvisible2 = false;
                                isvisible3 = false;
                                isvisible4 = false;
                                isvisible5 = false;
                                isvisible6 = true;
                              });
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) {
                              //     return Facebook();
                              //   }),
                              // );

                              _flutterRadioPlayer.setUrl(
                                  "http://stream.zeno.fm/c86n9q58e2zuv",
                                  "false");

                              await _flutterRadioPlayer.play();
                            },
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Image(
                                image: AssetImage('assets/images/radio.png'),
                                height: 30,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Jesus is the answer"),
                                Visibility(
                                  visible: isvisible6,
                                  child: Image(
                                    image: AssetImage('assets/images/h79.gif'),
                                    height: 30,
                                    // width:30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //   border: Border(bottom: BorderSide(width: 1)
                        // ),

                        child: Card(
                          // elevation: 0,
                          child: ListTile(
                            onTap: () async {
                              setState(() {
                                isvisible1 = true;
                                isvisible2 = false;
                                isvisible3 = false;
                                isvisible4 = false;
                                isvisible5 = false;
                                isvisible6 = false;
                              });
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) {
                              //     return Facebook();
                              //   }),
                              // );

                              _flutterRadioPlayer.setUrl(
                                  "http://stream.zeno.fm/utn6pztk2v8uv",
                                  "false");

                              await _flutterRadioPlayer.play();
                            },
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Image(
                                image: AssetImage('assets/images/radio.png'),
                                height: 30,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("English Bible Radio    "),
                                Visibility(
                                  visible: isvisible1,
                                  child: Image(
                                    image: AssetImage('assets/images/h79.gif'),
                                    height: 30,
                                    // width:30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //   border: Border(bottom: BorderSide(width: 1)
                        // ),

                        child: Card(
                          child: ListTile(
                            onTap: () async {
                              setState(() {
                                isvisible1 = false;
                                isvisible2 = true;
                                isvisible3 = false;
                                isvisible4 = false;
                                isvisible5 = false;
                                isvisible6 = false;
                              });
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) {
                              //     return WebViewClass();
                              //   }),
                              // );

                              _flutterRadioPlayer.setUrl(
                                  "http://stream.zeno.fm/shs0epmb4v8uv",
                                  "false");

                              await _flutterRadioPlayer.play();
                            },
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Image(
                                image: AssetImage('assets/images/radio.png'),
                                height: 30,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("English Preaching Radio"),
                                Visibility(
                                  visible: isvisible2,
                                  child: Image(
                                    image: AssetImage('assets/images/h79.gif'),
                                    height: 30,
                                    // width:30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //   border: Border(bottom: BorderSide(width: 1)
                        // ),

                        child: Card(
                          child: ListTile(
                            onTap: () async {
                              setState(() {
                                isvisible1 = false;
                                isvisible2 = false;
                                isvisible3 = true;
                                isvisible4 = false;
                                isvisible5 = false;
                                isvisible6 = false;
                              });

                              _flutterRadioPlayer.setUrl(
                                  "http://stream.zeno.fm/q8xah9zh2v8uv",
                                  "false");

                              await _flutterRadioPlayer.play();
                            },
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Image(
                                image: AssetImage('assets/images/radio.png'),
                                height: 30,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Jesus is God                     "),
                                Visibility(
                                  visible: isvisible3,
                                  child: Image(
                                    image: AssetImage('assets/images/h79.gif'),
                                    height: 30,
                                    // width:30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //   border: Border(bottom: BorderSide(width: 1)
                        // ),

                        child: Card(
                          child: ListTile(
                            onTap: () async {
                              setState(() {
                                isvisible1 = false;
                                isvisible2 = false;
                                isvisible3 = false;
                                isvisible4 = true;
                                isvisible5 = false;
                                isvisible6 = false;
                              });

                              _flutterRadioPlayer.setUrl(
                                  "http://stream.zeno.fm/br6kb8tk2v8uv",
                                  "false");

                              await _flutterRadioPlayer.play();
                            },
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Image(
                                image: AssetImage('assets/images/radio.png'),
                                height: 30,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Twi Bible Radio                 "),
                                Visibility(
                                  visible: isvisible4,
                                  child: Image(
                                    image: AssetImage('assets/images/h79.gif'),
                                    height: 30,
                                    // width:30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //   border: Border(bottom: BorderSide(width: 1)
                        // ),

                        child: Card(
                          child: ListTile(
                            onTap: () async {
                              setState(() {
                                isvisible1 = false;
                                isvisible2 = false;
                                isvisible3 = false;
                                isvisible4 = false;
                                isvisible5 = true;
                                isvisible6 = false;
                              });
                              _flutterRadioPlayer.setUrl(
                                  "http://stream.zeno.fm/emvrn3kb4v8uv",
                                  "false");
                              await _flutterRadioPlayer.play();
                            },
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Image(
                                image: AssetImage('assets/images/radio.png'),
                                height: 30,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Twi Preaching Radio"),
                                Visibility(
                                  visible: isvisible5,
                                  child: Image(
                                    image: AssetImage('assets/images/h79.gif'),
                                    height: 30,
                                    // width:30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),

      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.flip,
        backgroundColor: Color.fromRGBO(245, 104, 22, 1),
        items: [
          TabItem(icon: Icons.radio_rounded, title: 'Radio'),
          TabItem(icon: Icons.folder_open, title: 'Godly messages'),
          TabItem(icon: Icons.privacy_tip_outlined, title: 'Privacy'),
        ],
        onTap: (index) {
          print(index);
          if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Privacy();
            }));
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Mess();
            }));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Home();
            }));
          }
        },
      ),
    );
  }

  Future playingStatus() async {
    bool isP = await FlutterRadio.isPlaying();
    setState(() {
      isPlaying = isP;
    });
    print(isPlaying);
  }
}
