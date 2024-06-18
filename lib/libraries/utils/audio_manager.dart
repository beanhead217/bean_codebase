import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

// This class is responsible for playing all the sound effects
// and background music in this game.
class AudioManager {
  static final sfx = ValueNotifier(true);
  static final bgm = ValueNotifier(true);
  static late AudioPlayer soundFX;

  static Future<void> init() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll([
      "5.56-AR15-C.mp3",
      "5.56-AR15-A.mp3",
      "5.56-AR15-B.mp3",
      "5.56-AR15-D.mp3",
      "5.56-AR15-E.mp3",
      "12-Gauge-Pump-Action-Shotgun-A.mp3",
      "12-Gauge-Pump-Action-Shotgun-B.mp3",
      "308-Bolt-Action-Rifle-A.mp3",
      "308-Bolt-Action-Rifle-Suppressed-A.mp3",
      "308-Bolt-Action-Rifle-Suppressed-B.mp3",
      "1911-.45-ACP-A.mp3",
      "AR10-7.62x51-308-A.mp3",
      "AR10-7.62x51-308-B.mp3",
      "Barrett-M82-.50-BMG-A.mp3",
      "Barrett-M82-.50-BMG-B.mp3",
      "Dry-Pistol-gunfire-A.mp3",
      "P226-9mm-A.mp3",
      "P226-9mm-B.mp3",
      "P226-9mm-C.mp3",
      "P226-9mm-D.mp3",
      "Smith-&-Wesson-500-Magnum-A.mp3",
      "Smith-&-Wesson-500-Magnum-B.mp3",
      "Suppressed-Bushmaster-ACR-5.56-A.mp3",
      "Suppressed-Bushmaster-ACR-5.56-B.mp3",
      "Suppressed-Bushmaster-ACR-5.56-C.mp3",
      "44 Magnum Eject Full With Floor Impact.wav",
      "762x39 Single WAV.wav"
    ]);
  }





  static void playSfx(String file) {
    if (sfx.value) {
      FlameAudio.play(file, volume: .5);
    }
  }

  static void playLoopSfx(String file) async {
    soundFX = await FlameAudio.loopLongAudio(file, volume: 1.0);
  }
  // AudioManager.soundFX.stop();

  static void playBgm(String file) {
    if (bgm.value) {
      FlameAudio.bgm.play(file);
    }
  }

  static void pauseBgm() {
    FlameAudio.bgm.pause();
  }

  static void resumeBgm() {
    if (bgm.value) {
      FlameAudio.bgm.resume();
    }
  }

  static void stopBgm() {
    FlameAudio.bgm.stop();
  }
}
