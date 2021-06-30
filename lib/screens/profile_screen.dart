import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:lsrtcc_flutter/components/anything_list_view.dart';
import 'package:lsrtcc_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';
import 'package:lsrtcc_flutter/model/band.dart';
import 'package:lsrtcc_flutter/screens/all_registrations_screen.dart';
import 'package:lsrtcc_flutter/screens/user_bands_pubs.dart';
import 'package:lsrtcc_flutter/screens/welcome_screen.dart';
import 'package:lsrtcc_flutter/services/backend_api.dart';
import 'package:provider/provider.dart';
import 'package:lsrtcc_flutter/services/api_data.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  final userdata = GetStorage();
  int userId;
  String userName;
  String bandName_1;
  String pubName_1;

  @override
  void initState() {
    var msg_register_band = userdata.read('msg_register_band');
    if (msg_register_band != null) {
      Future(
        () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(msg_register_band),
              duration: Duration(seconds: 5),
            ),
          );
        },
      );
    }
    userdata.remove('msg_register_band');

    var msg_register_pub = userdata.read('msg_register_pub');
    if (msg_register_pub != null) {
      Future(
        () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(msg_register_pub),
              duration: Duration(seconds: 5),
            ),
          );
        },
      );
    }
    userdata.remove('msg_register_pub');

    tabController = TabController(length: 4, vsync: this);

    userId = userdata.read('userId');
    userName = userdata.read('userName') ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ApiData>(context, listen: false).apiGetUserBands(userId);
      Provider.of<ApiData>(context, listen: false).apiGetUserPubs(userId);
    });
    bandName_1 = userdata.read('bandName_1');
    pubName_1 = userdata.read('pubName_1');

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    userId = userdata.read('userId');
    userName = userdata.read('userName') ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ApiData>(context, listen: false).apiGetUserBands(userId);
      Provider.of<ApiData>(context, listen: false).apiGetUserPubs(userId);
    });
    bandName_1 = userdata.read('bandName_1');
    pubName_1 = userdata.read('pubName_1');

    AlertDialog exitDialog = AlertDialog(
      title: Text('Deseja realmente sair?'),
      content:
          Text('Você terá que entrar com sua senha novamente para voltar.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancelar',
            style: TextStyle(
              color: Color(0xFF6200EE),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, WelcomeScreen.id);
          },
          child: Text(
            'Sair',
            style: TextStyle(
              color: Color(0xFF6200EE),
            ),
          ),
        ),
      ],
    );

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: screenHeight,
          maxWidth: screenWidth,
        ),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Perfil',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 25.0,
              ),
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
                  PopupMenuItem(
                    child: Text("Minha Banda/Pub"),
                    value: UserBandsPubs.id,
                  ),
                  PopupMenuItem(
                    child: Text("Cadastrar Banda/Pub"),
                    value: AllRegistrationsScreen.id,
                  ),
                  PopupMenuItem(child: Text("Sair"), value: 'EXIT'),
                ],
                onSelected: (route) {
                  print(route);
                  if (route == 'EXIT') {
                    print('EXIT escolhido!');

                    showDialog<void>(
                        context: context, builder: (context) => exitDialog);
                  } else {
                    Navigator.pushNamed(context, route);
                  }
                },
                child: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
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
                          child: Hero(
                            tag: 'logo',
                            child: CircleAvatar(
                              radius: 100,
                              backgroundImage: AssetImage(
                                  'images/profile1.jpg'), // images/logo.png
                              backgroundColor: Colors.white,
                            ),
                          ),
                          // child: Hero(
                          //   tag: 'logo',
                          //   child: Container(
                          //     height: 200.0,
                          //     child: Image.asset('images/logo.png'),
                          //   ),
                          // ),
                        ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          userName ?? '',
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
                    // TODO: COLOCAR AGENDA AQUI, ou MINHAS BANDAS / MEUS PUBS
                    child:
                        // // EXCEPTION: Vertical viewport was given unbounded height.
                        // AnythingListView(
                        //   titles: ["List 1", "List 2", "List 3"],
                        //   onTapTile: () {
                        //     print('Algum Card foi pressionado!');
                        //   },
                        // ),
                        Text('Banda: ${bandName_1} \nPub: ${pubName_1}'),
                  ),
                ],
              ),
            ),
          ),
          // bottomNavigationBar: Material(
          //   elevation: 30.0,
          //   color: Colors.blueAccent,
          //   shadowColor: Colors.black.withOpacity(0.5),
          //   child: TabBar(
          //     onTap: (index) {
          //       switch (index) {
          //         // case 1:
          //         //   Navigator.pushNamed(context, "/second");
          //         //   break;
          //         case 4:
          //           Navigator.pushNamed(context, AllRegistrationsScreen.id);
          //           break;
          //       }
          //     },
          //     controller: tabController,
          //     indicatorColor: Colors.white,
          //     tabs: <Widget>[
          //       Tab(
          //         icon: Icon(
          //           Icons.home,
          //           color: Colors.white,
          //         ),
          //       ),
          //       // Tab(
          //       //   icon: Icon(
          //       //     Icons.chat,
          //       //     color: Colors.white,
          //       //   ),
          //       // ),
          //       Tab(
          //         icon: Icon(
          //           Icons.search,
          //           color: Colors.white,
          //         ),
          //       ),
          //       Tab(
          //         icon: Icon(
          //           Icons.calendar_today,
          //           color: Colors.white,
          //         ),
          //       ),
          //       Tab(
          //         icon: Icon(
          //           Icons.person,
          //           color: Colors.white,
          //           // TODO: ir para a AllRegistrationsScreen
          //           // size: 40.0,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
