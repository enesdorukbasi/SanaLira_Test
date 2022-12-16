import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanalira_test/cores/firebase_services/authentication_service.dart';
import 'package:sanalira_test/features/authentication_pages/register_page/view/register_page_view.dart';
import 'package:sanalira_test/features/home_pages/card_page/view/card_main_page.dart';
import 'package:sanalira_test/models/firebase_models/user_local.dart';

class AuthenticationControl extends StatelessWidget {
  const AuthenticationControl({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _authenticationService =
        Provider.of<AuthenticationService>(context, listen: false);
    return StreamBuilder<UserLocal?>(
      stream: _authenticationService.stateFollower,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const CircularProgressIndicator(),
              ],
            ),
          );
        }

        if (snapshot.hasData) {
          _authenticationService.activeUserId = snapshot.data!.id;
          return CardMainPage();
        } else {
          return RegisterMainPage();
        }
      },
    );
  }
}
