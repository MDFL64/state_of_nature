// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

//import 'dart:html';
import 'package:state_of_nature/dingus.dart';
import "package:state_of_nature/game.dart";

void main() {
	Game game = new Game();
	game.addScene("test", new TestScene());
	game.startScene("test");
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
	  
	  if(counter < 4.0)
	  {
	     g.clear("black");
	     var img_logo = content.getImage("logo.png");
	    g.ctx.drawImage(img_logo,0,0);
	     counter = counter + dt;
	     return;
	  }
	  var img_about = content.getImage("about.png");
	  var img_menu = content.getImage("menu.png");
	  var img_controls = content.getImage("controls.png");
	  g.ctx.drawImage(img_menu,0,0);
	  if(controls.keys[65]) //If statement to bring up the About the Game
	  {
	    s1 = true;
	  }
	  if(s1 == true)
	  {
	    g.ctx.drawImage(img_about,0,0);
	    if(controls.keys[13])
	       s1 = false;
	  }
	  if(controls.keys[67]) //If statement to bring up the controls.
        {
          s2 = true;
        }
     if(s2 == true)
        {
          g.ctx.drawImage(img_controls,0,0);
          if(controls.keys[13])
             s2 = false;
        }
}
	
    @override
    void postUpdate(Graphics g, num dt) {
    	
    }
}