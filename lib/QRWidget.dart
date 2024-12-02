import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutterQRCode/database/database_controller.dart';

class QRWidget extends StatelessWidget {
  QRWidget({super.key});

  final DatabaseController controller = DatabaseController.instance();
  Future<String> getData() async
  {
    print("getData");
    var data =  await controller.getEntry();
    print("getData exit");
    return data;
  }
  @override
  Widget build(BuildContext context){
    print(controller.getUser().uid);
    print("Builder");
    return Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _list(),
          ],
        )
    );

  }
  _list() => Expanded(
        child: FutureBuilder<String>(
          builder: (context, snapshot) {
            print("futureBuilder");
            if (snapshot.connectionState == ConnectionState.none ||
                !snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            print("futureBuilder2");
            String data = snapshot.data.toString();
            if(data!="None")
            {
              return Center(child: QrImageView(data: data, version: QrVersions.auto,size: 200.0),);
            }
            else
            {
              return Center(child: Text("Sorry, there is nothing for you here"),);
            }
          },
          future: getData(),
        ),
      );
}
