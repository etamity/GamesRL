package com.slc.games.history.views.components.blackjack {

	import com.slc.ui.text.Text;
	import com.slc.ui.Language;
	import com.slc.ui.text.IText;
	import com.slc.ui.views.BaseView;
	import com.slc.utilities.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;

	/**
	 * Displays one hand of Blackjack.
	 *
	 * @author Elliot Harris
	 */
	public class BlackjackHand extends BaseView {
		//Text labels - these don't change once initialised
		protected var _seatNameLabel:IText;
		protected var _scoreLabel:IText;
		protected var _betLabel:IText;
		protected var _payoffLabel:IText;
		protected var _cardsLabel:IText;
		protected var _insuranceLabel:IText;
		protected var _doubleLabel:IText;
		protected var _splitLabel:IText;
		protected var _participationLabel:IText;

		//Text data for the corresponding labels - these are given the values in the XML
		protected var _seatNameData:IText;
		protected var _scoreData:IText;
		protected var _betData:IText;
		protected var _payoffData:IText;
		protected var _insuranceData:IText;
		protected var _doubleData:IText;
		protected var _splitData:IText;
		protected var _participationData:IText;

		//This is an empty container sprite where the cards will be added 
		protected var _cardHolder:Sprite;

		private var card0:card_0;
		private var card1:card_1;
		private var card2:card_2;
		private var card3:card_3;
		private var card4:card_4;
		private var card5:card_5;
		private var card6:card_6;
		private var card7:card_7;
		private var card8:card_8;
		private var card9:card_9;
		private var card10:card_10;
		private var card11:card_11;
		private var card12:card_12;
		private var card13:card_13;
		private var card14:card_14;
		private var card15:card_15;
		private var card16:card_16;
		private var card17:card_17;
		private var card18:card_18;
		private var card19:card_19;
		private var card20:card_20;
		private var card21:card_21;
		private var card22:card_22;
		private var card23:card_23;
		private var card24:card_24;
		private var card25:card_25;
		private var card26:card_26;
		private var card27:card_27;
		private var card28:card_28;
		private var card29:card_29;
		private var card30:card_30;
		private var card31:card_31;
		private var card32:card_32;
		private var card33:card_33;
		private var card34:card_34;
		private var card35:card_35;
		private var card36:card_36;
		private var card37:card_37;
		private var card38:card_38;
		private var card39:card_39;
		private var card40:card_40;
		private var card41:card_41;
		private var card42:card_42;
		private var card43:card_43;
		private var card44:card_44;
		private var card45:card_45;
		private var card46:card_46;
		private var card47:card_47;
		private var card48:card_48;
		private var card49:card_49;
		private var card50:card_50;
		private var card51:card_51;

		public function BlackjackHand(target:Sprite) {
			super(target);

			//Initialise the text labels, and add text
			var labels:Sprite = _target.getChildByName("textLabels") as Sprite;
			_seatNameLabel = new Text(labels.getChildByName("seatName") as TextField);
			_seatNameLabel.text = Language.getInstance().getProperty("seatname");

			_scoreLabel = new Text(labels.getChildByName("score") as TextField);
			_scoreLabel.text = Language.getInstance().getProperty("score");

			_betLabel = new Text(labels.getChildByName("bet") as TextField);
			_betLabel.text = Language.getInstance().getProperty("betheading");

			_payoffLabel = new Text(labels.getChildByName("payoff") as TextField);
			_payoffLabel.text = Language.getInstance().getProperty("payoff");

			_cardsLabel = new Text(labels.getChildByName("cards") as TextField);
			_cardsLabel.text = Language.getInstance().getProperty("cards");

			_insuranceLabel = new Text(labels.getChildByName("insurance") as TextField);
			_insuranceLabel.text = Language.getInstance().getProperty("insurance");

			_doubleLabel = new Text(labels.getChildByName("double") as TextField);
			_doubleLabel.text = Language.getInstance().getProperty("double");

			_splitLabel = new Text(labels.getChildByName("split") as TextField);
			_splitLabel.text = Language.getInstance().getProperty("splithand");
			
			_participationLabel = new Text(labels.getChildByName("participation") as TextField);
			_participationLabel.text = Language.getInstance().getProperty("participation");

			//Initialise the text data, ready for text to be added
			var data:Sprite   = _target.getChildByName("textData") as Sprite;
			_seatNameData = new Text(data.getChildByName("seatName") as TextField);
			_scoreData = new Text(data.getChildByName("score") as TextField);
			_betData = new Text(data.getChildByName("bet") as TextField);
			_payoffData = new Text(data.getChildByName("payoff") as TextField);
			_insuranceData = new Text(data.getChildByName("insurance") as TextField);
			_doubleData = new Text(data.getChildByName("double") as TextField);
			_splitData = new Text(data.getChildByName("split") as TextField);
			_participationData = new Text(data.getChildByName("participation") as TextField);
			_cardHolder = _target.getChildByName("cardHolder") as Sprite;
		}

		public function parseXML(node:XML):void {
			//Add the text data to the IText instances
			_seatNameData.text = Utils.replace(node.@seatname, "Dealer: ", "");
			_seatNameData.text = Utils.replace(node.@seatname, "DEALER : ", "");
			if (Number(node.@seat) == -1) {
				_seatNameData.text += " (" + Language.getInstance().getProperty("dealer").toLowerCase() + ")";
			}
			_scoreData.text = node.@score;
			_betData.text = node.@bet;
			_payoffData.text = node.@payoff;
			if (node.@insurance != null) {
				_insuranceData.text = (String(node.@insuranceBetAmt).length > 0) ? node.@insurance + " (" + node.@insuranceBetAmt + ")" : node.@insurance;
			}
			else {
				_insuranceLabel.text = '';
				_insuranceData.text = '';
			}
			// This really makes no sense but it's still necessary. Somehow the app thinks there's an insurance node when there's not...
			if (_insuranceData.text == '') {
				_insuranceLabel.text = '';
			}

			if (node.@doubleDown != null) {
				_doubleData.text = node.@doubleDown;
			}
			else {
				_doubleLabel.text = '';
				_doubleData.text = '';
			}
			
			if (_doubleData.text == '') {
				_doubleLabel.text = '';
			}

			if (node.@split != null) {
				_splitData.text = node.@split;
			}
			else {
				_splitLabel.text = '';
				_splitData.text = '';
			}
			
			if (node.@participation != null && node.@participation != "" && String(node.@participation).length > 0) {
				_participationData.text = node.@participation;
			}
			else {
				_participationLabel.text = '';
				_participationData.text = '';
			}

			//Add the cards to the container
			var cardCount:String = node.@cardCount;
			if (cardCount != "") { //Check the value is not null (it shouldn't ever be)			
				var cards:Array = cardCount.split(","); //Split comma-separated values into an Array
				for (var i:uint; i < cards.length; i++) {
					if (cards[i] >= 0) {
						//Retrieve card class according to the id in the Array
						var c:Class        = getDefinitionByName("card_" + cards[i]) as Class;
						var card:MovieClip = new c() as MovieClip;
						card.gotoAndStop(1);

						_cardHolder.addChild(card);
						card.x = card.x + card.width / 2 * i;
					}
				}
			}
		}
	}
}