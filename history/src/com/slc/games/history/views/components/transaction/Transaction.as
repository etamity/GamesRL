package com.slc.games.history.views.components.transaction {

	import com.slc.ui.Language;
	import com.slc.ui.text.IText;
	import com.slc.ui.text.Text;
	import com.slc.ui.views.components.BaseComponentView;

	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * Displays a transaction through a number of text boxes.
	 *
	 * @author Elliot Harris
	 */
	public class Transaction extends BaseComponentView {
		protected var _timeLabel:IText;
		protected var _timeData:IText;

		protected var _typeLabel:IText;
		protected var _typeData:IText;

		protected var _amountLabel:IText;
		protected var _amountData:IText;

		protected var _enteredByLabel:IText;
		protected var _enteredByData:IText;

		protected var _statusLabel:IText;
		protected var _statusData:IText;

		protected var _notesLabel:IText;
		protected var _notesData:IText;

		public function Transaction(target:Sprite) {
			super(target);

			if (_back) {
				_back.label = Language.getInstance().getProperty("backtogamehistory");
			}
			initTextLabels();
			initTextData();
		}

		/**
		 * Initialises the labels, the values of which are set once.
		 */
		protected function initTextLabels():void {
			var labels:Sprite = _target.getChildByName("textLabels") as Sprite;

			_timeLabel = new Text(labels.getChildByName("time") as TextField);
			_timeLabel.text = Language.getInstance().getProperty("transactiontime");

			_typeLabel = new Text(labels.getChildByName("type") as TextField);
			_typeLabel.text = Language.getInstance().getProperty("transactiontype");

			_amountLabel = new Text(labels.getChildByName("amount") as TextField);
			_amountLabel.text = Language.getInstance().getProperty("amount");

			_enteredByLabel = new Text(labels.getChildByName("enteredBy") as TextField);
			_enteredByLabel.text = Language.getInstance().getProperty("enteredby");

			_statusLabel = new Text(labels.getChildByName("status") as TextField);
			_statusLabel.text = Language.getInstance().getProperty("transactionstatus");

			_notesLabel = new Text(labels.getChildByName("notes") as TextField);
			_notesLabel.text = Language.getInstance().getProperty("notes");
		}

		/**
		 * Initialises the Text objects for the data which corresponds to
		 * the labels, the values of which are determined from the XML.
		 */
		protected function initTextData():void {
			var data:Sprite = _target.getChildByName("textData") as Sprite;

			_timeData = new Text(data.getChildByName("time") as TextField);
			_typeData = new Text(data.getChildByName("type") as TextField);
			_amountData = new Text(data.getChildByName("amount") as TextField);
			_enteredByData = new Text(data.getChildByName("enteredBy") as TextField);
			_statusData = new Text(data.getChildByName("status") as TextField);
			_notesData = new Text(data.getChildByName("notes") as TextField);
		}

		override public function parseXML(xml:XML):void {
			//Remove any existing data
			_timeData.text = "";
			_typeData.text = "";
			_amountData.text = "";
			_enteredByData.text = "";
			_statusData.text = "";
			_notesData.text = "";

			_timeData.text = xml.transaction_time;
			_typeData.text = xml.transaction_desc;
			_amountData.text = xml.transaction_amount;
			_enteredByData.text = xml.transaction_author;
			_statusData.text = xml.transaction_status;
			_notesData.text = xml.transaction_note;

			_isInitialised = true;
		}
	}
}

