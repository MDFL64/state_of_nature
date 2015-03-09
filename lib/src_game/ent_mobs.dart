part of game;

class EntMan extends EntMob {
	EntMan(int x, int y) : super(x,y);
	
	void drawMob(Graphics g) {
		var img;
		if (task=="dead")
			img = content.getImage("humanDead.png");
		else if (task=="fight") {
			img = content.getImage(rand.nextBool()?"humanR.png":"humanL.png");
		}
		else if (moveDir==1) {
			img = content.getImage("humanR.png");
		} else if (moveDir==2) {
			img = content.getImage("humanL.png");
		} else if (moveDir==4) {
			img = content.getImage("humanB.png");
		} else {
			img = content.getImage("humanF.png");
		}
		
		if (task=="fight")
        	g.drawImg(img, pos+new Vector(rand.nextDouble()*20-10,rand.nextDouble()*20-10), .5);
		else
			g.drawImg(img, pos, .5);
	}
	
	@override
	void signalCollide(GameEntity other) {
		if (other is EntTree) {
			if (rand.nextInt(1000)==0) {
				other.delete();
				doFire();
			}
		} else if (other is EntCritter) {
			if (rand.nextInt(100)==0) {
				other.delete();
				doFire();
			}
		} else if (other is EntMan) {
			if (other.task=="dead" || (task!="fight" && other.task=="fight"))
				return;
			if (rand.nextInt(100)==0) {
				if (task=="fight") {
					if (rand.nextInt(3)==0) {
						die();
					} else {
						task="wander";
					}
					other.die();
				} else {
					setFight();
					other.setFight();
				}
				
				
				//other.delete();
				//doFire();
			}
		}
	}
	
	void doFire() {
		scene.addEnt(new EntCampfire(pos+new Vector(40,0)));
		setWait(2);
	}
}

class EntCritter extends EntMob {
	EntCritter(int x, int y) : super(x,y);
	
	void drawMob(Graphics g) {
		var img = content.getImage("rabbit.png");
        g.drawImg(img, pos, .5);
	}
}