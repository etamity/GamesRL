package com.ai.core.common.view {
	
	import com.ai.core.common.view.interfaces.IPlayersView;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	import fl.controls.DataGrid;
	import fl.controls.dataGridClasses.DataGridColumn;
	import fl.data.DataProvider;

	public class WinnersView extends Sprite implements IPlayersView {
		
		private var _players:XML;
		private var dgCol1Name:String = "Player";
		private var dgCol2Name:String = "Amount";
		private var winnersList:Array;
		private var playersListDgMc:DataGrid;
		public function WinnersView() {
			visible = false;
			createDataGrid(null);

		}		
		
		public function init():void {			
			align();
	

		}
		
		public function setSize(newWidth:Number, newHeight:Number):void{

		}
		
		private function createDataGrid(evt:MouseEvent):void{
			
			playersListDgMc= new DataGrid();
			playersListDgMc.width=164;
			playersListDgMc.height=380;
			playersListDgMc.x=3;
			playersListDgMc.y=3;
			
			addChild(playersListDgMc);
			
		
			var col1:DataGridColumn = new DataGridColumn(dgCol1Name);
			var col2:DataGridColumn = new DataGridColumn(dgCol2Name);
			col2.sortOptions = Array.NUMERIC;
			playersListDgMc.columns = [col1, col2];
			playersListDgMc.columns[0].width = 85;
			playersListDgMc.columns[1].width = 65;
			var style:TextFormat = new TextFormat();
			style.bold = false;
			style.size = 11;
			style.color = 0x9E9581;
			style.font = "Arial";
			playersListDgMc.setStyle("headerTextFormat",style);
			playersListDgMc.setRendererStyle("textFormat",style);
		}
		public function align():void {
			visible = true;
		}
		
		public function get players():XML {
			return _players;
		}
		
		public function set players(value:XML):void {
			_players = value;
			showPlayers();
		}
		public function loadFormXML(data:XML):void{
		
			winnersList =new Array();
			playersListDgMc.dataProvider = new DataProvider(winnersList);
			var urlsXML:XMLList = data.users[0].user;
			for(var i:uint = 0; i < urlsXML.length(); i++) {
				var obj:Object=new Object();
				obj.name=urlsXML[i].@name;
				obj.userid=urlsXML[i].@userid;
				obj.winnings=urlsXML[i].@winnings;
				

				var dataCol:Object={};
				dataCol[''+dgCol1Name]=obj.name;
				dataCol[''+dgCol2Name]=obj.winnings;
				
				winnersList.push(dataCol);	
				
			}
			//obj = {};

			playersListDgMc.dataProvider = new DataProvider(winnersList);
			
		}
		
		public function get listView():DataGrid{
			return playersListDgMc;
		}
		private function showPlayers():void {
			loadFormXML(players)
		}
	}
}