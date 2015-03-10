library game;

import "dart:math";
import "dart:collection";

import "package:state_of_nature/dingus.dart";

part "src_game/ent_base.dart";
part "src_game/ent_misc.dart";
part "src_game/ent_mobs.dart";

class GameScene extends Scene {
	Vector camPos;
	static const CAMSPEED = 500;
	
	bool commonwealth;
	EntMan king;
	
	List<int> tiles;
	List<GameEntity> entMap;
	static const int MAP_WIDTH=40;
	static const int MAP_HEIGHT=20;
	static const int TILE_WIDTH=32;
	static const int TILE_HEIGHT=32;
	
	static const TILE_GRASS = 0;
	static const TILE_WALL = 1;
	
	int getTile(int x, int y) {
		return tiles[x+MAP_WIDTH*y];
	}
	
	void setTile(int x, int y, int t) {
		tiles[x+MAP_WIDTH*y] = t;
	}
	
	static Vector getTilePos(int x, int y) {
		return new Vector(x*TILE_WIDTH+TILE_WIDTH/2,y*TILE_HEIGHT+TILE_HEIGHT/2);
	}
	
	void signalEnt(int x, int y, GameEntity e) {
		var current = entMap[x+MAP_WIDTH*y];
		if (current!=null) {
			e.signalCollide(current);
			current.signalCollide(e);
		} else {
			entMap[x+MAP_WIDTH*y] = e;
		}
	}
	
	//gets random x,y coords for entity
	int rx() {
		var r = new Random();
		return r.nextInt(MAP_WIDTH-2)+1;
	}
	
	int ry() {
		var r = new Random();
		return r.nextInt(MAP_HEIGHT-2)+1;
	}
	
	@override
	void init() {
		print("[Scene Init]");
		
		//Camera
		camPos = new Vector();
		
		//Tilemap
		tiles = new List.filled(MAP_WIDTH*MAP_HEIGHT,0);
		for (int x=0;x<MAP_WIDTH;x++) {
			setTile(x,0,1);
			setTile(x,MAP_HEIGHT-1,1);
		}
		for (int y=0;y<MAP_HEIGHT;y++) {
			setTile(0,y,1);
            setTile(MAP_WIDTH-1,y,1);
        }
		
		commonwealth = false;
        king = null;
		
		//Ents
		entMap = new List.filled(MAP_WIDTH*MAP_HEIGHT,null); 
		
		var rand = new Random();
		for (int x=1;x<MAP_WIDTH-1;x++) {
			for (int y=1;y<MAP_HEIGHT-1;y++) {
				int n = rand.nextInt(100);
				
				if (n<30) {
					addEnt(new EntTree(x,y));
				} else if (n<35) {
					addEnt(new EntMan(x,y));
				} else if (n<40) {
					addEnt(new EntCritter(x,y));
				}
			}
		}
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
		g.clear("CornflowerBlue");
		
		g.setCamPos(camPos);
		
		var img_grass = content.getImage("grass.png");
		var img_wall = content.getImage("wall.png");
		
		for (int x=0;x<MAP_WIDTH;x++) {
			for (int y=0;y<MAP_HEIGHT;y++) {
				if (getTile(x, y)==TILE_WALL) {
					g.ctx.drawImage(img_wall,x*TILE_WIDTH,y*TILE_HEIGHT);
				} else {
					g.ctx.drawImage(img_grass,x*TILE_WIDTH,y*TILE_HEIGHT);
				}
			}
		}
		
		entMap.fillRange(0, MAP_WIDTH*MAP_HEIGHT, null);
    }
    @override
    void postUpdate(Graphics g, num dt) {
    	if (controls.keys_down[67]) {
    		if (king==null || !king.isValid()){
    			king= findEnt((var e) => e is EntMan);
    			king.king=true;
    		}
    		commonwealth=true;
    	}
    	
    	if (controls.keys_down[65])
           	commonwealth=false;


    		
    	//"a" "c"
    }
}