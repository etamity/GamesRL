package com.newco.grand.core.components.scorecard.display {
	import com.newco.grand.core.common.view.ui.views.IBaseView;
	
	/**
	 * An interface used by those which can accept a new result,
	 * such as ScoreCardsDisplay and Road.
	 * 
	 * @author Elliot Harris
	 */
	public interface IAcceptsResult extends IBaseView {
		function newResult(type:String, score:uint = 0, clr:uint = 0xFFFFFF):void
		function clear():void
	}
}