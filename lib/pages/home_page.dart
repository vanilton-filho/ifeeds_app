import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ifeeds/pages/history_page.dart';
import 'package:ifeeds/pages/rating_page.dart';
import 'package:ifeeds/pages/user_page.dart';
import 'package:ifeeds/pages/utils/campus_utils.dart';

class HomePage extends StatefulWidget {
  int? index;

  HomePage({this.index});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _currentIndex;
  final List<Widget> _screens = [RatingPage(), HistoryPage(), UserPage()];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index == null ? 0 : this.widget.index!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0
          ? PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: AppBar(
                elevation: 0,
                backgroundColor: Color(0xff4E986E),
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'IFeedS',
                    style: GoogleFonts.fredokaOne(
                        fontSize: 36, color: Colors.white),
                  ),
                ),
              ),
            )
          : null,
      body: _screens[_currentIndex!],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex!,
        onTap: onTapBottomBar,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home,
              size: 36,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Histórico',
            icon: Icon(
              Icons.history_edu,
              size: 36,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Minha Conta',
            icon: CircleAvatar(
              radius: 18,
              foregroundColor: Colors.white,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                FirebaseAuth.instance.currentUser!.photoURL!,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onTapBottomBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

}
