package com.newco.grand.core.common.view.scorecard.display.road.behaviours {
	
	import com.newco.grand.core.common.view.scorecard.data.ResultTypes;
	import com.newco.grand.core.common.view.scorecard.display.road.IRoadModifiable;
	import com.newco.grand.core.common.view.scorecard.display.road.result.IResult;
	import com.newco.grand.core.common.view.scorecard.display.road.result.Result;
	
	import flash.display.MovieClip;

	/**
	 * This behaviour class is used by the roads to modify slightly how they add results.
	 * It defines the target class to use as a graphic for the result as well as the
	 * rules which govern where in the road it is placed.
	 * 
	 * The Big Road defines some functionality which the down roads don't need, and
	 * therfore could have been in a separate behaviour. But as there was not much of
	 * it which was particular to Big Road, this was deemed pointless.
	 * 
	 * @author Elliot Harris
	 */
	public class AllRoadsAddBehaviour implements IAddBehaviour {
		
		protected var _road:IRoadModifiable;
		protected var _resultTargetClass:String;
		
		/**
		 * Constructor
		 * 
		 * @param resultTargetClass The MovieClip class to instantiate and use
		 * as the graphic for all results on the road controlled by this class
		 */
		public function AllRoadsAddBehaviour(resultTargetClass:String = "BigRoadResult") {
			_resultTargetClass = resultTargetClass;
		}
		
		/**
		 * Generate a new MovieClip to use as the graphic for the result.
		 * A failsafe exists in case this class cannot be instantiated.
		 */
		protected function createResultTarget():MovieClip {
			var m:MovieClip;
			
			switch(_resultTargetClass){
				case "BigRoadResult":
					m = new BigRoadResult();
					break;
				case "BigEyeBoyRoadResult":
					m = new BigEyeBoyRoadResult();
					break;
				case "SmallRoadResult":
					m = new SmallRoadResult();
					break;
				case "CockroachRoadResult":
					m = new CockroachRoadResult();
					break;
			}			
			return m;
		}
		
		/**
		 * Called by the Road class to which this behaviour is assigned
		 * whenever a new result comes in.
		 * 
		 * @param type The type of result, as defined by ResultTypes
		 * @param score An optional score value for the result
		 */
		public function newResult(type:String, score:uint=0, clr:uint = 0xFFFFFF):void {
			var lastResult:IResult = _road.lastResult;
			var r:IResult;
			var xPos:uint;
			var yPos:uint;
			
			switch(type) {
				case ResultTypes.BANKER:
				case ResultTypes.PLAYER:
					/*
					 * If the type is Player or Banker, we evaluate the last result's
					 * user type to determin whether or not to start a new row.
					 */
					r = new Result( createResultTarget(), clr );
					r.setTypes(type);
					if(lastResult) {
						if(lastResult.userType == type) {
							xPos = _road.lastXPos;
							yPos = _road.lastYPos+1;
						}
						else {
							xPos = _road.lastXPos+1;
							yPos = 0; //It's already 0, but this is to emphasise what's happening	
						}
					}
					r.score = score;
					break;
				case ResultTypes.TIE:
					if(lastResult) { //Ensure this isn't the first result on the grid
						if(lastResult.type != type) { //Check last result wasn't also a tie
							r = new Result( createResultTarget(), clr );
							r.setTypes(type, lastResult.type);
							xPos = _road.lastXPos;
							yPos = _road.lastYPos;
						}
					}
				//Other result type is 'cancelled', in which case we do nothing
			}
			
			if(r) {
				_road.addResult(r, xPos, yPos);
			}
		}
		
		/**
		 * Sets an IRoadModifiable instance to be controlled by this class.
		 * Is called from within the Road itself.
		 */
		public function set road(v:IRoadModifiable):void { _road = v; }
	}
}