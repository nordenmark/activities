import 'package:app/models/challenge.model.dart';
import 'package:app/utils/styles.dart';
import 'package:flutter/material.dart';

import 'single_challenge_page.dart';

class ChallengeItem extends StatelessWidget {
  final Challenge challenge;

  const ChallengeItem(this.challenge);

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: MediaQuery.of(context).size.width * 0.20,
      height: MediaQuery.of(context).size.width * 0.20,
      decoration: BoxDecoration(
        color: Styles.overlayBgColor,
        shape: BoxShape.circle,
        border: new Border.all(
          color: Styles.appPrimaryColor,
          width: 4.5,
        ),
      ),
      child: InkWell(
        customBorder: CircleBorder(),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  SingleChallengePage(challenge: this.challenge)));
        },
        child: Align(
            alignment: Alignment.center,
            child: Text(
              challenge.name,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            )),
      ),
    );
  }
}
