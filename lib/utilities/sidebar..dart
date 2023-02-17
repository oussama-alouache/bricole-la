import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('ousama'),
            accountEmail: Text('ouss@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                  child: Image.network(
                "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              )),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle_sharp),
            title: Text('profile'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.filter),
            title: Text(' Mes annonces '),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.add_circle_outlined),
            title: Text('Ajpueter une annoces'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Historique'),
            onTap: () => null,
          ),
          Divider(
            color: Colors.deepOrangeAccent,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('ce deconnceter'),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
    );
  }
}
