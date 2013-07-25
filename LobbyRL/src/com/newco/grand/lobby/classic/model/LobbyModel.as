package com.newco.grand.lobby.classic.model
{
	
	public class LobbyModel
	{
		private var _tableList:Array;
		
		private var _data:XML;
		
		private var _mainGame:String;
		public function LobbyModel()
		{
			
		}
		public function get tables():Array{
			return _tableList;
		}
		public function get mainGame():String{
			return _mainGame;
		}
		public function get data():XML{
			return _data;
		}
		
		public function set data(val:XML):void{
			 _data=val;
			 _tableList=[];
			 
			 _mainGame=val.maingame;
			 
			 var i:int;
			 var xmllist:XMLList=val.roulette.table;
			 var tablexml:XML;
			 var tableModel:TableModel;
			 for (i=0;i<xmllist.length();i++)
			 {
				 tablexml=xmllist[i];
				 tableModel=new TableModel();
				 tableModel.streamMode=val.streamSever.@mode;
				 tableModel.setStreamPath(val.streamSever);
				 tableModel.setData(tablexml);
				 tableModel.game="roulette"
				 _tableList.push(tableModel);
			 }
			 xmllist = val.blackjack.table;
			 for (i=0;i<xmllist.length();i++)
			 {
				 tablexml=xmllist[i];
				 tableModel=new TableModel();
				 tableModel.streamMode=val.streamSever.@mode;
				 tableModel.setStreamPath(val.streamSever);
				 tableModel.setData(tablexml);
				 tableModel.game="blackjack"
				 _tableList.push(tableModel);
			 }
			 xmllist = val.baccarat.table;
			 for (i=0;i<xmllist.length();i++)
			 {
				 tablexml=xmllist[i];
				 tableModel=new TableModel();
				 tableModel.streamMode=val.streamSever.@mode;
				 tableModel.setStreamPath(val.streamSever);
				 tableModel.setData(tablexml);
				 tableModel.game="baccarat"
				 _tableList.push(tableModel);
			 }
		}
	}
}