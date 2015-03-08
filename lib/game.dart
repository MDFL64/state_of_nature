library game;

import "package:state_of_nature/dingus.dart";

//Vector getTilePos(int x, int y) {
	//return new Vector(x*TILE_WIDTH+TILE_WIDTH/2,y*TILE_HEIGHT+TILE_HEIGHT/2);
//}

abstract class GameEntity extends Entity {
	GameEntity(this.pos);
	Vector pos=new Vector();
}

class EntTree extends GameEntity {
	EntTree(Vector pos) : super(pos);
	
	@override
	void update(Graphics g, num dt) {
		var img = content.getImage("tree.png");
		g.drawImg(img, pos);
	}
}
/*
class EntMob extends GameEntity {
	int cellX;
	int cellY;
	
	
	
	@override
	void update(Graphics g, num dt) {
		if (pos==null)
			GameScene s = 
			(GameScene)scene.getTilePos(x, y);
		
		var img = content.getImage("tree.png");
		g.drawImg(img, pos);
	}
}*/