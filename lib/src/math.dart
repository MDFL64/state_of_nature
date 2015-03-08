part of dingus;

class Vector {
	num x,y,z;
	
	Vector([this.x=0,this.y=0,this.z=0]);
	
	static final Vector ZERO = new Vector();
	static final Vector X = new Vector(1,0,0);
	static final Vector Y = new Vector(0,1,0);
	static final Vector Z = new Vector(0,0,1);
	
	Vector operator+(Vector other) {
		return new Vector(x+other.x,y+other.y,z+other.z);
	}
	
	Vector operator-(Vector other) {
		return new Vector(x-other.x,y-other.y,z-other.z);
	}
	
	num sqrLen() {
		return x*x+y*y+z*z;
	}
	
	@override
	String toString() {
		return "Vector($x, $y, $z)";
	}
}