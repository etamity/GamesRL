package com.newco.grand.lobby.classic.model
{
	
	public class LobbyModel
	{
		private var tableList:Array;
		
		private var _data:XML;
		
		public function LobbyModel()
		{
			
		}
		
		public function get data():XML{
			return _data;
		}
		
		public function set data(val:XML):void{
			 _data=val;
			 tableList=[];
			 var i:int;
			 var xmllist:XMLList=val.roulette;
			 var tablexml:XML;
			 var tableModel:TableModel;
			 for (i=0;i<xmllist.length();i++)
			 {
				 tablexml=xmllist[i];
				 tableModel=new TableModel();
				 tableModel.setData(tablexml);
				 tableList.push(tableModel);
			 }
			 xmllist = val.blackjack;
			 for (i=0;i<xmllist.length();i++)
			 {
				 tablexml=xmllist[i];
				 tableModel=new TableModel();
				 tableModel.setData(tablexml);
				 tableList.push(tableModel);
			 }
			 xmllist = val.baccarat;
			 for (i=0;i<xmllist.length();i++)
			 {
				 tablexml=xmllist[i];
				 tableModel=new TableModel();
				 tableModel.setData(tablexml);
				 tableList.push(tableModel);
			 }
		}
		public function loadFromXML():void{
			
		}
	}
}