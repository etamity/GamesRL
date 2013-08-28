package com.newco.grand.core.common.view.scorecard.display.road.behaviours {
	
	import com.newco.grand.core.common.view.scorecard.display.road.IRoadModifiable;
	
	public interface IAddBehaviour {
		function newResult(type:String, score:uint=0, clr:uint = 0xFFFFFF):void
		function set road(v:IRoadModifiable):void
	}
}