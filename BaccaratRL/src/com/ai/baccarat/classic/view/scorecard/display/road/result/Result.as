package com.ai.baccarat.classic.view.scorecard.display.road.result {
	
	import com.ai.core.view.ui.views.BaseView;
	
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * Displays a single result and keeps a record of its type.
	 * 
	 * @author Elliot Harris
	 */
	public class Result extends BaseView implements IResult {
		protected var _type:String; //As defined in ResultTypes
		protected var _userType:String; //Player or Banker only - never a Tie
		protected var _scoreText:TextField;
		protected var _txtClr:uint;
		
		public function Result(target:MovieClip, clr:uint = 0xFFFFFF) {
			super(target);
			_txtClr = clr;
			_scoreText = _target.getChildByName("scoreTxt") as TextField;
			//if(tf) _scoreText = new Text(tf);
		}
		
		public function set score(v:uint):void { 
			if (_scoreText) {
				_scoreText.text = String(v);
				_scoreText.textColor = _txtClr;
			}
		}
		
		public function get userType():String{ return _userType; }
		
		public function get type():String{ return _type; }
		
		/**
		 * Sets the type and userType and moves the target movieclip to
		 * the correct frame.
		 */
		public function setTypes(type:String, userType:String=null):void {
			_type = type;
			_userType = userType ? userType : type;
			var frame:String = userType ? userType+type : type;
			MovieClip(_target).gotoAndStop(frame);
		}
	}
}