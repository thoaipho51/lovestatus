import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lovestatus/screens/home/settings_form.dart';
import 'package:flutter/material.dart';

import '../../models/lovestatus_model.dart';
import '../../services/auth.dart';
import 'package:lovestatus/services/database.dart';
import 'package:provider/provider.dart';
import 'lovestatus_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('./assets/images/bg_form.jpg'),
                  fit: BoxFit.cover
                )
              ),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<LoveStatus>?>.value(
      value: DatabaseService(uid: '').loveSatus,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.pink[200],
        appBar: AppBar(
          title: Text('NHẬT KÝ TÌNH YÊU'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 249, 134, 134),
          // elevation: 0.0,
          leading: IconButton(
            tooltip: 'Cài đặt',
            icon: Icon(
              Icons.settings,
            ),
            onPressed: () {
              // hành động khi bấm vào biểu tượng
              _showSettingPanel();
            },
          ),
          actions: [
            TextButton(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.surfing_outlined,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    Text(
                      'Đăng xuất',
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    )
                  ]),
              onPressed: () async {
                await _auth.sigOut();
              },
            ),
          ],
        ),
        // body: Container(),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('./assets/images/bg_love.jpg'),
                    fit: BoxFit.fill)),
            child: LoveStatusList()),
      ),
    );
  }
}
