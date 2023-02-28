import 'package:lovestatus/models/user_model.dart';
import 'package:lovestatus/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // Import intl package


DateTime date = DateTime.now(); // Lấy ngày của loveStatus
String formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(date); // Định dạng ngày theo kiểu 'dd/MM/yyyy'


class AuthService {
  

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Hàm này chuyển dữ liệu trả về từ Firebase thành model của mình
  UserModel? _userFromUserCredentials(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  // Luồng này trả về trạng thái xác thực của người dùng (login - log out) null hoặc have data
  Stream<UserModel> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromUserCredentials(user!)!);
    // .map(_userFromUserCredentials);
  }

  // sign in anonymous

  Future<UserModel?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      String userID = user!.uid.substring(0, 3);
      await DatabaseService(uid: user!.uid).updateUserData(
          'Ẩn danh nên không có tâm trạng', 'Ẩn danh: $userID', 100, formattedDate);
      return _userFromUserCredentials(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // SignIn with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromUserCredentials(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Signup with email and password
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      String userID = user!.uid.substring(0, 3);
      //Tạo dữ liệu mới cho người dùng mới
      await DatabaseService(uid: user!.uid)
          .updateUserData('Mới tạo nick', 'User: $userID', 100, formattedDate);
      return _userFromUserCredentials(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future sigOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
