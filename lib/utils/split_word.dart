String formatPlayerName(String playerName) {
  if (playerName == null) {
    return '';
  }
  List<String> words = playerName.split(" ");
  String formattedString = '';
  if (words.isNotEmpty ) {
    formattedString += words[0][0];
    if (words.length > 1) {
      formattedString += " " + words.last;
    }
  }
  return formattedString;
}