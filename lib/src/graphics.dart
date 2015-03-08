part of dingus;

class Graphics {
	Game _game;
	CanvasRenderingContext2D ctx;
	
	int get width => _game._canvas.width;
	int get height => _game._canvas.height;
	
	Graphics._make(this._game) {
		ctx = _game._canvas.context2D;
	}
	
	void setCamPos(Vector pos) {
		ctx.setTransform(1, 0, 0, 1, pos.x.toInt(), pos.y.toInt());
	}
	
	void clear(String style) {
		ctx.fillStyle = style;
        ctx.fillRect(0,0,width,height);
	}
}