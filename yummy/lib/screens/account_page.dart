import 'package:basic_widgets/models/user.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

typedef LogoutCallBack = void Function(bool didLogout);

class AccountPage extends StatefulWidget {
  final User user;
  final LogoutCallBack onLogout;

  const AccountPage({super.key, required this.user, required this.onLogout});

  @override
  State<StatefulWidget> createState() {
    return AccountPageState();
  }
}

class AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            buildProfile(),
            Expanded(child: buildMenu()),
          ],
        ),
      ),
    );
  }

  Widget buildMenu() {
    return ListView(
      children: [
        ListTile(
          title: const Text("View Kodeco"),
          onTap: () async {
            await launchUrl(Uri.parse("https://www.kodeco.com"));
          },
        ),
        ListTile(
          title: const Text("Log Out"),
          onTap: () {
            widget.onLogout(true);
          },
        ),
      ],
    );
  }

  Widget buildProfile() {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage(widget.user.profileImageUrl),
        ),
        const SizedBox(height: 16),
        Text(widget.user.firstName, style: const TextStyle(fontSize: 21)),
        Text(widget.user.role),
        Text('${widget.user.points} points'),
      ],
    );
  }
}
