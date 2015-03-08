part of game;

abstract class GameEntity extends Entity {
	GameEntity(this.pos);
	Vector pos=new Vector();
}


class EntMob extends GameEntity {
	int goalX;
	int goalY;
	
	num speed= 100;
	num health= 5;
	
	String task = "wander";
	int moveDir;
	Queue<Vector> path = new Queue();
	
	Random rand = new Random();
	
	EntMob(x,y) : super(GameScene.getTilePos(x, y)) {
		moveDir = rand.nextInt(4);
		goalX = x;
		goalY = y;
	}
	
	@override
	void update(Graphics g, num dt) {
		Vector goal = GameScene.getTilePos(goalX, goalY);
		
		//Movement
		if (speed*dt>(goal.x-pos.x).abs())
			pos.x=goal.x;
		else
			pos.x += ((goal.x-pos.x)>0?1:-1)*speed*dt;
		if (speed*dt>(goal.y-pos.y).abs())
        	pos.y=goal.y;
        else
        	pos.y += ((goal.y-pos.y)>0?1:-1)*speed*dt;
		
        //Decision making
        if ((goal-pos).sqrLen()<1) {
        	if (task=="wander") {
        		if (rand.nextInt(5)==0)
                	moveDir = rand.nextInt(4);
        		switch (moveDir) {
        			case 0:
        				goalX+=1;
        				break;
        			case 1:
        				goalX-=1;
        				break;
        			case 2:
        				goalY+=1;
        				break;
        			case 3:
        				goalY-=1;
        				break;
        		}
            }
        }
		
		var img = content.getImage("dude.png");
		
		g.drawImg(img, pos);
	}
}