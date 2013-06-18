package com.newco.grand.baccarat.classic.view.scorecard.display {
	import com.ai.core.view.ui.views.IBaseView;
	
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