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
	static const CAMSPEED = 500;
	
	List<int> tiles;
	static const int MAP_WIDTH=30;
	static const int MAP_HEIGHT=30;
	static const int TILE_WIDTH=32;
	static const int TILE_HEIGHT=16;
	
	static const TILE_GRASS = 0;
	static const TILE_WALL = 1;
	
	int getTile(int x, int y) {
		return tiles[x+MAP_WIDTH*y];
	}
	
	void setTile(int x, int y, int t) {
		tiles[x+MAP_WIDTH*y] = t;
	}
	
	@override
	void init() {
		print("[Scene Init]");
		camPos = new Vector();
		tiles = new List.filled(MAP_WIDTH*MAP_HEIGHT,0);
		setTile(0,10,1);
		setTile(0,29,1);
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
		g.clear("cyan");
		
		g.setCamPos(camPos);
		
		var img_grass = content.getImage("grass.png");
		var img_wall = content.getImage("wall.png");
		
		for (int x=0;x<MAP_WIDTH;x++) {
			for (int y=0;y<MAP_HEIGHT;y++) {
				if (getTile(x, y)==TILE_WALL) {
					g.ctx.drawImage(img_wall,x*TILE_WIDTH,y*TILE_HEIGHT-24);
				} else {
					g.ctx.drawImage(img_grass,x*TILE_WIDTH,y*TILE_HEIGHT);
				}
			}
		}
    }
    @override
    void postUpdate(Graphics g, num dt) {
    	
    }
}