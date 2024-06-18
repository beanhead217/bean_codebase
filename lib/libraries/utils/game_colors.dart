
import 'dart:ui';

import 'package:flutter/material.dart';

enum GameColors{
  skin1,
  skin2,
  skin3,
  skin4,
  skin5,
  skin6,
  skin7,
  skin8,
  skin9,
  skin10,
  skin11,
  skin12,
  skin13,
  skin14,
  skin15,
  skin16,
  skin17,
  skin18,
  skin19,
  skin20,
  skin21,
  skinZ1,
  skinZ2,
  skinZ3,

  hairBlack,
  hairDarkGrey,
  hairGrey,
  hairWhite,
  hairBrown,
  hairDarkRed,
  hairRed,
  hairLightRed,
  hairBlonde,
  hairPurple,

  eyesBlack,
  eyesBlue,
  eyesGreen,
  eyesRed,
  eyesYellow,

  transparent;

String toJson() => name;
static GameColors fromJson(String json) => values.byName(json);
}

Map<GameColors, List<Color>> gameColors = {

  GameColors.transparent : [Colors.transparent, Colors.transparent],

  //SKINS

  GameColors.skinZ1 : [const Color(0xff4b692f), const Color(0xff6abe30)],
  GameColors.skinZ2 : [const Color(0xff524b24), const Color(0xff959025)],
  GameColors.skinZ3 : [const Color(0xff595652), const Color(0xff847e87)],

  GameColors.skin1 : [const Color(0xffbe570d), const Color(0xfffbaa1d)],
  GameColors.skin2 : [const Color(0xffa03a12), const Color(0xffd87e08)],
  GameColors.skin3 : [const Color(0xff701313), const Color(0xffa03a12)],
  GameColors.skin4 : [const Color(0xff410a16), const Color(0xff701313)],
  GameColors.skin5 : [const Color(0xffdc9f10), const Color(0xfffbee5b)],
  GameColors.skin6 : [const Color(0xffad6a12), const Color(0xfff6cb29)],
  GameColors.skin7 : [const Color(0xff9c4e15), const Color(0xffdc9f10)],
  GameColors.skin8 : [const Color(0xff702b0f), const Color(0xff9c4e15)],
  GameColors.skin9 : [const Color(0xff8a4f16), const Color(0xffe59718)],
  GameColors.skin10 : [const Color(0xff4e2a15), const Color(0xff8a4f16)],
  GameColors.skin11 : [const Color(0xff381c11), const Color(0xff683817)],
  GameColors.skin12 : [const Color(0xff301611), const Color(0xff4e2a15)],
  GameColors.skin13 : [const Color(0xfff6bf96), const Color(0xfffbeac1)],
  GameColors.skin14 : [const Color(0xffd85d4d), const Color(0xfff6bf96)],
  GameColors.skin15 : [const Color(0xffa93356), const Color(0xffe18763)],
  GameColors.skin16 : [const Color(0xff75244d), const Color(0xffd85d4d)],
  GameColors.skin17 : [const Color(0xffc7a07b), const Color(0xffeee0c2)],
  GameColors.skin18 : [const Color(0xff935d4d), const Color(0xffc7a07b)],
  GameColors.skin19 : [const Color(0xff4e2d2d), const Color(0xff935d4d)],
  GameColors.skin20 : [const Color(0xffd9a066), const Color(0xffeec39a)],
  GameColors.skin21 : [const Color(0xff663931), const Color(0xff8f563b)],



  //HAIR
  GameColors.hairBlack : [const Color(0xff131313), const Color(0xff323232)],
  GameColors.hairDarkGrey : [const Color(0xff323232), const Color(0xff595652)],
  GameColors.hairGrey : [const Color(0xff696a6a), const Color(0xff847e87)],
  GameColors.hairWhite : [const Color(0xffcbdbfc), const Color(0xffffffff)],
  GameColors.hairBrown : [const Color(0xff462721), const Color(0xff663931)],
  GameColors.hairDarkRed : [const Color(0xff5c1c1c), const Color(0xff842525)],
  GameColors.hairRed : [const Color(0xff842107), const Color(0xffbd4c2e)],
  GameColors.hairLightRed : [const Color(0xff9e2936), const Color(0xffe43b44)],
  GameColors.hairBlonde : [const Color(0xff959025), const Color(0xfffbf236)],
  GameColors.hairPurple : [const Color(0xff6e598f), const Color(0xff826ba9)],

  //EYES
  GameColors.eyesBlack : [const Color(0xff000000)],
  GameColors.eyesBlue : [const Color(0xff306082)],
  GameColors.eyesGreen : [const Color(0xff567a34)],
  GameColors.eyesRed : [const Color(0xffac3232)],
  GameColors.eyesYellow : [const Color(0xfffbf236)],
};
