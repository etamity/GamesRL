package com.slc.games.history.views.components.baccarat {

	import com.slc.ui.Language;
	import com.slc.ui.text.IText;
	import com.slc.ui.text.Text;
	import com.slc.ui.views.components.BaseComponentView;
	import com.slc.utilities.StyleUtils;
	import com.slc.utilities.*;
	import com.slc.utilities.GlobalConfig;
	
	import flash.display.MovieClip;

	import fl.controls.DataGrid;

	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * Displays the results of Baccarat.
	 * @author Elliot Harris
	 */
	public class Baccarat extends BaseComponentView {
		protected var _dataGrid:DataGrid;
		protected var _timeStarted:IText;
		protected var _timeFinished:IText;
		protected var _dealer:IText;
		protected var _playerHand:BaccaratHand;
		protected var _bankerHand:BaccaratHand;

		protected var _aamsUI:MovieClip;
		protected var _pidLbl:IText;
		protected var _sidLbl:IText;
		protected var _rnoLbl:IText;
		protected var _pid:IText;
		protected var _sid:IText;
		protected var _rno:IText;

		protected var _columnNames:Array; //The column names used by the DataGrid

		protected var _data:Array;

		public function Baccarat(target:Sprite) {
			super(target);
			
			if (GlobalConfig.AAMS) {
				_columnNames = [Language.getInstance().getProperty("betheading"), Language.getInstance().getProperty("amount"), Language.getInstance().getProperty("win"), Language.getInstance().getProperty("participation")];
			}
			else {
				_columnNames = [Language.getInstance().getProperty("betheading"), Language.getInstance().getProperty("amount"), Language.getInstance().getProperty("win")];
			}
             
			_dataGrid = _target.getChildByName("dataGrid") as DataGrid;
			_dataGrid.columns = _columnNames;
			StyleUtils.styleDataGrid(_dataGrid);

			_timeStarted = new Text(_target.getChildByName("timeStarted") as TextField);
			_timeFinished = new Text(_target.getChildByName("timeFinished") as TextField);
			_dealer = new Text(_target.getChildByName("dealer") as TextField);

			_playerHand = new BaccaratHand(_target.getChildByName("playerHand") as Sprite);
			_bankerHand = new BaccaratHand(_target.getChildByName("bankerHand") as Sprite);

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

				_dealer.x = 25;
				_dealer.y = _timeStarted.y = 50;
				_timeStarted.x = _timeFinished.x = 200;
				_timeFinished.y = 70;

				_aamsUI.visible = true;
			}
			else {
				_dealer.x = _timeStarted.x = _timeFinished.x = 25;
				_dealer.y = 15;
				_timeStarted.y = 40;
				_timeFinished.y = 65;
				_aamsUI.visible = false;
			}

			//Clear any existing data
			_timeStarted.text = _timeFinished.text = _dealer.text = "";
			_dataGrid.removeAll();
			_playerHand.clear();
			_bankerHand.clear();

			//Add the textual data
			_timeStarted.text = Utils.replace(xml.started.text(), "Baccarat Game started at", Language.getInstance().getProperty("gamestart"));
			_timeFinished.text = Utils.replace(xml.finished.text(), "Baccarat Game finished at", Language.getInstance().getProperty("gameend"));
			var dealer:String      = Utils.replace(xml.dealer.text(), "Dealer:", "");
			var dealerLabel:String = Language.getInstance().getProperty("dealer") + ": ";
			dealerLabel = dealerLabel.charAt(0).toUpperCase() + dealerLabel.slice(1).toLowerCase();
			_dealer.text = dealerLabel + dealer;

			//Initialise the player hand
			_playerHand.heading = Language.getInstance().getProperty("theplayerhand") + ": " + xml.playerhand.@score;
			var cardCount:String   = xml.playerhand.@cardCount;
			if (cardCount != "") {
				_playerHand.hand = cardCount.split(",");
			} //Split the comma-separated values into an Array
			else {
				_playerHand.clear();
			}

			//Initialise the banker hand
			_bankerHand.heading = Language.getInstance().getProperty("thebankerhand") + ": " + xml.bankerhand.@score;
			cardCount = xml.bankerhand.@cardCount;
			if (cardCount != "") {
				_bankerHand.hand = cardCount.split(",");
			}
			else {
				_bankerHand.clear();
			}

			//Add rows to the DataGrid
			var obj:Object;
			var items:XMLList      = xml.Player;
			for each (var node:XML in items) {
				obj = new Object();
				obj[_columnNames[0]] = Language.getInstance().getProperty("player");
				obj[_columnNames[1]] = node.@amount;
				obj[_columnNames[2]] = node.@netcash;
				if (GlobalConfig.AAMS) {
					obj[_columnNames[3]] = node.@participation;
				}
				_dataGrid.addItem(obj);
			}

			items = xml.Banker;
			for each (node in items) {
				obj = new Object();
				obj[_columnNames[0]] = Language.getInstance().getProperty("banker");
				obj[_columnNames[1]] = node.@amount;
				obj[_columnNames[2]] = node.@netcash;
				if (GlobalConfig.AAMS) {
					obj[_columnNames[3]] = node.@participation;
				}
				_dataGrid.addItem(obj);
			}

			items = xml.Tie;
			for each (node in items) {
				obj = new Object();
				obj[_columnNames[0]] = Language.getInstance().getProperty("tie");
				obj[_columnNames[1]] = node.@amount;
				obj[_columnNames[2]] = node.@netcash;
				if (GlobalConfig.AAMS) {
					obj[_columnNames[3]] = node.@participation;
				}
				_dataGrid.addItem(obj);
			}

			items = xml.Player_Pair;
			for each (node in items) {
				obj = new Object();
				obj[_columnNames[0]] = Language.getInstance().getProperty("pair_player");
				obj[_columnNames[1]] = node.@amount;
				obj[_columnNames[2]] = node.@netcash;
				if (GlobalConfig.AAMS) {
					obj[_columnNames[3]] = node.@participation;
				}
				_dataGrid.addItem(obj);
			}

			items = xml.Banker_Pair;
			for each (node in items) {
				obj = new Object();
				obj[_columnNames[0]] = Language.getInstance().getProperty("pair_banker");
				obj[_columnNames[1]] = node.@amount;
				obj[_columnNames[2]] = node.@netcash;
				if (GlobalConfig.AAMS) {
					obj[_columnNames[3]] = node.@participation;
				}
				_dataGrid.addItem(obj);
			}

			_dataGrid.getColumnAt(0).width = 85;
			_dataGrid.getColumnAt(3).visible= false;

			_isInitialised = true;
		}
	}
}