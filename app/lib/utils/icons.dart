import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class IconHelper {
  static Map<List<String>, IconData> map = {
    ['padel']: MaterialCommunityIcons.tennis,
    ['pingis']: MaterialCommunityIcons.table_tennis,
    ['löpning']: MaterialCommunityIcons.run_fast,
    ['simning']: MaterialCommunityIcons.swim,
    ['vandring']: FontAwesome5Solid.hiking,
    ['träning hemma']: MaterialCommunityIcons.home,
    ['gym']: MaterialCommunityIcons.dumbbell,
    ['badminton']: MaterialCommunityIcons.badminton,
    ['innebandy']: MaterialCommunityIcons.hockey_sticks,
    ['tennis']: MaterialCommunityIcons.tennis_ball,
    ['squash']: MaterialCommunityIcons.baseball_bat,
    ['klättring']: MaterialCommunityIcons.hand,
    ['bodybalance']: MaterialCommunityIcons.human_greeting,
    ['bodyjam']: MaterialCommunityIcons.thumbs_up_down,
    ['yoga']: FontAwesome.yen,
    ['skridskor']: FlutterIcons.skate_mco,
    ['rehab']: MaterialCommunityIcons.seat_legroom_extra,
    ['cykling']: MaterialCommunityIcons.bike,
  };

  static IconData iconFromActivity(String activity) {
    IconData fallback = MaterialCommunityIcons.help_circle_outline;

    IconData chosen;

    map.forEach((activities, icon) {
      if (activities.contains(activity.toLowerCase())) {
        chosen = icon;
        return;
      }
    });

    if (chosen == null) {
      debugPrint('*** missing icon for activity $activity');
    }

    return chosen ?? fallback;
  }
}
