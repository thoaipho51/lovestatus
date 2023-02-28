import 'package:lovestatus/screens/home/card_lovestatus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/lovestatus_model.dart';
import '../../shared/loading.dart';

class LoveStatusList extends StatefulWidget {
  const LoveStatusList({super.key});

  @override
  State<LoveStatusList> createState() => _LoveStatusListState();
}

class _LoveStatusListState extends State<LoveStatusList> {
  @override
  Widget build(BuildContext context) {
    

    final loveStatus = Provider.of<List<LoveStatus>>(context);

    if (loveStatus == null) {
      return Loading(); // Trạng thái loading trái tim
    }

    return ListView.builder(
      itemCount: loveStatus.length,
      itemBuilder: (context, index) =>
          CardLoveStatus(loveStatus: loveStatus[index]),
    );
  }
}
