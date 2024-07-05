String differenceBetweenDataInHours(DateTime from, DateTime to) {
  Duration difference = to.difference(from);

  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(difference.inMinutes.remainder(60).abs());
  String twoDigitSeconds = twoDigits(difference.inSeconds.remainder(60).abs());
  return "${twoDigits(difference.inHours)}:$twoDigitMinutes:$twoDigitSeconds";

}

String convertSecondToTime(int duration) {
  Duration secondsToTime = Duration(seconds: duration);

  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(secondsToTime.inMinutes.remainder(60).abs());
  String twoDigitSeconds = twoDigits(secondsToTime.inSeconds.remainder(60).abs());
  return "${twoDigits(secondsToTime.inHours)}:$twoDigitMinutes:$twoDigitSeconds";

}
