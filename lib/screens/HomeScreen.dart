import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/color.dart';
import '../repository/auth_repository.dart';
import '../widgets/snackbar_textwidget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService service  = AuthService();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
           service.logoutCurrentUser();
           Navigator.pop(context);
          return true;
    },
      child: Scaffold(
        backgroundColor: Colors.black,
        body:  Container(
          child: const Center(child: TextWidget(fontSize: 20, wtg: FontWeight.bold, color: commonColor, text: "Home",)),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    service.logoutCurrentUser();
    super.dispose();
  }
}

