package;

import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Quad;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageQuality;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.TouchEvent;
import flash.events.MouseEvent;
import flash.Lib;
import nme.events.AccelerometerEvent;
import nme.text.TextField;


class Tetroid
{
	public var mColor:Int;
	public var mType:Int;
	public var mXPos:Int;
	public var mYPos:Int;
	
	public function new () {
		
	
	}
}

class VsTetris extends Sprite {
	
	private static var StageWidth:Int = 640;
	private static var StageHeight:Int = 480;
	
	private static var GRID_SIZE_X:Int = 10;
	private static var GRID_SIZE_Y:Int = 50;
	

	private var square:Sprite;
	private var tetroid:Tetroid;
	
	private var Result:TextField;
	
	
	private static var BT_STATIC_BLOCK:Int = -1;
	
	private var currentP1Tetroid:Tetroid;
	
	private var grid:Array<Array<Int>>;
	
	public function new () {
		
		super ();
		
		initialize ();
		construct ();
		
		
	}
	
	
	private function construct ():Void {
		
		addChild(square);
		
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
 
	}
	

	private function initialize ():Void {
		
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		
		//this.setHeight = 640;
		//this.setWidth = 480;
		
		
		Lib.current.stage.addEventListener (Event.ACTIVATE, stage_onActivate);
		Lib.current.stage.addEventListener (Event.DEACTIVATE, stage_onDeactivate);
		
		square = new Sprite();
		
		Result = new TextField();
		
		//Lib.current.stage.addEventListener(AccelerometerEvent.UPDATE, on_acccelerometerEvent);
		Lib.current.stage.addEventListener(TouchEvent.TOUCH_BEGIN, on_TouchBegin);
		Lib.current.stage.addEventListener(TouchEvent.TOUCH_END, on_TouchEnd);
		Lib.current.stage.addEventListener(TouchEvent.TOUCH_MOVE, on_TouchMove);
		
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, on_MouseDown);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, on_MouseUp);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, on_MouseMove);
		
		initGrid();
		
		
		currentP1Tetroid = new Tetroid();
		currentP1Tetroid.mXPos = 5;
		currentP1Tetroid.mYPos = 5;
	}

	private function initGrid()
	{
		grid = new Array<Array<Int>>();
		for (x in 0...GRID_SIZE_X)
		{
			grid[x] = new Array<Int>();
			for (y in 0...GRID_SIZE_Y)
			{
				grid[x][y] = 0;
			}
		}
		
		//grid[5][10] = BT_STATIC_BLOCK; //test
	
	}
	
	private var Pressed:Bool;
	private var lastMouseX:Float;
	private var lastMouseY:Float;
	

	private function on_TouchMove (event:TouchEvent ):Void
	{
		lastMouseX = event.stageX;
		lastMouseY = event.stageY;
		//
	}
	
	private function on_TouchEnd (event:Event ):Void
	{
		Pressed = false;
		//
	}
	
	private function on_TouchBegin (event:Event ):Void
	{
		Pressed = true;
		
		//
	}
	
	private function on_MouseDown (event:Event ):Void
	{
		Pressed = true;
		//
	}
	
	private function on_MouseUp (event:MouseEvent ):Void
	{
		Pressed = false;
	
		//
	}
	
	private function on_MouseMove (event:MouseEvent ):Void
	{

		lastMouseX = event.stageX;
		lastMouseY = event.stageY;
		
		//
	}
	
	
	// Event Handlers
	
	
	
	private function on_acccelerometerEvent (event:AccelerometerEvent ):Void {
		
		//circle.x +=  event.accelerationX;
		//circle.x = Math.min(stage.stageWidth, circle.x);
		//circle.x = Math.max(0, circle.x);
		
	}
		
	
	private function stage_onActivate (event:Event):Void {
		
		Actuate.resumeAll ();
		
	}
	
	
	private function stage_onDeactivate (event:Event):Void {
		
		Actuate.pauseAll ();
		
	}


	private function updateGrid() :Void
	{
		var canMove:Bool = currentP1Tetroid.mYPos < GRID_SIZE_Y && grid[currentP1Tetroid.mXPos][currentP1Tetroid.mYPos + 1] == 0;
		
		
		
		if (canMove)
		{
		
			// 1 - Remove current
			grid[currentP1Tetroid.mXPos][currentP1Tetroid.mYPos] = 0;
			
			// 2 - Move current
			currentP1Tetroid.mYPos += 1;
			
			// 3- update grid
			grid[currentP1Tetroid.mXPos][currentP1Tetroid.mYPos] = 1;
		}else {
			// 1 - Commit to static
			grid[currentP1Tetroid.mXPos][currentP1Tetroid.mYPos] = BT_STATIC_BLOCK;
			
			// 2 -Add a new one
			currentP1Tetroid.mYPos = 0;
			
			// 3- update grid
			grid[currentP1Tetroid.mXPos][currentP1Tetroid.mYPos] = 1;
		}
	
	}
	
	private var prevFrameTime:Int = 0;
	private var nextGridUpdateTime:Int = 0;
	
	
	private function this_onEnterFrame (event:Event):Void {
		
		
		var currentTime:Int = flash.Lib.getTimer();
		var dt:Int = (currentTime - prevFrameTime);
		prevFrameTime = currentTime;
		
		if (currentTime >= nextGridUpdateTime)
		{
			updateGrid();
			nextGridUpdateTime = currentTime + 200;
		}
			
		
		square.graphics.clear();
	
		square.graphics.lineStyle(1.0, 0xff0000, 1);
		square.graphics.beginFill(0xff0000, 1);
		for (x in 0...GRID_SIZE_X)
		{
			for (y in 0...GRID_SIZE_Y)
			{
				if(grid[x][y] != 0)
					square.graphics.drawRect(x * 10 ,y * 10, 10, 10);
			}
		}
		
		//Tetroid.graphics.drawRect(0, 0, 10, 10);
		//Tetroid.graphics.drawRect(10, 10, 20, 20);
		
	}
	
	
	
	// Entry point
	
	
	
	
	public static function main () {
		
		Lib.current.addChild (new VsTetris ());
		
	}
	
	
}
