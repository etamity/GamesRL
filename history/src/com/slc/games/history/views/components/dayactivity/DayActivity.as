package com.slc.games.history.views.components.dayactivity {

	import com.slc.games.history.events.HistoryViewEvent;
	import com.slc.events.GeneralButtonEvent;
	import com.slc.ui.Language;
	import com.slc.ui.buttons.GeneralButton;
	import com.slc.ui.buttons.IGeneralButton;
	import com.slc.ui.text.IText;
	import com.slc.ui.text.Text;
	import com.slc.ui.views.components.BaseComponentView;
	import com.slc.utilities.Debug;
	import com.slc.utilities.StyleUtils;

	import fl.controls.DataGrid;
	import fl.events.ListEvent;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * Displays a list of activity for any given user on any given day.
	 * @author Elliot Harris
	 */
	public class DayActivity extends BaseComponentView {
		protected var _dataGrid:DataGrid;
		protected var _accountHistory:IGeneralButton;
		protected var _columnNames:Array;
		protected var _data:Array;
		protected var _message:IText;

		public function DayActivity(target:Sprite) {
			super(target);
			_columnNames = [Language.getInstance().getProperty("gametype"), Language.getInstance().getProperty("time"), Language.getInstance().getProperty("amount")];

			_dataGrid = _target.getChildByName("dataGrid") as DataGrid;
			_dataGrid.columns = _columnNames;
			_dataGrid.addEventListener(ListEvent.ITEM_CLICK, onItemClick);
			StyleUtils.styleDataGrid(_dataGrid);

			if (_back) {
				_back.label = Language.getInstance().getProperty("backtoaccounthistory");
			}

			var button:MovieClip = _target.getChildByName("accountHistory") as MovieClip;
			if (button) {
				_accountHistory = new GeneralButton(button);
				_accountHistory.addEventListener(GeneralButtonEvent.CLICK, onAccountHistoryClick);
				_accountHistory.label = Language.getInstance().getProperty("accounthistory");
			}

			_message = new Text(_target.getChildByName("message") as TextField);
			_message.text = Language.getInstance().getProperty("noactivity");
			_dataGrid.visible = false;
		}

		override protected function onBackClick(e:GeneralButtonEvent):void {
			dispatchEvent(new HistoryViewEvent(HistoryViewEvent.ACCOUNT_HISTORY_CLICK));
		}

		protected function onItemClick(e:ListEvent):void {
			//Depending on the type value of the xml node relating to the item which was clicked, the event fired here indicates that either a transaction or a game item was clicked.
			var node:XML = _data[e.index];
			var eventString:String;
			if (node.@type == "trans") {
				eventString = HistoryViewEvent.TRANSACTION_CLICK;
			}
			else {
				eventString = HistoryViewEvent.GAME_CLICK;
			}

			dispatchEvent(new HistoryViewEvent(eventString, null, node.@gameid, node.@label));
		}

		protected function onAccountHistoryClick(e:GeneralButtonEvent):void {
			dispatchEvent(new HistoryViewEvent(HistoryViewEvent.ACCOUNT_HISTORY_CLICK));
		}

		override public function parseXML(xml:XML):void {
			_dataGrid.removeAll();
			var items:XMLList = xml.item;
			if (items.length() > 0) {
				_data = new Array();
				for each (var node:XML in items) {
					_data.push(node);
				}
				_data.sortOn("@time", Array.DESCENDING);
				for (var i:uint; i < _data.length; i++) {
					var obj:Object = new Object();
					obj[_columnNames[0]] = _data[i].@label;
					obj[_columnNames[1]] = _data[i].@time;
					obj[_columnNames[2]] = _data[i].@amount;
					_dataGrid.addItem(obj);
				}
				_dataGrid.visible = true;
				_message.visible = false;
			}
			else {
				_dataGrid.visible = false;
				_message.visible = true;
			}
			_isInitialised = true;
		}
	}
}

