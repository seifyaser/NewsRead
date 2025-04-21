import 'package:intl/intl.dart';

String formatTimeAgo(DateTime? postTime) {
  if (postTime == null) return 'Unknown time'; 

  Duration difference = DateTime.now().difference(postTime);

  if (difference.inSeconds < 60) {
    return 'Just now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else {
    return DateFormat('MMM d, yyyy').format(postTime); // تنسيق التاريخ
  }
}

