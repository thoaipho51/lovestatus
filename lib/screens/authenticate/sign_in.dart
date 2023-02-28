import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:lovestatus/services/auth.dart';
import 'package:lovestatus/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:lovestatus/shared/shared.dart';

class SignIn extends StatefulWidget {
  final Function toggleChangeView;
  const SignIn({super.key, required this.toggleChangeView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  //Dùng để validate form phía dưới <Bắt lỗi đầu vào người dùng>
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String err = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.pink[200],
            appBar: AppBar(
              title: Text('Đ Ă N G - N H Ậ P'),
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
                        'Đăng ký',
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
              padding: EdgeInsets.symmetric( horizontal: 40.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Transform.scale(
                          scale: 2.0,
                          child: Image.asset(
                              './assets/images/LoveState_Login.png'),
                        ),
                      ),
                      // Image.asset('./assets/images/LoveStatus.png'),
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
                        decoration:
                            inputDecoration.copyWith(hintText: 'Password'),
                        autocorrect: true,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.pinkAccent,
                                elevation: 0,
                                textStyle:
                                    TextStyle(color: Colors.pinkAccent),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.pinkAccent, width: 2),
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() => err =
                                      'Sai email hoặc password vui lòng kiểm tra lại !');
                                  loading = false;
                                }
                              }
                            },
                            child: Text('ĐĂNG NHẬP')),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        flex: 4,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.pinkAccent,
                                elevation: 0,
                                textStyle: TextStyle(color: Colors.white),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.pinkAccent, width: 2),
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () async {
                              setState(() => loading = true);
                              await _auth.signInAnon();
                            },
                            child: Text('ĐĂNG NHẬP ẨN DANH')),
                      ),
                        ],
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                err,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              )),
                        ),
                      )
                    ],
                  )),
            ),
          );
  }
}
