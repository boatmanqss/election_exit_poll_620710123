import 'package:election_exit_poll_620710123/pages/vote/vote_result_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VoteScPage extends StatefulWidget {
  const VoteScPage({Key? key}) : super(key: key);

  @override
  _VoteScPageState createState() => _VoteScPageState();
}

class _VoteScPageState extends State<VoteScPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset(
            'assets/images/vote_hand.png',
            width: 120.0,
            height: 120.0,
          ),
          Center(
            child: Column(
              children: [
                Text(
                  'EXIT POLL',
                  style: GoogleFonts.prompt(fontSize: 15.0, color: Colors.white),
                ),Text(
                  'RESULT',
                  style: GoogleFonts.prompt(fontSize: 30.0, color: Colors.white),
                ),
              ],
            ),
          ),
          Container(width: 500, height: 400, child: VoteResPage()),
        ],
      ),
    );
  }
}
