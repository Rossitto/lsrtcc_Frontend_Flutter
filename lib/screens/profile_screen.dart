import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:lsrtcc_flutter/components/anything_list_view.dart';
import 'package:lsrtcc_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';
import 'package:lsrtcc_flutter/model/band.dart';
import 'package:lsrtcc_flutter/model/event.dart';
import 'package:lsrtcc_flutter/screens/all_registrations_screen.dart';
import 'package:lsrtcc_flutter/screens/choose_find_what.dart';
import 'package:lsrtcc_flutter/screens/my_bands_empty.dart';
import 'package:lsrtcc_flutter/screens/my_bands.dart';
import 'package:lsrtcc_flutter/screens/my_events.dart';
import 'package:lsrtcc_flutter/screens/my_events_empty.dart';
import 'package:lsrtcc_flutter/screens/my_pubs.dart';
import 'package:lsrtcc_flutter/screens/my_pubs_empty.dart';
import 'package:lsrtcc_flutter/screens/find_pub.dart';
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

  var userEventsResponseBody;
  var userEventsCount;
  var userEvents;
  var userConfirmedEvents;
  var userPendingEvents;

  @override
  void initState() {
    var msgRegisterBand = userdata.read('msg_register_band');
    if (msgRegisterBand != null) {
      Future(
        () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(msgRegisterBand),
              duration: Duration(seconds: 5),
            ),
          );
        },
      );
    }
    userdata.remove('msg_register_band');

    var msgRegisterPub = userdata.read('msg_register_pub');
    if (msgRegisterPub != null) {
      Future(
        () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(msgRegisterPub),
              duration: Duration(seconds: 5),
            ),
          );
        },
      );
    }
    userdata.remove('msg_register_pub');

    tabController = TabController(length: 4, vsync: this);

    _getData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void fetchUserEvents() async {
    userId = userdata.read('userId');
    userName = userdata.read('userName') ?? '';

    setState(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<ApiData>(context, listen: false).apiGetUserEvents(userId);
      });
      userEventsResponseBody = userdata.read('userEventsResponseBody');
      userEventsCount = userdata.read('userEventsCount');
      print('MyEvents userEventsCount: $userEventsCount');

      userEvents = userEventsCount == 0
          ? null
          : eventFromJson(userEventsResponseBody); // List<Event>

      userConfirmedEvents = userEventsCount == 0
          ? null
          : userEvents.where((i) => i.confirmed == true).toList();

      userPendingEvents = userEventsCount == 0
          ? null
          : userEvents.where((i) => i.confirmed == false).toList();
    });
  }

  Future<void> _getData() async {
    setState(() {
      fetchUserEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ApiData>(context, listen: false).apiGetUserBands(userId);
      Provider.of<ApiData>(context, listen: false).apiGetUserPubs(userId);
      Provider.of<ApiData>(context, listen: false).apiGetUserEvents(userId);
      Provider.of<ApiData>(context, listen: false).apiGetAllPubs();
      Provider.of<ApiData>(context, listen: false).apiGetAllBands();
    });
    var userBandsCount = userdata.read('userBandsCount') ?? 0;
    print('Profile userBandsCount: $userBandsCount');

    var userPubsCount = userdata.read('userPubsCount') ?? 0;
    print('Profile userPubsCount: $userPubsCount');

    var userEventsCount = userdata.read('userEventsCount') ?? 0;
    print('Profile userEventsCount: $userEventsCount');

    userId = userdata.read('userId');
    userName = userdata.read('userName') ?? '';

    userdata.remove('selectedPubJson');
    userdata.remove('selectedBandJson');

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
    print('screenHeight: $screenHeight');
    print('screenWidth: $screenWidth');

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
            elevation: 5.0,
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
                    child: Text("Minhas Bandas"),
                    value: userBandsCount == 0 ? MyBandsEmpty.id : MyBands.id,
                  ),
                  PopupMenuItem(
                    child: Text("Meus Pubs"),
                    value: userPubsCount == 0 ? MyPubsEmpty.id : MyPubs.id,
                  ),
                  PopupMenuItem(
                    child: Text("Meus Eventos"),
                    value:
                        userEventsCount == 0 ? MyEventsEmpty.id : MyEvents.id,
                  ),
                  // PopupMenuItem(
                  //   child: Text("Cadastrar Banda/Pub"),
                  //   value: AllRegistrationsScreen.id,
                  // ),
                  PopupMenuItem(
                    child: Text("Agendar Evento"),
                    value: ChooseFindWhat.id,
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
                        ),
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
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 100),
                    child: userEventsCount == 0
                        ? Center(
                            child: Text(
                              'Você não tem nenhum Evento ainda... $sadEmoji',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Text("Confirmados"),
                              SizedBox(
                                height: screenHeight * 0.01,
                              ),
                              userConfirmedEvents.length == 0
                                  ? Center(
                                      child: Text(
                                        '\n',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: userConfirmedEvents.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: ListTile(
                                            selected: false,
                                            selectedTileColor:
                                                Colors.lightBlue[50],
                                            isThreeLine: true,
                                            onTap: () {
                                              setState(() {
                                                // _selectedIndexPending = null;
                                                // _selectedIndexConfirmed = index;
                                                // selectedShowId =
                                                //     userConfirmedEvents[index].id;
                                              });
                                            },
                                            title: Text(
                                                userConfirmedEvents[index]
                                                    .showDatetime
                                                    .toString()
                                                    .substring(0, 16)),
                                            subtitle: Text(
                                              '$guitarEmoji ${userConfirmedEvents[index].band.name}\n$addressEmoji ${userConfirmedEvents[index].pub.name}',
                                              style: TextStyle(
                                                height: 1.25,
                                                wordSpacing: 1.0,
                                                letterSpacing: 1.0,
                                              ),
                                            ),
                                            leading: CircleAvatar(
                                              backgroundColor: Colors.green,
                                              child: Icon(Icons.event,
                                                  color: Colors.white),
                                            ),
                                            trailing: Icon(Icons
                                                .nightlife), // * em EVENT usar = Icons.nightlife
                                          ),
                                        );
                                      },
                                    ),
                            ],
                          ),
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
