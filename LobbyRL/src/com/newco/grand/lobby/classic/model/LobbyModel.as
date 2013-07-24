package com.newco.grand.lobby.classic.model
{
	
	public class LobbyModel
	{
		private var _tableList:Array;
		
		private var _data:XML;
		
		public function LobbyModel()
		{
			
		}
		public function get tables():Array{
			return _tableList;
		}
		public function get data():XML{
			return _data;
		}
		
		public function set data(val:XML):void{
			 _data=val;
			 _tableList=[];
			 var i:int;
			 var xmllist:XMLList=val.roulette;
			 var tablexml:XML;
			 var tableModel:TableModel;
			 for (i=0;i<xmllist.length();i++)
			 {
				 tablexml=xmllist[i];
				 tableModel=new TableModel();
				 tableModel.setData(tablexml);
				 _tableList.push(tableModel);
			 }
			 xmllist = val.blackjack;
			 for (i=0;i<xmllist.length();i++)
			 {
				 tablexml=xmllist[i];
				 tableModel=new TableModel();
				 tableModel.setData(tablexml);
				 _tableList.push(tableModel);
			 }
			 xmllist = val.baccarat;
			 for (i=0;i<xmllist.length();i++)
			 {
				 tablexml=xmllist[i];
				 tableModel=new TableModel();
				 tableModel.setData(tablexml);
				 _tableList.push(tableModel);
			 }
		}
	}
}