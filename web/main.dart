// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

//import 'dart:html';
import 'package:state_of_nature/dingus.dart';
import "package:state_of_nature/game.dart";

void main() {
	Game game = new Game();
	game.addScene("test", new GameScene());
	game.startScene("test");
}