package com.newco.grand.lobby.classic.view.scorecard.display.road {
	
	import com.newco.grand.lobby.classic.view.scorecard.display.road.behaviours.IAddBehaviour;
	import com.newco.grand.lobby.classic.view.scorecard.display.road.grid.Grid;
	import com.newco.grand.lobby.classic.view.scorecard.display.road.grid.IGrid;
	import com.newco.grand.lobby.classic.view.scorecard.display.road.result.IResult;
	import com.newco.grand.core.common.view.ui.views.BaseView;
	
	import flash.display.Sprite;
	
	import fl.containers.ScrollPane;

	/**
	 * Represents a Road of columns filled with results. This is comprised
	 * of a Grid to arrange and store the results plus a scroll pane to
	 * accomodate the expansion of the Grid. 
	 * @author Elliot Harris
	 */
	public class Road extends BaseView implements IRoadModifiable {
		
		protected var _scrollPane:ScrollPane;
		protected var _grid:IGrid;
		
		//2-dimensional Array of the last coordinates: a[0] = x coordinate, a[1] = y coordinate
		protected var _lastCoordinates:Array = new Array(2);
		
		//The behaviour used when adding results to the road
		protected var _addBehaviour:IAddBehaviour;
		
		public function Road(target:Sprite, width:Number=200, height:Number=200) {
			super(target);
			init(width, height);
		}
		
		protected function init(w:Number, h:Number):void {
			_grid = new Grid(_target.addChild(new Sprite()) as Sprite);
			
			_scrollPane = _target.getChildByName("scrollPane") as ScrollPane;
			_scrollPane.setSize(w, h);
			_scrollPane.source = _grid.target;
		}
		
		override public function get width():Number{ return _scrollPane.width; }
		override public function get height():Number{ return _scrollPane.height; }
		
		/**
		 * Called by the parent class when a new result comes in.
		 * 
		 * @param type The type of result, as defined by ResultTypes
		 * @param score An optional score value for the result
		 */
		public function newResult(type:String, score:uint=0, clr:uint=0xFFFFFF):void {
			_addBehaviour.newResult(type, score, clr);
		}
		
		public function clear():void {
			_grid.clear();
		}
		
		/**
		 * Called by the add behaviour once it's finished creating the
		 * result - here actual result object is added to the Grid
		 * 
		 * @param result The IResult instance to add
		 * @param xPos The x position in which to add the result
		 * @param yPos The y position in which to add the result 
		 */ 
		public function addResult(result:IResult, xPos:uint, yPos:uint):void {
			_lastCoordinates[0] = xPos;
			_lastCoordinates[1] = yPos;
			_grid.addToGridAt(result, xPos, yPos);			
			_scrollPane.update();
		}
		
		/**
		 * Returns a two-dimensional array or results starting from the position
		 * at startX, startY up to, but not including, the position at
		 * endX, endY.
		 * 
		 * The start coordinates must be less than the end coordinates, or an
		 * empty Array is returned.
		 */
		public function getSubset(startX:int, startY:int, endX:int, endY:int):Array {
			var a:Array = new Array();
			for(var i:int=startX; i < endX; i++) {
				var c:Array = new Array(); //represents a column
				for(var j:int=startY; j < endY; j++) {
					if(i < 0 || j < 0) c.push( null );
					else c.push( _grid.getResultAt(i, j) );
				}
				a.push( c );
			}
			
			return a;
		}
		
		public function set addBehaviour(v:IAddBehaviour):void {
			_addBehaviour = v;
			_addBehaviour.road = this;
		}
		
		/**
		 * Returns the last IResult added to the grid
		 */
		public function get lastResult():IResult {
			return _grid.getResultAt(_lastCoordinates[0], _lastCoordinates[1]);
		}
		
		public function get lastXPos():uint{ return _lastCoordinates[0]; }
		
		public function get lastYPos():uint{ return _lastCoordinates[1]; } 
	}
}