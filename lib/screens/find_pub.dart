import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';
import 'package:lsrtcc_flutter/constants.dart';
import 'package:lsrtcc_flutter/model/pub.dart';
import 'package:lsrtcc_flutter/screens/date_time_picker.dart';
import 'package:lsrtcc_flutter/screens/find_band.dart';
import 'package:lsrtcc_flutter/screens/my_bands_empty.dart';
import 'package:lsrtcc_flutter/services/api_data.dart';
import 'package:provider/provider.dart';

class FindPub extends StatefulWidget {
  static const String id = 'find_pub';

  @override
  _FindPubState createState() => _FindPubState();
}

class _FindPubState extends State<FindPub> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  final userdata = GetStorage();
  var _selectedIndex;
  var selectedPubJson;
  var selectedBandJson;
  bool isFinding;

  @override
  void initState() {
    selectedBandJson = userdata.read('selectedBandJson');
    isFinding = selectedBandJson == null ? true : false;

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userId = userdata.read('userId');
    var userName = userdata.read('userName') ?? '';

    var userBandsCount = userdata.read('userBandsCount') ?? 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      isFinding == true
          ? Provider.of<ApiData>(context, listen: false).apiGetAllPubs()
          : Provider.of<ApiData>(context, listen: false).apiGetUserPubs(userId);
    });

    var pubsResponseBody = isFinding == true
        ? userdata.read('allPubsResponseBody')
        : userdata.read('userPubsResponseBody');
    var pubsCount = isFinding == true
        ? userdata.read('allPubsCount')
        : userdata.read('userPubsCount');
    print('MyPubs pubsCount: $pubsCount');

    var allPubs = pubsCount == 0 ? null : pubFromJson(pubsResponseBody);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return
        // ? Aqui tinha aquele SingleChildScrollableWidget usando o screenHeight e ScreenWidth. Removi em 03/07/2021 11h45. Se der ruim, incluir novamente.
        Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isFinding == true ? 'Encontrar Pub' : 'Escolher Pub',
          style: TextStyle(color: Colors.white70),
        ),
        elevation: 5.0,
        backgroundColor: Colors.blueAccent[700],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.067),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 20),
                child: pubsCount == 0
                    ? Center(
                        child: Text(
                          isFinding == true
                              ? 'Nenhum Pub foi cadastrado ainda em nossa base... $sadEmoji'
                              : 'Você ainda não tem nenhum pub... $sadEmoji',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: allPubs.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              selected: index == _selectedIndex,
                              selectedTileColor: Colors.lightBlue[50],
                              isThreeLine: true,
                              onLongPress: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(allPubs[index].name +
                                        ' LongPressed !'), // começa no 1 e não no 0
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                                selectedPubJson = allPubs[index].toJson();
                                userdata.remove('selectedPubJson');
                                userdata.write(
                                    'selectedPubJson', selectedPubJson);
                                var selectedPubName = allPubs[index].name;
                                userdata.write(
                                    'selectedPubName', selectedPubName);
                              },
                              title: Text(allPubs[index].name),
                              subtitle: Text(
                                '$cityEmoji ${allPubs[index].city}\n$addressEmoji ${allPubs[index].address}',
                                style: TextStyle(
                                  height: 1.25,
                                  wordSpacing: 1.0,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              leading: CircleAvatar(
                                child: Image.asset('images/logo_not_alpha.png'),
                              ),
                              trailing: Icon(Icons.nightlife),
                            ),
                          );
                        },
                      ),
              ),
            ),
            // Divider(
            //   height: screenHeight * 0.01,
            //   thickness: 1,
            // ),
            RoundedButton(
              color: Colors.blueAccent,
              text: isFinding == true
                  ? 'Escolher Banda para Agendar Evento'
                  : 'Escolher Data e Hora do Evento',
              onPressed: selectedPubJson == null
                  ? () {
                      setState(
                        () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text(
                                '$personGesturingNoEmoji OPA!\nNenhum pub selecionado!',
                                textAlign: TextAlign.center,
                              ),
                              content: Text(
                                  'Todo show precisa de uma casa... selecione um Pub! $badassEmoji$whiskyEmoji',
                                  textAlign: TextAlign.center),
                              elevation: 24.0,
                            ),
                            barrierDismissible: true,
                          );
                        },
                      );
                    }
                  : () {
                      Navigator.pushNamed(
                          context,
                          isFinding == true
                              ? userBandsCount > 0
                                  ? FindBand.id
                                  : MyBandsEmpty.id
                              : DateTimePicker.id);
                    },
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
