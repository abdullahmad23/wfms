import 'package:flutter/material.dart';

class AdminApplicationStats extends StatefulWidget {
  const AdminApplicationStats({Key? key}) : super(key: key);

  @override
  State<AdminApplicationStats> createState() => _AdminApplicationStatsState();
}

class _AdminApplicationStatsState extends State<AdminApplicationStats> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child:Text('ApplicationStats'),
    );
  }
}
