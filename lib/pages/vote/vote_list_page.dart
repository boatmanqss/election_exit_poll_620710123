import 'package:election_exit_poll_620710123/models/vote_lists_item.dart';
import 'package:election_exit_poll_620710123/services/api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VoteListsPage extends StatefulWidget {
  const VoteListsPage({Key? key}) : super(key: key);

  @override
  _VoteListsPageState createState() => _VoteListsPageState();
}

class _VoteListsPageState extends State<VoteListsPage> {
  late Future<List<VoteListsItem>> _futureVoteLists;
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<VoteListsItem>>(
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

          if (_isLoading) {
            return Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(color: Colors.white),
                ),
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
                    onTap: () {
                      _handlePollClickButton(voteItem.number);
                    },
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
                                    Text(
                                      ('  ${voteItem.title}${voteItem.fullName}'),
                                      style: GoogleFonts.prompt(fontSize: 15.0),
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

  Future<List<VoteListsItem>> _loadVoteLists() async {
    List list = await Api().fetch('exit_poll');
    var voteList = list.map((item) => VoteListsItem.fromJson(item)).toList();
    return voteList;
  }

  @override
  initState() {
    super.initState();
    _futureVoteLists = _loadVoteLists();
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg, style: Theme.of(context).textTheme.bodyText2),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<String?> _poll(int number) async {
    try {
      setState(() {
        _isLoading = true;
      });

      var data = (await Api().submit('exit_poll', {'candidateNumber': number}));
      return data.toString();
    } catch (e) {
      print(e);
      _showMaterialDialog('ERROR', e.toString());
      return null;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  _handlePollClickButton(int number) async {
    var data = await _poll(number);
    _showMaterialDialog('SUCCESS', 'บันทึกข้อมูลสำเร็จ $data');
  }
}
