import 'package:gameguru/models/Api/recentmatchmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<MatchData>> fetchRecentMatchData() async {
  final url = Uri.parse('http://192.168.1.48:3000/recent-matches');
  final List<MatchData> matches = [];

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> apiData = jsonDecode(response.body);

      for (final item in apiData) {
        final match = MatchData(
          date: item['date'],
          matchStadium: item['seriesName'],
          team1: item['team1'],
          team2: item['team2'],
          startTime: item['startTime'], venueInfo: '',
        );
        matches.add(match);
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }

  return matches;

}
