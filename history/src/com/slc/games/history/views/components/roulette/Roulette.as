package com.slc.games.history.views.components.roulette {

	import com.slc.ui.Language;
	import com.slc.ui.text.IText;
	import com.slc.ui.text.Text;
	import com.slc.ui.views.components.BaseComponentView;
	import com.slc.utilities.StyleUtils;
	import com.slc.utilities.Utils;
	import com.slc.utilities.*;
	import flash.display.MovieClip;

	import fl.controls.DataGrid;

	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * Displays the results of a game of roulette.
	 * @author Elliot Harris
	 */
	public class Roulette extends BaseComponentView {
		protected var _dataGrid:DataGrid;
		protected var _time:IText;
		protected var _dealer:IText;

		protected var _aamsUI:MovieClip;
		protected var _pidLbl:IText;
		protected var _sidLbl:IText;
		protected var _rnoLbl:IText;
		protected var _pid:IText;
		protected var _sid:IText;
		protected var _rno:IText;

		protected var _columnNames:Array;

		public function Roulette(target:Sprite) {
			super(target);
			GlobalConfig.AAMS=true;
			if (GlobalConfig.AAMS) {
				_columnNames = [Language.getInstance().getProperty("betheading"), Language.getInstance().getProperty("resultheading"), Language.getInstance().getProperty("amount"), Language.getInstance().getProperty("netcash"), Language.getInstance().getProperty("participation")];
			}
			else {
				_columnNames = [Language.getInstance().getProperty("betheading"), Language.getInstance().getProperty("resultheading"), Language.getInstance().getProperty("amount"), Language.getInstance().getProperty("netcash")];
			}

			_dataGrid = _target.getChildByName("dataGrid") as DataGrid;
			_dataGrid.columns = _columnNames;
			StyleUtils.styleDataGrid(_dataGrid);

			_time = new Text(_target.getChildByName("time") as TextField);
			_dealer = new Text(_target.getChildByName("dealer") as TextField);

			_aamsUI = _target.getChildByName("aamsUI") as MovieClip;
			_aamsUI.visible = false;
			_pidLbl = new Text(_aamsUI.getChildByName("pidLbl") as TextField);
			_sidLbl = new Text(_aamsUI.getChildByName("sidLbl") as TextField);
			_rnoLbl = new Text(_aamsUI.getChildByName("rnoLbl") as TextField);
			_pid = new Text(_aamsUI.getChildByName("pid") as TextField);
			_sid = new Text(_aamsUI.getChildByName("sid") as TextField);
			_rno = new Text(_aamsUI.getChildByName("rno") as TextField);

			if (_back) {
				_back.label = Language.getInstance().getProperty("backtogamehistory");
			}
		}

		override public function parseXML(xml:XML):void {
			if (xml.@gameSessionID != null && String(xml.@gameSessionID).length > 0) {
				_pidLbl.text = Language.getInstance().getProperty("AAMSParticipationID");
				_sidLbl.text = Language.getInstance().getProperty("AAMSSessionID");
				_rnoLbl.text = Language.getInstance().getProperty("AAMSRoundID");
				_pid.text = xml.@participationID;
				_sid.text = xml.@gameSessionID;
				_rno.text = xml.@roundID;

				_time.y = 59;
				_dealer.y = 77;

				_aamsUI.visible = true;
			}
			else {
				_dealer.y = 35;
				_time.y = 65;
				_aamsUI.visible = false;
			}

			//Clear any existing data
			_time.text = _dealer.text = "";
			_dataGrid.removeAll();

			//Add the text from the XML
			_time.text = Utils.replace(xml.gameTime.text(), "Current Activity beginning at", Language.getInstance().getProperty("gametime"));
			var dealerLabel:String = Language.getInstance().getProperty("dealer") + ": ";
			dealerLabel = dealerLabel.charAt(0).toUpperCase() + dealerLabel.slice(1).toLowerCase();
			_dealer.text = dealerLabel + xml.dealer;

			//Add the data to the data grid
			//<item bet="48" amount="EUR 1.0" netcash="EUR -1.0" desc="Red" participation="1842480018"/>
			var items:XMLList      = xml.item;
			for each (var node:XML in items) {
				var obj:Object  = new Object();
				var desc:String = node.@desc.toLowerCase();
				obj[_columnNames[0]] = (Language.getInstance().getProperty(desc) != "") ? Language.getInstance().getProperty(desc) : node.@desc;
				obj[_columnNames[1]] = xml.result;
				obj[_columnNames[2]] = node.@amount;
				obj[_columnNames[3]] = node.@netcash;
				obj[_columnNames[4]] = (node.@participation == null) ? "" : node.@participation;

				_dataGrid.addItem(obj);
			}
			_isInitialised = true;
			//_dataGrid.getColumnAt(3).visible= true;
		}
	}
}