import 'package:election_exit_poll_620710123/pages/vote/vote_page.dart';
import 'package:election_exit_poll_620710123/pages/vote/vote_list_page.dart';
import 'package:election_exit_poll_620710123/pages/vote/vote_result_page.dart';
import 'package:election_exit_poll_620710123/pages/vote/vote_sc_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _subPageIndex = 0;
  VotePage? _currentPage = VotePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: const DecorationImage(
            image: const AssetImage("assets/images/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          //color: Colors.black,
          child: SafeArea(
            child: Container(
                child: Column(
              children: [
                _buildSubPage(),
                (_subPageIndex == 0) ? ElevatedButton(
                  onPressed: () {
                    _showSubPage(context, 1);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(350, 45),
                    primary: Color(0xFF0000A0),
                  ),
                  child: Text('ดูผล',
                      style: GoogleFonts.prompt(
                          fontSize: 20.0, color: Colors.white)),
                ) : SizedBox.shrink(),
              ],
            )),
          ),
        ),
      ),
    );
  }

  dynamic _buildSubPage() {
    switch (_subPageIndex) {
      case 0:
        return _currentPage;
      case 1:
        return VoteScPage();
      default:
        return null;
    }
  }

  void _showSubPage(BuildContext context, int page) {
    setState(() {
      _subPageIndex = page;
      _currentPage = page == 0 ? VotePage() : null;
    });
  }
}
