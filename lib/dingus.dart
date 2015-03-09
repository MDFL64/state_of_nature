library dingus;

import "dart:html";
import "dart:js";

part "src/graphics.dart";
part "src/controls.dart";
part "src/content.dart";

part "src/math.dart";

class Game {
	CanvasElement _canvas;
	
	Graphics _graphics;
	
	Controls controls;
	Content content;
	
	JsObject _stats;
	
	num _lastFrameTime=0;
	
	Map<String,Scene> _scenes = new Map();
	Scene _activeScene;
	
	Game() {
		_canvas = new CanvasElement();
		_canvas.style.position = "fixed";
		_canvas.style.top = "0";
		_canvas.style.left = "0";
		document.body.append(_canvas);
		
		_graphics = new Graphics._make(this);
		controls = new Controls._make(_canvas);
		content = new Content._make();
		
		_resizeCanvas();
        window.onResize.listen((Event){_resizeCanvas();});
		
        _stats = new JsObject(context["Stats"]);
        Element stats_element = _stats["domElement"];
        stats_element.style..position = "absolute" ..right="0" ..top="0";
        document.body.append(stats_element);
        
        _update(0);
	}
	
	void addScene(String name, Scene scene) {
		_scenes[name] = scene;
		scene.game = this;
		scene.controls = controls;
		scene.content = content;
	}
	
	void startScene(String name) {
		if (_scenes[name]!=null) {
			_activeScene = _scenes[name];
			_activeScene.reset();
		}
	}
	
	void _resizeCanvas() {
		_canvas.width = window.innerWidth;
        _canvas.height = window.innerHeight;
	}
	
	void _update(num frameTime) {
		num dt = (frameTime-_lastFrameTime)/1000;
		_lastFrameTime=frameTime;
		
		if (dt<.1) { //FIXME good idea or no?
			_stats.callMethod("begin");
			if (_activeScene!=null) _activeScene._update(_graphics, dt);		
            controls._endFrame();
            _stats.callMethod("end");
		} else {
			print("DROPPED FRAME!");
		}
		
		window.requestAnimationFrame(_update);
	}
}

abstract class Scene {
	List<Entity> _ents = [];
	List<Entity> _ents_to_add = [];
	
	Game game;
	
	Controls controls;
    Content content;
	
	Scene() {}
	
	void addEnt(Entity ent) {
		_ents_to_add.add(ent);
		
		ent.game = game;
		ent.scene = this;
		ent.controls = controls;
		ent.content = content;
	}
	
	void reset() {
		_ents.clear();
		_ents_to_add.clear();
		init();
	}
	
	void init();
	void preUpdate(Graphics g, num dt);
	void postUpdate(Graphics g, num dt);
	
	void _update(Graphics g, num dt) {
		preUpdate(g, dt);
		
		for (var ent in _ents) {
			ent.update(g, dt);
		}
		
		postUpdate(g, dt);
		
		_ents.addAll(_ents_to_add);
		_ents_to_add=[];
		_ents.removeWhere((Entity e)=>e._delete);
	}
}

abstract class Entity {
	Game game;
    Scene scene;
    Controls controls;
    Content content;
	
	bool _delete = false;
	
	void delete() {
		_delete=true;
	}
	
	void update(Graphics g, num dt);
}