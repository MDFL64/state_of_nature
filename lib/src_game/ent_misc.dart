part of game;

class EntTree extends GameEntity {
	int cellX, cellY;
	
	EntTree(int x, int y) : super(GameScene.getTilePos(x, y)) {
		cellX = x;
		cellY = y;
	}
	
	@override
	void update(Graphics g, num dt) {
		GameScene s = scene;
		s.signalEnt(cellX,cellY, this);
		
		var img = content.getImage("tree.png");
		g.drawImg(img, pos, .7);
	}
}

class EntCampfire extends GameEntity {
	EntCampfire(Vector p) : super(p);
	
	num life = 5;
	
	@override
	void update(Graphics g, num dt) {
		life-=dt;
		
		if (life<0)
			delete();
		
		var img = content.getImage("campfire.png");
		g.drawImg(img, pos, .6);
	}
}