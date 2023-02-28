import 'package:lovestatus/models/user_model.dart';
import 'package:lovestatus/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lovestatus/shared/shared.dart';
import 'package:provider/provider.dart';

import '../../shared/loading.dart';
import 'package:intl/intl.dart'; // Import intl package

DateTime date = DateTime.now(); // Lấy ngày của loveStatus
String formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss')
    .format(date); // Định dạng ngày theo kiểu 'dd/MM/yyyy'

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  late String _currentName = '';
  late String _currentLove = '';
  late int _currentStrength = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).currentUserData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // ? ở đây để báo cho chương trình biết là snapshot.data có thể trả về giá trị null và biến data
            // có thể mang giá trị null
            UserData? data = snapshot.data;
            
           

            return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'CẬP NHẬT DÒNG TRẠNG THÁI',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 78, 96, 197),
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      initialValue: data!.name,
                      validator: (val) =>
                          val!.isEmpty ? 'Tên không hợp lệ' : data!.name,
                      decoration: inputDecoration.copyWith(
                        hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                        fillColor: Color.fromARGB(255, 249, 167, 194),
                      ),
                      onChanged: (val) {
                        setState(() => _currentName = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: data!.love,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      validator: (val) => val!.isEmpty
                          ? 'Thôi nào hãy cho tôi biết tâm trạng của bạn !'
                          : data!.love,
                      decoration: inputDecoration.copyWith(
                        hintText: 'Tâm trạng hôm nay thế nào ...',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                        fillColor: Color.fromARGB(255, 249, 167, 194),
                      ),
                      onChanged: (val) {
                        setState(() => _currentLove = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Slider(
                        value: (_currentStrength == 0
                                ? data!.strength
                                : _currentStrength)
                            .toDouble(),
                        min: 100.0,
                        max: 900.0,
                        divisions: 8,
                        activeColor: Colors.pink[_currentStrength == 0
                            ? data!.strength
                            : _currentStrength],
                        inactiveColor: Colors.pinkAccent,
                        onChanged: (val) {
                          setState(() => _currentStrength = val.round());
                        }),
                    SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.pinkAccent,
                          elevation: 0,
                          textStyle: TextStyle(color: Colors.pinkAccent),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.pinkAccent, width: 2),
                              borderRadius: BorderRadius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Cập Nhật',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      onPressed: () async {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentLove == '' ? data.love : _currentLove,
                            _currentName == '' ? data.name : _currentName,
                            _currentStrength == 0
                                ? data!.strength
                                : _currentStrength,
                            formattedDate);
                      },
                    ),
                  ],
                ));
          } else {
            return Loading();
          }
        });
  }
}


// Dropdown

// DropdownButtonFormField(
//               decoration: inputDecoration.copyWith(
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
//                 ),
//               ),
//               value: _currentLove,
//               items: _loveList.map((val) {
//                 return DropdownMenuItem(
//                   value: val,
//                   child: Text('Love: $val'),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() => _currentLove = value!);
//               },
//             ),