import 'package:intl/intl.dart';
import 'package:sport_app_user/core/constants/assets.dart';

class TeamModel {
  final String name;
  final String logo;
  final String order;

  TeamModel(this.name, this.logo, this.order);
}

final List<TeamModel> dummyTeams = [
  TeamModel('Athletic Club Bilbao', Assets.bilbaoIcon, "1"),
  TeamModel('FC Barcelona', Assets.fcbIcon, '2'),
  TeamModel('Atlético Madrid', Assets.atleticoIcon, '3'),
  TeamModel('Deportivo La Coruña', Assets.realIcon, '1'),
  TeamModel('RCD Espanyol', Assets.barceIcon, '3'),
];

final List<String> dummyImageList = [
  Assets.onBoarding1,
  Assets.onBoarding2,
  Assets.onBoarding3,
];

class PlayerModel {
  final String name;
  final int goals;
  final TeamModel team;
  final String order;

  PlayerModel(this.name, this.goals, this.team, this.order);
}

final List<PlayerModel> dummyPlayers = [
  PlayerModel('Messi', 12, dummyTeams[1], '1'),
  PlayerModel('Suarez', 10, dummyTeams[1], '2'),
  PlayerModel('Griezmann', 8, dummyTeams[2], '3'),
  PlayerModel('Williams', 7, dummyTeams[0], '1'),
  PlayerModel('Perez', 5, dummyTeams[4], '2'),
];

class NewsModel {
  final String imageTitle;
  final String description;
  final String image;
  final DateTime dateTime;
  final String title;

  NewsModel( {
    required this.title,
    required this.imageTitle,
    required this.description,
    required this.image,
    required this.dateTime,
  });
}

List<NewsModel> dummyNewsList = [
  NewsModel(
    title:"Special Offer: 50% Off New Football Boots!",
    imageTitle: 'Special Offer',
    description:
        "A dynamic football news graphic showcasing the launch of a new generation of football boots. The image features sleek black boots with turquoise accents standing proudly on a lush green pitch. The bold text announces the exciting news of their release, making it perfect for promotional campaigns or social media ads.",
    image: Assets.newsImage1,
    dateTime: DateTime.now(),
  ),
  NewsModel(
    title:"Grand Opening: New Football Stadium!",
    imageTitle: 'Grand Opening',
    description:
        "A vibrant news announcement highlighting the official opening of a state-of-the-art football stadium. Captured under a bright blue sky, the photo shows tiered blue seats, a pristine green field, and a modern roof structure. This image perfectly captures the excitement and grandeur of the stadium's debut.",
    image: Assets.newsImage2,
    dateTime: DateTime(2025, 4, 20,10,50),
  ),
];


class NotificationModel {
  final String title;
  final String subtitle;
  final DateTime dateTime;
  final String image;
  final bool isFavorite;

  NotificationModel( {
    required this.title,
    required this.subtitle,
    required this.dateTime,
    required this.image,
    this.isFavorite=false,
  });
}

final List<NotificationModel> dummyNotifications = [
  NotificationModel(
    title: 'New match: France vs Australia',
    subtitle: 'Junior Championship 8 to 10 years | 07/04/2024',
    dateTime: DateTime.now(), image: Assets.vsIcon,
    isFavorite: true
  ),
  NotificationModel(
    title: 'End of match: Argentina vs Spain',
    subtitle: 'Junior Championship 12 to 14 years',
    dateTime: DateTime.now().subtract(Duration(days: 1)),
    image: Assets.souIcon
  ),
  NotificationModel(
    title: 'New goal for Spain against Australia',
    subtitle: 'Junior Championship 12 to 14 years',
    dateTime: DateTime.now().subtract(Duration(days: 1)),
      image: Assets.notGoalIcon,
    isFavorite: true,

  ),
  NotificationModel(
    title: 'Red card for Argentina against China',
    subtitle: 'Junior Championship 12 to 14 years',
    dateTime: DateTime.now().subtract(Duration(days: 1)),
      image: Assets.notRedCardIcon

  ),
  NotificationModel(
    title: 'Yellow card for Argentina against China',
    subtitle: 'Junior Championship 12 to 14 years',
    dateTime: DateTime.now().subtract(Duration(days: 1)),
      image: Assets.notYellowCardIcon

  ),
  NotificationModel(
    title: 'Kickoff: Argentina vs Spain',
    subtitle: 'Junior Championship 12 to 14 years',
    dateTime: DateTime.now().subtract(Duration(days: 1)),
      image: Assets.souIcon

  ),
  NotificationModel(
    title: 'New match: France vs Portugal',
    subtitle: 'Junior Championship 8 to 10 years | 05/04/2024',
    dateTime: DateTime(2024, 4, 5),
      image: Assets.vsIcon

  ),
];
