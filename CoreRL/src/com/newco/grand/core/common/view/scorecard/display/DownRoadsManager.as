package com.newco.grand.core.common.view.scorecard.display {
	
	import com.newco.grand.core.common.view.scorecard.data.ResultTypes;
	import com.newco.grand.core.common.view.scorecard.display.road.IRoad;
	import com.newco.grand.core.common.view.scorecard.display.road.result.IResult;
	
	/**
	 * This class is responsible for assigning the correct 2 cells of the
	 * 3x2 grid to each of the down roads, then adding the correct result
	 * to each down road based on the data of those two cells.
	 * 
	 * The subset of data, a maximum 3x2 grid, is formed outside of this
	 * class and passed in on each occasion.
	 */
	public class DownRoadsManager {
		
		protected var _downRoads:Array;
		
		public function DownRoadsManager(){}
		
		/**
		 * Considers two results and determins whether the affect on the down
		 * road should be either a Player or Banker Result. Also takes into
		 * account whether the latest result on the Big Road is the same as
		 * the one which came before, and changes the rules accordingly.
		 * 
		 * @param subResultA The first IResult to be considered. Could be null.
		 * @param subResultB The second IResult to be considered. Could be null.
		 * @param repeatedResult Boolean indicating whether the latest result
		 * on Big Road is the same as the one which came before.
		 */
		protected function calculateType(subResultA:IResult, subResultB:IResult, repeatedResult:Boolean):String {			
			var type:String;
			
			var tA:String = subResultA ? subResultA.userType : "empty";
			var tB:String = subResultB ? subResultB.userType : "empty";
			
			if(repeatedResult) {
				type = tA == tB ? ResultTypes.BANKER : ResultTypes.PLAYER;
			}
			else {
				type = tA == tB ? ResultTypes.PLAYER : ResultTypes.BANKER;
			}
			
			return type;
		}
		
		/**
		 * Adds the down roads to this class for management.
		 * @param ...rest A number of IRoad implementations to be managed as down roads
		 */
		public function addDownRoads(...rest):void {
			_downRoads = rest;
		}
		
		/**
		 * Applies the subset 3x2 grid to the down roads
		 * @param subset A 3x2 Array containing IResult instances or null values
		 * @param numColumns The number of columns in the Big Road. Should be at least 1.
		 */
		public function applySubset(subset:Array, numColumns:uint, repeatedResult:Boolean):void {
			var length:uint = numColumns > 3 ? 3 : numColumns-1; 
			for(var i:uint; i < length; i++) {
				//Subset grid is evaluated from right to left,
				//and applied to the down roads in the _downRoads
				//Array from 0 to n.
				var a:Array = subset.splice(subset.length-1, 1);
				var downRoad:IRoad = _downRoads[i];
				
				downRoad.newResult( calculateType(a[0][0], a[0][1], repeatedResult) );
			}
		}

	}
}