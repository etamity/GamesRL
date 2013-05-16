package com.ai.core.view.uicomps {
	
	import com.ai.core.model.Language;
	import com.ai.core.view.interfaces.IPlayersView;
	import com.smart.uicore.controls.DataGrid;
	import com.smart.uicore.controls.proxy.DataProvider;
	import com.smart.uicore.controls.support.DataGridColumnSet;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	

	public class WinnersUIView extends MovieClip implements IPlayersView {
		
		private var _players:XML;
		private var dgCol1Name:String = "Player";
		private var dgCol2Name:String = "Amount";
		private var winnersList:Array;
		private var playersListDgMc:DataGrid;
		public function WinnersUIView() {
			visible = false;
			createDataGrid(null);

		}		
		
		public function init():void {			
			align();
	

		}
		

		
		private function createDataGrid(evt:MouseEvent):void{
			
			playersListDgMc= new DataGrid();
			playersListDgMc.setSize(164,390);
			playersListDgMc.x=3;
			playersListDgMc.y=3;
			
			
			addChild(playersListDgMc);
	
	
			var sets:Vector.<DataGridColumnSet> = new Vector.<DataGridColumnSet>();
			sets.push(new DataGridColumnSet(dgCol1Name,"label",-50));
			sets.push(new DataGridColumnSet(dgCol2Name,"value",-50));
			playersListDgMc.initColumns(sets);
		
	
		}
		public function align():void {
			visible = true;
		}
		
		public function language():void{
			listView.labels[0] = Language.PLAYERNAME;
			listView.labels[1] = Language.PLAYERWINS;
		}
		
		public function get players():XML {
			return _players;
		}
		
		public function set players(value:XML):void {
			_players = value;
			//showPlayers();
		}
		public function loadFormXML(data:XML):void{
		
			winnersList =new Array();
			playersListDgMc.removeAll();
			//playersListDgMc.dataProvider= new DataProvider(winnersList);
			var urlsXML:XMLList = data.users[0].user;
			for(var i:uint = 0; i < urlsXML.length(); i++) {
				var obj:Object=new Object();
				obj.label=urlsXML[i].@name;
				obj.data=urlsXML[i].@userid;
				obj.value=urlsXML[i].@winnings;
				playersListDgMc.addItem(obj);
				winnersList.push(obj);	
				
			}
		

		}
		
		public function get listView():DataGrid{
			return playersListDgMc;
		}
		private function showPlayers():void {
			loadFormXML(players)
		}
	}
}