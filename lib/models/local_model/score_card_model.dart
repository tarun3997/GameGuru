class LiveMatchCard{
  final String? stadiumName;
  final String? team1;
  final String? team2;
  final bool? live;
  final int? team1Score;
  final int? team1Wicket;
  final int? team2Score;
  final int? team2Wicket;
  final String? team1Over;
  final String? team2Over;
  final String? matchInfo;
  final String? tournamentInfo;

  LiveMatchCard(
      {
        required this.stadiumName,
        required this.team1,
        required this.team2,
        required this.live,
        required this.team1Score,
        required this.team2Score,
        required this.team1Wicket,
        required this.team2Wicket,
        required this.team1Over,
        required this.team2Over,
        required this.matchInfo,
        required this.tournamentInfo});

}