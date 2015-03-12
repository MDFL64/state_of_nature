// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

//import 'dart:html';
import 'package:state_of_nature/dingus.dart';
import "package:state_of_nature/game.dart";

void main() {
	Game game = new Game();
	game.addScene("menu", new TestScene());
	game.addScene("game", new GameScene());
	game.startScene("menu");
}


class TestScene extends Scene {
  double counter = 0.0;
  bool s1 = false;//These keep track of the keys pressed to bring up About and the Controls
  bool s2 = false; 
	@override
	void init() {
		
	}
	@override
    void preUpdate(Graphics g, num dt) {
	  g.clear("black");
		
	  if(counter < 4.0)
	  {
	     var img_logo = content.getImage("logo.png");
	    g.drawImg(img_logo, new Vector(g.width/2,g.height/2));
	     counter = counter + dt;
	     return;
	  }
	  var img_about = content.getImage("about.png");
	  var img_menu = content.getImage("menu.png");
	  var img_controls = content.getImage("controls.png");
	  
	  if(s1 == true)
	  {
		  g.drawImg(img_about, new Vector(g.width/2,g.height/2));
	    if(controls.keys_down[13])
	       s1 = false;
	  }
	  else if(s2 == true)
      {
		  g.drawImg(img_controls, new Vector(g.width/2,g.height/2));
        if(controls.keys_down[13])
           s2 = false;
      } else {
    	  g.drawImg(img_menu, new Vector(g.width/2,g.height/2));
    	  if(controls.keys_down[65]) //If statement to bring up the About the Game
      	  {
      	    s1 = true;
      	  }
    	  else if(controls.keys_down[67]) //If statement to bring up the controls.
          {
            s2 = true;
          }
    	  else if(controls.keys_down[13]) {
    		  game.startScene("game");
    	  }
      }
	}
	
    @override
    void postUpdate(Graphics g, num dt) {
    	
    }
}