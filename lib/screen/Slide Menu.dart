import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/config.dart';
import 'package:flutter_application_1/model/login_result.dart';
import 'home.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    String accountName = "BENto";
    String accountEmail = "KUng";
    String accountUrl =
        "https://scontent.furt1-1.fna.fbcdn.net/v/t39.30808-6/372833570_3949382325336206_29107321017918101_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=a2f6c7&_nc_eui2=AeHNRYI-de4peZLa5jSS6J6DYB-98wXn10xgH73zBefXTD2yEPQURyGbbsDXeh3MAmu7HaoL6BYa1b63W--qJrXv&_nc_ohc=Wa2OcauaL-MAX9jva5z&_nc_ht=scontent.furt1-1.fna&oh=00_AfA7YNTmTQ1txi9iNWcK7b6U1fvgyEGkJ2nQ2u-71cUjvw&oe=64F7022A";
    Users user = Configure.login;
    print(user.toJson().toString());
    if (user.id != null) {
      accountName = user.fullname!;
      accountEmail = user.email!;
    }
    return Drawer(
      backgroundColor: Color.fromARGB(255, 187, 243, 255),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(accountName),
            accountEmail: Text(accountEmail),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(accountUrl),
              backgroundColor: Color.fromARGB(255, 246, 174, 232),
            ),
          ),
          ListTile(
            title: Text("Home"),
            onTap: () {
              Navigator.pushNamed(context, Home.routeName);
            },
          ),
          ListTile(
            title: Text("login"),
            onTap: () {
              Navigator.pushNamed(context, Login.routeName);
            },
          ),
        ],
      ),
    );
  }
}

class Login extends StatefulWidget {
  static const routeName = "/login";

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User CRUD',
      initialRoute: '/',
      routes: {
        '/': (constext) => const Home(),
        '/login': (context) => const Login(),
      },
    );
  }
}
