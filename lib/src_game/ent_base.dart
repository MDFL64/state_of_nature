part of game;

abstract class GameEntity extends Entity {
	GameEntity(this.pos);
	Vector pos=new Vector();
}


class EntMob extends GameEntity {
	int cellX;
	int cellY;
	
	EntMob(this.cellX,this.cellY) : super(GameScene.getTilePos(cellX, cellY));
	
	@override
	void update(Graphics g, num dt) {
		var img = content.getImage("dude.png");
		g.drawImg(img, pos);
	}
}