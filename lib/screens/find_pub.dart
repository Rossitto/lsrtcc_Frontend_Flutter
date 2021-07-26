import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lsrtcc_flutter/constants.dart';
import 'package:lsrtcc_flutter/model/pub.dart';
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

  @override
  void initState() {
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ApiData>(context, listen: false).apiGetAllPubs();
    });
    var allPubsResponseBody = userdata.read('allPubsResponseBody');
    var allPubsCount = userdata.read('allPubsCount');
    print('MyPubs allPubsCount: $allPubsCount');

    var allPubs = allPubsCount == 0
        ? null
        : pubFromJson(allPubsResponseBody); // List<Pub>

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return
        // ? Aqui tinha aquele SingleChildScrollableWidget usando o screenHeight e ScreenWidth. Removi em 03/07/2021 11h45. Se der ruim, incluir novamente.
        Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Encontrar Pub',
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
        // TODO: reaproveitar todo esse container para Pubs
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 20),
                child: allPubsCount == 0
                    ? Center(
                        child: Text(
                          'Você não pertence a nenhuma band ainda... $sadEmoji',
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
                              // ? TODO: ir para uma página de perfil do Pub com mais informações?
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(allPubs[index].name +
                                        ' pressionado!'), // começa no 1 e não no 0
                                    duration: Duration(seconds: 1),
                                  ),
                                );
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
                              trailing: Icon(Icons
                                  .nightlife), // * em PUB usar = Icons.nightlife
                            ),
                          );
                        },
                      ),
              ),
            ),
            // RoundedButton(
            //   color: Colors.blueAccent,
            //   text: 'Cadastrar Pub',
            //   onPressed: () {
            //     Navigator.pushNamed(context, RegisterPubScreen.id);
            //   },
            // ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
