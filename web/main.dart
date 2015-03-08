// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

//import 'dart:html';
import 'package:state_of_nature/dingus.dart';

void main() {
	Game game = new Game();
	game.addScene("test", new TestScene());
	game.startScene("test");
}

class TestScene extends Scene {
	Vector camPos;
	static const CAMSPEED = .5;
	
	int tile_width=13;
	int tile_height=13;
	List<int> tiles;
	
	@override
	void init() {
		print("[Scene Init]");
		camPos = new Vector();
		tiles = new List.filled(tile_width*tile_height,0);
	}
	@override
    void preUpdate(Graphics g, num dt) {
		if (controls.keys[38])
			camPos.y+=CAMSPEED*dt;
		else if (controls.keys[40])
        	camPos.y-=CAMSPEED*dt;
		
		if (controls.keys[37])
			camPos.x+=CAMSPEED*dt;
		else if (controls.keys[39])
        	camPos.x-=CAMSPEED*dt;
		
		g.setCamPos(Vector.ZERO);
		g.clear("black");
		
		g.setCamPos(camPos);
    }
    @override
    void postUpdate(Graphics g, num dt) {
    	g.ctx.fillStyle = "orange";
    	g.ctx.font = "30px comic sans ms";
    	g.ctx.fillText("The State of Nature", 10, 100);
    	
    	g.ctx.fillStyle = "purple";
    	g.ctx.font = "20px comic sans ms";
    	g.ctx.fillText("a vidya game", 10, 120);
    	
    	Vector v = new Vector(3,4,5);
    	Vector n = new Vector(7,7,7);
    	
    	g.ctx.drawImage(content.getImage("heyo.png"),300, 300);
    	
    	g.ctx.fillStyle = "lime";
    	g.ctx.font = "10px arial";
    	g.ctx.fillText("Vector sum is: ${v+n}!", 70, 150);
    }
}