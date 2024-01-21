import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../widgets/navdrawer.dart';
// import '../widgets/page.dart';
import 'posts_screen.dart';
import '../widgets/create_new_post.dart';
import '../widgets/account.dart';
import 'package:lara_fl/providers/auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController? _pageController;
  int pageINdex = 1;
  late User signedInUser; // Store the signed-in user data
  final storage = FlutterSecureStorage();

  void _attemptAuthentication() async {
    String? key = await storage.read(key: 'auth');
    // ignore: use_build_context_synchronously
    Provider.of<Auth>(context, listen: false).attempt(key);
  }

  @override
  void initState() {
    super.initState();
    _attemptAuthentication();
    _pageController = PageController(initialPage: pageINdex);
  }

  onPageChanged(int page) {
    setState(() {
      pageINdex = page;
    });
  }

  onPageTap(int page) {
    _pageController!.animateToPage(page,
        duration: Duration(microseconds: 200), curve: Curves.linearToEaseOut);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        // title: Text('welcome'),
      ),
      drawer: NavDrawer(),
      body: PageView(
        onPageChanged: onPageChanged,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          // PageWidget(),
          PostsScreen(),
          CreateNewPostWidget(),
          AccountScreen(
            user: Provider.of<Auth>(context).user,
          ),
          // AccountScreen(
          //   user: User(name: auth.user?.name, email: auth.user?.email),
          // ),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
          onTap: onPageTap,
          currentIndex: pageINdex,
          activeColor: Colors.indigo,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                FeatherIcons.alignCenter,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FeatherIcons.plusCircle,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FeatherIcons.user,
                size: 30,
              ),
            ),
          ]),
    );
  }
}
