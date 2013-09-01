package com.newco.grand.core.common.view.uicomps {
	
	import com.newco.grand.core.common.model.LanguageModel;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.core.common.view.interfaces.IPlayersView;
	import com.smart.uicore.controls.DataGrid;
	import com.smart.uicore.controls.support.DataGridColumnSet;
	
	import flash.display.MovieClip;
	

	public class WinnersUIView extends MovieClip implements IPlayersView {
		
		private var _players:XML;
		private var dgCol1Name:String = "Player";
		private var dgCol2Name:String = "Amount";
		private var playersListDgMc:DataGrid;
		public function WinnersUIView() {
			visible = false;
			playersListDgMc= new DataGrid();
			playersListDgMc.setSize(167,529);
			addChild(playersListDgMc);
			var sets:Vector.<DataGridColumnSet> = new Vector.<DataGridColumnSet>();
			sets.push(new DataGridColumnSet(dgCol1Name,"name",-45));
			sets.push(new DataGridColumnSet(dgCol2Name,"winnings",-55));
			playersListDgMc.initColumns(sets);
		}
		public function initDisplay():void{
		}
		public function init():void {			
			align();
		}
		
		public function align():void {
			visible = true;
			y=10;
		}
		
		public function language():void{
			listView.labels[0] = LanguageModel.PLAYERNAME;
			listView.labels[1] = LanguageModel.PLAYERWINS;
		}
		public function resize(width:Number,height:Number):void{
			listView.setSize(width,height);
		}
		public function get players():XML {
			return _players;
		}
		
		public function set players(value:XML):void {
			_players = value;
			showPlayers();
		}
		public function loadFormXML(data:XML):void{
			debug(data);
			playersListDgMc.removeAll();
			var urlsXML:XMLList = data.users[0].user;
			var obj:Object;
			for(var i:uint = 0; i < urlsXML.length(); i++) {
				obj={name:urlsXML[i].@name,winnings:urlsXML[i].@winnings,userid:urlsXML[i].@userid};		
				playersListDgMc.addItem(obj);
			}
		

		}
		public function get display():*{
			return this;
		}
		public function get listView():DataGrid{
			return playersListDgMc;
		}
		private function showPlayers():void {
			loadFormXML(players)
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}