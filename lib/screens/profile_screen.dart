import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:lsrtcc_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';
import 'package:lsrtcc_flutter/model/band.dart';
import 'package:lsrtcc_flutter/screens/welcome_screen.dart';
import 'package:lsrtcc_flutter/services/backend_api.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  final userdata = GetStorage();

  String get userName => userdata.read('userName');

  @override
  void initState() {
    super.initState();
    var userName = userdata.read('userName');
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    print('context userName: ${userName}');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Perfil',
          style: TextStyle(color: Colors.white70),
        ),
        elevation: 0,
        backgroundColor: Colors.blueAccent[700],
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        //   onPressed: () {
        //     // Navigator.pop(context);
        //   },
        // ),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext bc) => [
              PopupMenuItem(child: Text("Sair"), value: WelcomeScreen.id),
            ],
            onSelected: (route) {
              print(route);
              Navigator.pushNamed(context, route);
            },
            child: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),

          // PopupMenuButton(
          //   onSelected: (dynamic index) {
          //     print('index is $index');
          //     Navigator.pushNamed(context, WelcomeScreen.id);
          //   },
          //   child: Icon(
          //     Icons.more_vert,
          //     color: Colors.white,
          //   ),
          //   itemBuilder: (context) {
          //     return List.generate(1, (index) {
          //       return PopupMenuItem(
          //         child: Text('Sair'),
          //       );
          //     });
          //   },
          // ),

          // IconButton(
          //   icon: Icon(
          //     Icons.more_vert,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     // TODO: menu 3 pontinhos superior direito: 1) alterar foto de perfil. 2) alterar senha. 3) alterar nickname? 4) alterar e-mail? 5) ver minhas bandas?
          //   },
          // )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2 - 40,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.7),
                    blurRadius: 20,
                    spreadRadius: 10,
                  ),
                ],
                color: Colors.blueAccent[700],
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                children: <Widget>[
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent[700],
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue[900],
                          spreadRadius: 2,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('images/profile1.jpg'),
                    ),
                  ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    userName,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 15.0,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20, right: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       // TODO: aqui são os ícones abaixo da foto de perfil. Não precisará.
                  //       Container(
                  //         height: 60,
                  //         width: 60,
                  //         decoration: BoxDecoration(
                  //           color: Colors.blueAccent[700],
                  //           borderRadius: BorderRadius.circular(30),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.blueAccent[700],
                  //               spreadRadius: 1,
                  //             ),
                  //           ],
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(4.0),
                  //           child: Column(
                  //             children: [
                  //               Icon(
                  //                 Icons.photo_camera,
                  //                 color: Colors.white,
                  //               ),
                  //               SizedBox(
                  //                 height: 3,
                  //               ),
                  //               Text(
                  //                 'Camera',
                  //                 style: TextStyle(
                  //                   color: Colors.white,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 100),
              child: Text('COLOCAR AGENDA AQUI, ou MINHAS BANDAS / MEUS PUBS'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        color: Colors.blueAccent,
        shadowColor: Colors.black.withOpacity(0.5),
        child: TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.chat,
                color: Colors.white,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.person,
                color: Colors.white,
                // size: 40.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
