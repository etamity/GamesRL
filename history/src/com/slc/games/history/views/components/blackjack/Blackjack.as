package com.slc.games.history.views.components.blackjack {

	import com.slc.ui.Language;
	import com.slc.ui.views.components.BaseComponentView;
	import com.slc.ui.text.Text;
	import com.slc.ui.text.IText;
	import flash.text.TextField;
	import flash.display.MovieClip;

	import fl.containers.ScrollPane;

	import flash.display.Sprite;

	/**
	 * Displays the results of a Blackjack game. Uses a scroll pane to
	 * separate the hands.
	 *
	 * @author Elliot Harris
	 */
	public class Blackjack extends BaseComponentView {
		/**
		 * The vertical space between each hand within the scroll pane.
		 */
		protected const V_SPACE:uint = 10;

		protected var _scrollPane:ScrollPane;
		protected var _scrollPaneSource:Sprite;

		protected var _aamsUI:MovieClip;
		protected var _pidLbl:IText;
		protected var _sidLbl:IText;
		protected var _rnoLbl:IText;
		protected var _pid:IText;
		protected var _sid:IText;
		protected var _rno:IText;

		public function Blackjack(target:Sprite) {
			super(target);

			_scrollPane = _target.getChildByName("scrollPane") as ScrollPane;

			if (_back) {
				_back.label = Language.getInstance().getProperty("backtogamehistory");
			}
		}

		override public function parseXML(xml:XML):void {
			//Clear the last results by creating a new source Sprite for
			//the scroll pane
			_scrollPaneSource = new Sprite();

			//Generate a new hand for every item node found in the XML
			var items:XMLList   = xml.item;
			var aamsSpacer:uint = 0;
			if (xml.@gameSessionID != null && String(xml.@gameSessionID).length > 0) {
				_aamsUI = new AAMSInterface();
				_pidLbl = new Text(_aamsUI.getChildByName("pidLbl") as TextField);
				_sidLbl = new Text(_aamsUI.getChildByName("sidLbl") as TextField);
				_rnoLbl = new Text(_aamsUI.getChildByName("rnoLbl") as TextField);
				_pid = new Text(_aamsUI.getChildByName("pid") as TextField);
				_sid = new Text(_aamsUI.getChildByName("sid") as TextField);
				_rno = new Text(_aamsUI.getChildByName("rno") as TextField);

				_pidLbl.text = Language.getInstance().getProperty("AAMSParticipationID");
				_sidLbl.text = Language.getInstance().getProperty("AAMSSessionID");
				_rnoLbl.text = Language.getInstance().getProperty("AAMSRoundID");
				_pid.text = xml.@participationID;
				_sid.text = xml.@gameSessionID;
				_rno.text = xml.@roundID;
				_scrollPaneSource.addChild(_aamsUI);
				aamsSpacer = 50;
			}

			var count:uint;
			for each (var node:XML in items) {
				var hand:BlackjackHand = new BlackjackHand(new BlackjackHandTarget());
				hand.parseXML(node);
				hand.y = aamsSpacer + (hand.height + V_SPACE) * count++;
				_scrollPaneSource.addChild(hand.target);
			}

			//Apply the source sprite to the scroll pane. I'll be honest - I have
			//no certainty about what happens to the old one here. One assumes
			//it has been removed from the display list and therefore dereferenced.
			_scrollPane.source = _scrollPaneSource;

			_isInitialised = true;
		}
	}
}