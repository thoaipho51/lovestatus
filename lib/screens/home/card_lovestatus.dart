import 'package:lovestatus/models/lovestatus_model.dart';
import 'package:flutter/material.dart';

class CardLoveStatus extends StatelessWidget {
  final LoveStatus loveStatus;

  CardLoveStatus({super.key, required this.loveStatus});

  @override
  Widget build(BuildContext context) {
    List<String> time =
        loveStatus!.time.split(' '); // Tách chuỗi theo khoảng trắng
    print(time[0]);
    // String part1 = parts[0]; // Lấy phần tử thứ nhất của mảng kết quả
    // String part2 = parts[1]; // Lấy phần tử thứ hai của mảng kết quả

    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        // list tile là một trường văn bản được định dạng sẳng
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.pink[loveStatus.strength],
            backgroundImage: AssetImage('./assets/images/love2_icon.png'),
          ),
          title: Text('${loveStatus.name}'),
          subtitle: Text(
            'Thời gian: ${time[0]}',
            style: TextStyle(fontSize: 15),
          ),
          hoverColor: Colors.amberAccent,
          onTap: () {
            // Hiển thị hộp thoại chứa thời gian
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Dòng Thời Gian: ${time[1]}'),
                  content: Text(loveStatus.love),
                  actions: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.pinkAccent,
                            elevation: 0,
                            textStyle: TextStyle(color: Colors.pinkAccent),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.pinkAccent, width: 2),
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () async {
                          Navigator.of(context).pop(); // Đóng hộp thoại
                        },
                        child: Text('Đã đọc <3')),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
