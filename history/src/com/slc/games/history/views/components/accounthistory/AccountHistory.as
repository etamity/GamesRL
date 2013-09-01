package com.slc.games.history.views.components.accounthistory {

	import com.slc.events.GeneralButtonEvent;
	import com.slc.games.history.events.HistoryViewEvent;
	import com.slc.ui.Language;
	import com.slc.ui.text.IText;
	import com.slc.ui.text.Text;
	import com.slc.ui.views.components.BaseComponentView;
	import com.slc.utilities.StyleUtils;

	import fl.controls.DataGrid;
	import fl.events.ListEvent;

	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * Displays a list of selectable dates for which there has been activity
	 * on the specified account.
	 *
	 * @author Elliot Harris
	 */
	public class AccountHistory extends BaseComponentView {
		protected var _dataGrid:DataGrid;

		protected var _columnNames:Array;

		protected var _items:XMLList;

		protected var _message:IText;

		public function AccountHistory(target:Sprite) {
			super(target);

			_columnNames = [Language.getInstance().getProperty("date"), Language.getInstance().getProperty("stake"), Language.getInstance().getProperty("winlose")];

			_dataGrid = _target.getChildByName("dataGrid") as DataGrid;
			_dataGrid.columns = _columnNames;
			_dataGrid.addEventListener(ListEvent.ITEM_CLICK, onItemClick);
			StyleUtils.styleDataGrid(_dataGrid);

			if (_back) {
				_back.label = Language.getInstance().getProperty("currentactivity");
			}
			//Back functionality is overriden in listener function below

			//This is the message displayed when there is no data. It is visible by default.
			_message = new Text(_target.getChildByName("message") as TextField);
			_message.text = Language.getInstance().getProperty("noactivity");
			_dataGrid.visible = false;
		}

		override protected function onBackClick(e:GeneralButtonEvent):void {
			dispatchEvent(new HistoryViewEvent(HistoryViewEvent.CURRENT_ACTIVITY_CLICK));
		}

		protected function onItemClick(e:ListEvent):void {
			var date:String = _items[e.index].@date.split("-").join("");
			dispatchEvent(new HistoryViewEvent(HistoryViewEvent.DAY_ITEM_CLICK, date));
		}

		//<item date="2010-03-17"  stake="100.00" winlose="EUR -100.00" />
		override public function parseXML(xml:XML):void {
			_items = xml.item;
			if (_items.length() > 0) {
				for each (var node:XML in _items) {
					var obj:Object = new Object();
					obj[_columnNames[0]] = node.@date;
					obj[_columnNames[1]] = node.@stake;
					obj[_columnNames[2]] = node.@winlose;
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

