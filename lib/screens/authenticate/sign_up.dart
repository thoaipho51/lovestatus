import 'package:lovestatus/services/auth.dart';
import 'package:lovestatus/shared/loading.dart';
import 'package:flutter/material.dart';

import 'package:lovestatus/shared/shared.dart';

class SignUp extends StatefulWidget {
  final Function toggleChangeView;
  const SignUp({super.key, required this.toggleChangeView});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Lớp xử lý đăng ký đăng nhập
  final AuthService _auth = AuthService();

  //Dùng để validate form phía dưới <Bắt lỗi đầu vào người dùng>
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String err = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.pink[200],
      appBar: AppBar(
        title: Text('Đ Ă N G - K Ý'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        elevation: 0.0,
        actions: [
          TextButton(
            child: Column(
              children: [
                Icon(
                  Icons.person_2,
                  color: Colors.white,
                ),
                Text(
                  'Đăng Nhập',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            onPressed: () {
              widget.toggleChangeView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Expanded(
                  child: Transform.scale(
                    scale: 2.0,
                    child: Image.asset('./assets/images/LoveState_signup.png'),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Vui lòng nhập email' : null,
                  decoration: inputDecoration.copyWith(hintText: 'Email'),
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (val) => val!.length < 6
                      ? 'Mật khẩu phải nhiều hơn 6 ký tự'
                      : null,
                  decoration: inputDecoration.copyWith(hintText: 'Password'),
                  autocorrect: true,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.pinkAccent,
                        elevation: 0,
                        textStyle: TextStyle(color: Colors.pinkAccent),
                        shape: RoundedRectangleBorder(
                            side:
                                BorderSide(color: Colors.pinkAccent, width: 2),
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth.signUpWithEmailAndPassword(
                            email, password);
                        if (result == null) {
                          setState(() => err =
                              'Email không hợp lệ !\nVui lòng kiểm tra lại cú pháp');
                              loading = false;
                        }
                      }
                    },
                    child: Text('ĐĂNG KÝ')),
                SizedBox(
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        err,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      )),
                )
              ],
            )),
      ),
    );
  }
}
