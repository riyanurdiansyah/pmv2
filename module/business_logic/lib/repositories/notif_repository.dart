abstract class NotifRepository {
  String getInitials(String fullname);

  String getTimeAgo(DateTime date);

  String getLanguage(String locale);
}

class NotifRepositoryImpl implements NotifRepository {
  @override
  String getInitials(String fullname) {
    List<String> words = fullname.split(" ");
    String initials = "";

    for (var word in words) {
      if (word.isNotEmpty) {
        if (words.length == 1) {
          for (int i = 0; i < 3; i++) {
            initials += word[i].toLowerCase();
          }
        } else if (words.length == 2) {
          initials = words[0][0];
          for (int i = 0; i < 2; i++) {
            initials += word[i].toLowerCase();
          }
        } else {
          initials += word[0];
        }
      }
    }

    if (initials.length <= 3) {
      return initials;
    }

    return initials.substring(0, 3);
  }

  @override
  String getTimeAgo(DateTime date) {
    Duration difference = DateTime.now().difference(date);

    if (difference.inDays > 7) {
      return 'On ${date.day}/${date.month}/${date.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  @override
  String getLanguage(String locale) {
    if (locale == "en_US") {
      return "English";
    } else {
      return "Indonesia";
    }
  }
}
