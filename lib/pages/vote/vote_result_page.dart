import 'package:election_exit_poll_620710123/models/vote_lists_item.dart';
import 'package:election_exit_poll_620710123/models/votesc_item.dart';
import 'package:election_exit_poll_620710123/services/api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VoteResPage extends StatefulWidget {
  const VoteResPage({Key? key}) : super(key: key);

  @override
  _VoteResPageState createState() => _VoteResPageState();
}

class _VoteResPageState extends State<VoteResPage> {
  late Future<List<VoteScItem>> _futureVoteLists;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<VoteScItem>>(
        // ข้อมูลจะมาจาก Future ที่ระบุให้กับ parameter นี้
        future: _futureVoteLists,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('ผิดพลาด: ${snapshot.error}'),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _futureVoteLists = _loadVoteLists();
                      });
                    },
                    child: Text('RETRY'),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var voteItem = snapshot.data![index];

                return Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.all(8.0),
                  elevation: 5.0,
                  shadowColor: Colors.black.withOpacity(0.2),
                  child: InkWell(
                    onTap: null,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      color: Colors.green,
                                      width: 50,
                                      height: 50,
                                      child: Center(
                                          child: Text('${voteItem.number}')),
                                    ),
                                    Container(
                                     // color: Colors.black,
                                      child: Row(
                                        children: [
                                          Text(
                                            ('  ${voteItem.title}${voteItem.fullName}'),
                                            style: GoogleFonts.prompt(fontSize: 15.0),
                                          ),
                                          Text(
                                            ('                ${voteItem.score}'),
                                            style: GoogleFonts.prompt(fontSize: 15.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }

  Future<List<VoteScItem>> _loadVoteLists() async {
    List list = await Api().fetch('exit_poll/result');
    var voteList = list.map((item) => VoteScItem.fromJson(item)).toList();
    return voteList;
  }

  @override
  initState() {
    super.initState();
    _futureVoteLists = _loadVoteLists();
  }

}
