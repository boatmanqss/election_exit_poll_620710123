import 'package:election_exit_poll_620710123/pages/vote/vote_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VotePage extends StatefulWidget {
  const VotePage({Key? key}) : super(key: key);

  @override
  _VotePageState createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'EXIT POLL',
                  style: GoogleFonts.prompt(fontSize: 10.0, color: Colors.white),
                ),Text(
                  'เลือกตั้ง อบต.',
                  style: GoogleFonts.prompt(fontSize: 15.0, color: Colors.white),
                ),Text(
                  'รายชื่อผู้สมัครรับเลือกตั้ง',
                  style: GoogleFonts.prompt(fontSize: 15.0, color: Colors.white),
                ),Text(
                  'นายกองค์การบริหารส่วนตำบลเขาพระ',
                  style: GoogleFonts.prompt(fontSize: 15.0, color: Colors.white),
                ),Text(
                  'อำเภอเมืองนครนายก จังหวัดนครนายก',
                  style: GoogleFonts.prompt(fontSize: 15.0, color: Colors.white),
                ),
              ],
            ),
          ),
          Container(width: 800, height: 400, child: VoteListsPage()),
        ],
      ),
    );
  }
}
