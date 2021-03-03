import 'package:addis_teller_app/auth/widgets/updateForm.dart';
import 'package:flutter/material.dart';

import '../auth.dart';

class AdminUserUpdate extends StatelessWidget {
  AdminUserUpdate({this.userToUpdate});
  final Auth userToUpdate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: Center(
        child: UpdateForm(
          adminOnly: true,
          auth: userToUpdate,
          update: true,
        ),
      ),
    );
  }
}
