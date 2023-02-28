import 'package:lovestatus/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authenticate/authenticate.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});
  

  @override
  Widget build(BuildContext context) {
    // lắng nghe dữ liệu user từ luồng stream trả về thông qua provider  
    // Móc dữ liệu ra xài vì thằng cha nó được bao bởi StreamProvider 
    //Lớp cha nó là lớp main.dart
    
    final user = Provider.of<UserModel>(context);

    return user !=null ?  Home(): Authenticate();
  }
}