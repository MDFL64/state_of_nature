part of game;

class EntTree extends GameEntity {
	EntTree(Vector pos) : super(pos);
	
	@override
	void update(Graphics g, num dt) {
		var img = content.getImage("tree.png");
		g.drawImg(img, pos);
	}
}