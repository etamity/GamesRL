package com.slc.games.history.views.components.baccarat {

	import com.slc.ui.text.Text;
	import com.slc.ui.text.IText;
	import com.slc.ui.views.BaseView;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;

	/**
	 * Displays a single hand of Baccarat, composed of a list of cards
	 * and some heading text.
	 *
	 * @author Elliot Harris
	 */
	public class BaccaratHand extends BaseView {
		protected var _heading:IText;
		protected var _cards:Array;

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

		public function BaccaratHand(target:Sprite) {
			super(target);

			_heading = new Text(_target.getChildByName("heading") as TextField);

			//These are empty sprites used as containers, into which the cards
			//will be added
			_cards = new Array();
			for (var i:uint; i < 3; i++) {
				_cards.push(_target.getChildByName("c" + i));
			}
		}

		/**
		 * Sets the heading text
		 *
		 * @param v The text to be used as the heading
		 */
		public function set heading(v:String):void {
			_heading.text = v;
		}

		/**
		 * Initialises the hand of cards
		 *
		 * @param v An Array of integer IDs of the cards to be used for the hand.
		 */
		public function set hand(v:Array):void {
			var count:uint;
			for each (var s:Sprite in _cards) {
				//Remove existing card from this card container
				if (s.numChildren == 1) {
					s.removeChildAt(0);
				}

				//Add new card if one exists in the array
				if (count < v.length) {
					var c:Class = getDefinitionByName("card_" + v[count++]) as Class;
					var card:MovieClip = new c() as MovieClip;
					card.gotoAndStop(1);
					s.addChild(card);
				}
			}
		}

		/**
		 * Clears both the heading text and the cards in the hand.
		 */
		public function clear():void {
			heading = "";
			for each (var s:Sprite in _cards) {
				if (s.numChildren == 1) {
					s.removeChildAt(0);
				}
			}
		}
	}
}

