class BatterScorecard {
  final String? batsmanName;
  final String? battingStatus;
  final int? batsmanRuns;
  final int? batsmanBowFace;
  final int? batsmanFours;
  final int? batsmanSix;
  final double? batsmanSR;

  BatterScorecard(

      {required this.batsmanName,
        required this.battingStatus,
        required this.batsmanRuns,
        required this.batsmanBowFace,
        required this.batsmanFours,
        required this.batsmanSix,
        required this.batsmanSR,});
}


class BowlerScorecard {
  final String? bowlerName;
  final double? bowlerOver;
  final int? bowlerMaiden;
  final int? bowlerRun;
  final int? bowlerWicket;
  final double? bowlerEco;

  BowlerScorecard(
      {required this.bowlerName,
        required this.bowlerOver,
        required this.bowlerMaiden,
        required this.bowlerRun,
        required this.bowlerWicket,
        required this.bowlerEco,});
}