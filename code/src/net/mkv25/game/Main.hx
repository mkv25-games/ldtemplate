package net.mkv25.game;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import net.mkv25.game.event.EventBus;

// PROTIP: Don't be afraid to use Index.someModel any where your game code
class Main extends Sprite 
{
	var inited:Bool;
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;

		// set up the index
		Index.setup();
		
		// wire up the index - this stuff might normally live in a controller
		Index.screenController.setup(stage);
		Index.screenController.addScreen(Index.introScreen);
		EventBus.requestNextScreen.add(Index.screenController.handleRequestNextScreen);
		EventBus.requestLastScreen.add(Index.screenController.handleRequestLastScreen);
		
		// go!
		EventBus.requestNextScreen.dispatch(this);
	}

	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
