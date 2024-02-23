import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/services.dart';

enum GameState { playing, intro, gameOver }

class TRexGame extends FlameGame with KeyboardEvents, TapCallbacks, HasCollisionDetection {

  late final Image spriteImage;

  late final TextComponent scoreText;

  int _score = 0;
  int _highScore = 0;
  String scoreString(int score) => score.toString().padLeft(5, '0');

  set score(int newScore) {
    _score = newScore;
    scoreText.text = '${scoreString(_score)}  HI ${scoreString(_highScore)}';
  }

  @override
  Color backgroundColor() => const Color(0xFFFFFFFF);

  @override
  Future<void> onLoad() async {
    spriteImage = await Flame.images.load('trex.png');

    const chars = '0123456789HI ';
    final renderer = SpriteFontRenderer.fromFont(
      SpriteFont(
        source: spriteImage,
        size: 23,
        ascent: 23,
        glyphs: [
          for (var i = 0; i < chars.length; i++)
            Glyph(chars[i], left: 954.0 + 20 * i, top: 0, width: 20),
        ],
      ),
      letterSpacing: 2,
    );
    add(
      scoreText = TextComponent(
        position: Vector2(20, 20),
        textRenderer: renderer,
      ),
    );

    score = 0;
  }

}
