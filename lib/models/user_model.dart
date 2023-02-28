//Tạo model riêng (Một lớp riêng chứa dữ liệu cần thiết được lọc ra)
class UserModel {

  final String uid;

  UserModel({required this.uid});

}

class UserData {

  final String uid;
  final String name;
  final String love;
  final int strength;
  final String time;

  UserData({required this.uid, required this.name, required this.love, required this.strength, required this.time});
}