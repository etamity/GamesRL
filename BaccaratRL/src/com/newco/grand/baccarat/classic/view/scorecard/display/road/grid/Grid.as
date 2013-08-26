package com.newco.grand.lobby.classic.view.scorecard.display.road.grid {
	
	import com.newco.grand.lobby.classic.view.scorecard.display.road.result.IResult;
	import com.newco.grand.core.common.view.ui.views.BaseView;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * Defines an two dimensional Array of columns and rows, storing IResult
	 * instances in them and drawing the targets of those IResults into
	 * a grid formation within this classes target Sprite.
	 * 
	 * @author Elliot Harris
	 */
	public class Grid extends BaseView implements IGrid {
		//Padding is the space around the outer columns and rows of the grid
		protected var _hPadding:Number = 2;
		protected var _vPadding:Number = 2;
		
		//Spacing is the space between columns and rows on the grid
		protected var _hSpacing:Number = 2;
		protected var _vSpacing:Number = 2;
		
		protected var _columns:Array = new Array();
		
		public function Grid(target:Sprite) {
			super(target);
		}
		
		/**
		 * Creates a new column in both the data _columns Array and
		 * also as a new Sprite within the _target Sprite.
		 */
		protected function createColumn():void {
			var s:Sprite = new Sprite();
			s.x = _hPadding;
			s.y = _vPadding;
			if(_target.numChildren > 0) {
				var lastColumn:DisplayObject = _target.getChildAt(_target.numChildren-1);
				s.x = lastColumn.x + lastColumn.width + _hSpacing;
			} 
			_target.addChild(s);
			_columns.push( new Array() );
		}
		
		/**
		 * Adds a result to a specific column, at the next available row
		 * 
		 * @param result The result to be added
		 * @param columnIndex The index of the column to add to
		 */
		public function addToColumn(result:IResult, columnIndex:uint):void {
			var yPos:uint = columnIndex < _columns.length ? _columns[columnIndex].length : 0 
			addToGridAt(result, columnIndex, yPos);
		}
		
		/**
		 * Adds a result to a specific position in the grid
		 * 
		 * @param result The result to be added
		 * @param xPos The x position in which to add the result
		 * @param yPos The y position in which to add the result
		 */
		public function addToGridAt(result:IResult, xPos:uint, yPos:uint):void {
			//Ensure the column in which to which we are adding a result exists
			while(xPos >= _columns.length) {
				createColumn();
			}			
			
			var c:Array = _columns[xPos];
			var s:Sprite = _target.getChildAt(xPos) as Sprite; //The Sprite relating to the column
			result.x = 0;
			if(yPos < c.length) {
				//If the position is occupied, whatever is there is replaced
				var replace:IResult = c[yPos];
				result.y = replace.y;
				s.removeChild(replace.target);
				s.addChildAt(result.target, yPos);
				c[yPos] = result;
			}
			else {
				//If the position is not occupied, modify the y value of result
				//to be below the last result (if one exists)
				if(c.length > 0) {
					var lastResult:IResult = c[c.length-1];
					result.y = lastResult.y + lastResult.height + _vSpacing;
				}
				s.addChild(result.target);
				c.push( result );
			}
		}
		
		public function getResultAt(xPos:uint, yPos:uint):IResult {
			var r:IResult
			try {
				r = _columns[xPos][yPos];
			}
			catch(e:TypeError){}
			return r;
		}
		
		public function clear():void {
			while(_target.numChildren > 0) {
				_target.removeChildAt(0);
			}			
			_columns.splice(0);
		}
		
		public function set vSpacing(v:Number):void{ _vSpacing = v; }
		
		public function set hSpacing(v:Number):void{ _hSpacing = v; }
		
		public function set vPadding(v:Number):void{ _vPadding = v; }
		
		public function set hPadding(v:Number):void{ _hPadding = v; }
	}
}