extension DateTimeFormatter on DateTime {
  String formatDateTime() {
    final diff = DateTime.now().difference(this);
    if (diff.inMinutes < 60) {
      return "${diff.inMinutes} minutes ago";
    }
    if (diff.inHours < 24) {
      return "${diff.inHours} hours ago";
    }
    if (diff.inDays < 30) {
      return "${diff.inDays} days ago";
    }
    return "${(diff.inDays / 30).floor()} months ago";
  }
}
