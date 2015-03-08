part of dingus;

class Controls {
	bool debug=true;
	
	List<bool> keys = new List.filled(256,false);
	List<bool> keys_down = new List.filled(256,false);
	List<bool> keys_up = new List.filled(256,false);

	Controls._make(HtmlElement element) {
		window.onKeyDown.listen((KeyboardEvent e) {
			if (!keys[e.which]) {
				keys_down[e.which]=true;
				if (debug)
                	print("Pressed: " + e.which.toString());
			}
			keys[e.which]=true;
		});
		window.onKeyUp.listen((KeyboardEvent e) {
			keys_up[e.which]=true;
			keys[e.which]=false;
			if (debug)
            	print("Released: " + e.which.toString());
		});
	}
	
	void _endFrame() {
		keys_down.fillRange(0, 256, false);
		keys_up.fillRange(0, 256, false);
	}
}