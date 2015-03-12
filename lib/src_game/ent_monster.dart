part of game;

class EntMonster extends GameEntity {
	EntMonster(Vector pos,this.crown) : super(pos);
	
	Vector goal;
	bool crown=false;
	
	@override
	void update(Graphics g, num dt) {
		Random r = new Random();
		
		if (goal==null || (pos-goal).sqrLen()<10000)
			goal = new Vector(r.nextDouble()*1300,r.nextDouble()*700);
		
		pos+= (goal-pos)*.01;
		

		GameEntity e = scene.findEnt((var p) => ((p.pos-pos).sqrLen()<10000 && !(p is EntFire) && !(p is EntMonster)));
		if (e!=null) {
			e.delete();
			scene.addEnt(new EntFire(e.pos));
		}
		
		var img = content.getImage("monster.png");
		g.drawImg(img, pos);
		if (crown)
			g.drawImg(content.getImage("crown.png"), pos+new Vector(-20,-75));
	}
}

class EntFire extends GameEntity {
	EntFire(Vector pos) : super(pos);
	
	num life = 5;
	
	@override
    void update(Graphics g, num dt) {
		life-=dt;
		if (life<0)
			delete();
        		
		var img = content.getImage("fire.png");
        g.drawImg(img, pos, .3);
	}
}