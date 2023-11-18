import 'package:flutter/material.dart';
import 'package:gameguru/services/server/match-commentary.dart';
import 'package:gameguru/widgets/Overview_widget/key_stats_container.dart';

class MatchCommentary extends StatefulWidget {
  final int matchId;
  const MatchCommentary({super.key, required this.matchId});

  @override
  State<MatchCommentary> createState() => _MatchCommentaryState();
}

class _MatchCommentaryState extends State<MatchCommentary> {

  late Future<Map<String, dynamic>> commData;
  @override
  void initState() {
    commData = matchCommentary(widget.matchId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: commData,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }else if(snapshot.hasError){
          return Text("Error : ${snapshot.hasError}",style: const TextStyle(color: Colors.white),);
        }else if(snapshot.hasData){
          final matchComm = snapshot.data!['commentaryList'];
          String replaceFormatValue(Map<String, dynamic> commentaryData, String commText) {
            final formatId = commentaryData['commentaryFormats']['bold']['formatId'];
            final formatValue = commentaryData['commentaryFormats']['bold']['formatValue'];

            for (int i = 0; i < formatId.length; i++) {
              final id = formatId[i];
              final value = formatValue[i];
              commText = commText.replaceAll(id, value);
            }
            return commText;
          }
          return ListView.builder(
              itemCount: matchComm.length,
              itemBuilder: (context, index){
                final commText = matchComm[index]['commText'];
                String updatedCommText;
                if(matchComm[index]['commentaryFormats'].isNotEmpty){
                updatedCommText = replaceFormatValue(matchComm[index], commText);
                }else{
                  updatedCommText = commText;
                }
                final overNumber = matchComm[index]['overNumber'];

                // final commText = matchComm[index]['commText'];
                // final formatId = matchComm[index]['commentaryFormats']['bold']['formatId'];
                // final formatValue = matchComm[index]['commentaryFormats']['bold']['formatValue'];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          width: 22,height: 22,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.2,color: Colors.white),
                          shape: BoxShape.circle
                        ),
                        child: Text(overNumber),
                        ),
                        Flexible(
                          child: Text(updatedCommText,
                            style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                    divider
                  ],),
                );
              });
        }
        return Container();
      }


    );
  }
}
