part of game;

abstract class GameEntity extends Entity {
	GameEntity(this.pos);
	Vector pos=new Vector();
	
	void signalCollide(GameEntity other) {
		//stub
	}
}


abstract class EntMob extends GameEntity {
	int goalX;
	int goalY;
	
	num speed= 75;
	num health= 5;
	
	num waitTime=0;
	
	String task = "wander";
	int moveDir;
	Queue<Vector> path = new Queue();
	
	Random rand = new Random();
	
	EntMob(x,y) : super(GameScene.getTilePos(x, y)) {
		goalX = x;
		goalY = y;
		//pickDir()
		moveDir=0;
	}
	
	@override
	void update(Graphics g, num dt) {
		Vector goal = GameScene.getTilePos(goalX, goalY);
		
		drawMob(g);
                
        GameScene s = scene;
        s.signalEnt(goalX,goalY, this);
		
        if (task=="fight")
        	return;
        else if (task == "wait" || task=="dead") {
			waitTime-=dt;
			if (waitTime>0) {
				return;
			} else if (task=="dead") {
				delete();
			}
			task = "wander";
		}
		
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
        		if (rand.nextInt(5)==0 || !canMove(moveDir))
                	pickDir();
        		switch (moveDir) {
        			case 1:
        				goalX+=1;
        				break;
        			case 2:
        				goalX-=1;
        				break;
        			case 3:
        				goalY+=1;
        				break;
        			case 4:
        				goalY-=1;
        				break;
        		}
            }
        }
	}
	
	bool canMove(int dir) {
		var tile;
		GameScene gs = scene;
		switch (dir) {
			case 1:
				tile = gs.getTile(goalX+1,goalY);
				break;
			case 2:
				tile = gs.getTile(goalX-1,goalY);
				break;
			case 3:
				tile = gs.getTile(goalX,goalY+1);
				break;
			case 4:
				tile = gs.getTile(goalX,goalY-1);
				break;
		}
		return tile==0;
	}
	
	void pickDir() {
		List<int> canidates = [];
		for (int d=1;d<=4;d++)
			if (canMove(d))
				canidates.add(d);
		if (canidates.length==0)
			moveDir = 0;
		else
			moveDir = canidates[rand.nextInt(canidates.length)];
	}
	
	void setWait(num t) {
		task="wait";
		waitTime = t;
		moveDir = 0;
	}
	
	void setFight() {
		task="fight";
		moveDir = 0;
	}
	
	void die() {
		task="dead";
		waitTime = 5;
        moveDir = 0;
	}
	
	void drawMob(Graphics g);
}