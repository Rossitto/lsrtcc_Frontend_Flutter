import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';
import 'package:lsrtcc_flutter/constants.dart';
import 'package:lsrtcc_flutter/model/band.dart';
import 'package:lsrtcc_flutter/screens/date_time_picker.dart';
import 'package:lsrtcc_flutter/screens/find_pub.dart';
import 'package:lsrtcc_flutter/screens/my_pubs_empty.dart';
import 'package:lsrtcc_flutter/services/api_data.dart';
import 'package:provider/provider.dart';

class FindBand extends StatefulWidget {
  static const String id = 'find_band';

  @override
  _FindBandState createState() => _FindBandState();
}

class _FindBandState extends State<FindBand>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  final userdata = GetStorage();
  var _selectedIndex;
  var selectedPubJson;
  var selectedBandJson;
  bool isFinding;

  @override
  void initState() {
    selectedPubJson = userdata.read('selectedPubJson');
    isFinding = selectedPubJson == null ? true : false;

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

    var userPubsCount = userdata.read('userPubsCount') ?? 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      isFinding == true
          ? Provider.of<ApiData>(context, listen: false).apiGetAllBands()
          : Provider.of<ApiData>(context, listen: false)
              .apiGetUserBands(userId);
    });

    var bandsResponseBody = isFinding == true
        ? userdata.read('allBandsResponseBody')
        : userdata.read('userBandsResponseBody');
    var bandsCount = isFinding == true
        ? userdata.read('allBandsCount')
        : userdata.read('BandsCount');
    print('MyBands bandsCount: $bandsCount');

    var allBands = bandsCount == 0 ? null : bandFromJson(bandsResponseBody);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return
        // ? Aqui tinha aquele SingleChildScrollableWidget usando o screenHeight e ScreenWidth. Removi em 03/07/2021 11h45. Se der ruim, incluir novamente.
        Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isFinding == true ? 'Encontrar Banda' : 'Escolher minha Banda',
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
                child: bandsCount == 0
                    ? Center(
                        child: Text(
                          isFinding == true
                              ? 'Nenhuma Banda foi cadastrada ainda em nossa base... $sadEmoji'
                              : 'Você não pertence a nenhuma banda ainda... $sadEmoji',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: allBands.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              selected: index == _selectedIndex,
                              selectedTileColor: Colors.lightBlue[50],
                              isThreeLine: true,
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                                selectedBandJson = allBands[index].toJson();
                                userdata.remove('selectedBandJson');
                                userdata.write(
                                    'selectedBandJson', selectedBandJson);

                                var selectedBandName = allBands[index].name;
                                userdata.write(
                                    'selectedBandName', selectedBandName);
                              },
                              title: Text(allBands[index].name),
                              subtitle: Text(
                                '$musicalNotesEmoji ${allBands[index].style}\n$personEmoji ${allBands[index].membersNum}',
                                style: TextStyle(
                                  height: 1.25,
                                  wordSpacing: 1.0,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              leading: CircleAvatar(
                                child: Image.asset('images/logo_not_alpha.png'),
                              ),
                              trailing: Icon(Icons.star_outline_sharp),
                            ),
                          );
                        },
                      ),
              ),
            ),
            RoundedButton(
              color: Colors.blueAccent,
              text: isFinding == true
                  ? 'Escolher meu Pub para Agendar Evento'
                  : 'Escolher Data e Hora do Evento',
              onPressed: selectedBandJson == null
                  ? () {
                      setState(
                        () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text(
                                '$personGesturingNoEmoji OPA!\nNenhuma banda selecionada!',
                                textAlign: TextAlign.center,
                              ),
                              content: Text(
                                  'Show sem banda é playback... selecione uma! $drumEmoji$badassEmoji',
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
                              ? userPubsCount > 0
                                  ? FindPub.id
                                  : MyPubsEmpty.id
                              : DateTimePicker.id);
                    },

              //   () {
              //     Navigator.pushNamed(context, DateTimePicker.id);
              //   },
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
