import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lovestatus/models/lovestatus_model.dart';

import '../models/user_model.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  

  // Tạo key quản lý cho bộ sưu tập trên database - biến này sẽ quản lý trạng thái db của người dùng
  final CollectionReference loveSatusCollection =
      FirebaseFirestore.instance.collection('lovestatus');

  //Cập nhật data cho người dùng
  Future updateUserData(String love, String name, int feeling, String time) async {
    return await loveSatusCollection
        .doc(uid)
        .set({ 'name': name, 'love': love, 'feeling': feeling, 'time': time});
  }

  // danh sách satus love  từ snapshot - lấy dữ liệu của tất cả người dùng
  List<LoveStatus> _convertFirestoreToLoveStatus(QuerySnapshot snapshot) {
    print('Danh sách truy vấn: ${snapshot.size}');
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return LoveStatus(
        name: data?['name'] ?? '',
        strength: data?['feeling'] ?? 0,
        love: data?['love'] ?? '100',
        time: data?['time'] ?? '00:00',
      );
    }).toList();
  }

  // Lấy luồng trạng thái dữ liệu Trả về danh sách các LoveStatusModel -- all user
  Stream<List<LoveStatus>> get loveSatus {
    // convert nó sang model tự khởi tạo
    return loveSatusCollection.snapshots().map((_convertFirestoreToLoveStatus));
  }


    // Cẩn thận hàm này lỗi là bên luồng stream trả về null
  UserData _convertFirestoreToUserData(DocumentSnapshot snapshot) {
    // Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    return UserData(
      uid: uid,
      name: snapshot.get('name'),
      love: snapshot.get('love'),
      time: snapshot.get('time'),
      strength: snapshot.get('feeling')as int,
    );
  }

  Stream<UserData> get currentUserData {
// // trả về data người dùng - mapping nó qua model cho dễ quản lý
    return loveSatusCollection
        .doc(uid)
        .snapshots()
        .map((_convertFirestoreToUserData));// Nếu _convertFirestoreToUserData lỗi thì auto trả về null
  }
}



//      dynamic a= loveSatusCollection
//         .doc(uid)
//         .snapshots();

//     print(_convertFirestoreToUserData(a));
