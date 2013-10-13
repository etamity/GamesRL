package com.newco.grand.lobby.classic.model
{
	import com.newco.grand.core.common.model.GameData;
	
	public class LobbyModel extends GameData
	{
		private var _tableList:Array;

		private var _data:XML;
		
		private var _mainGame:String;
		
		private var _opengame:String;

		private var _avatarData:XML; 
		public function LobbyModel()
		{
			_tableList=[];
		}
		public function set avatarData(val:XML):void{
			_avatarData=val;
		}
		public function get avatarData():XML{
			return _avatarData;
		}
		
		public function get opengameUrl():String{
			return _opengame;
		}
		public function set opengameUrl(val:String):void{
			 _opengame=val;
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
		
		public function getTableCount(game:String="baccarat"):int{
			var result:int=0;
			for (var i:int=0; i<_tableList.length;i++){
				if (_tableList[i].game==game && (_tableList[i].vtid=="" || _tableList[i].vtid=="NA"))
					result++;
			}
			return result;
		}
		public function getVTableCount(game:String="baccarat"):int{
			var result:int=0;
			for (var i:int=0; i<_tableList.length;i++){
				if (_tableList[i].game==game && _tableList[i].vtid!="" && _tableList[i].vtid!="NA")
					result++;
			}
			return result;
		}
		public function getTables(game:String="baccarat"):Array{
			var begin:int=0;
			var end:int=_tableList.length;
			var result:Array=[];
			for (var i:int=begin; i<end;i++)
			{
				if (_tableList[i].game==game && _tableList[i].vtid=="")
					result.push(_tableList[i]);
			}
			return result;
		}
		
		public function getVTables(tableid:String,game:String="baccarat"):Array{
			var begin:int=0;
			var end:int=_tableList.length;
			var result:Array=[];
			for (var i:int=begin; i<end;i++)
			{
				if (_tableList[i].game==game  && _tableList[i].tableid==tableid && _tableList[i].vtid!="" && _tableList[i].vtid!="NA")
					result.push(_tableList[i]);
			}
			return result;
		}
		public function set data(val:XML):void{
			 _data=val;
			 _mainGame=val.maingame;
			 _opengame=val.opengame;
			 var i:int;
			 var xmllist:XMLList=val.roulette.table;
			 var tablexml:XML;
			 var tableModel:TableModel;
			 for (i=0;i<xmllist.length();i++)
			 {
				 tablexml=xmllist[i];
				 tableModel=new TableModel();
				 //tableModel.streamMode=val.streamSever.@mode;
				 //tableModel.setStreamPath(val.streamSever);
				 tableModel.setData(tablexml);
				 tableModel.game="roulette"
				 _tableList.push(tableModel);
			 }
			 xmllist = val.roulette.vtable;
			 for (i=0;i<xmllist.length();i++)
			 {
				 tablexml=xmllist[i];
				 tableModel=new TableModel();
				 //tableModel.streamMode=val.streamSever.@mode;
				 //tableModel.setStreamPath(val.streamSever);
				 tableModel.setData(tablexml);
				 tableModel.game="roulette"
				 _tableList.push(tableModel);
			 }
			 
			 
			 xmllist = val.blackjack.table;
			 for (i=0;i<xmllist.length();i++)
			 {
				 tablexml=xmllist[i];
				 tableModel=new TableModel();
				 //tableModel.streamMode=val.streamSever.@mode;
				 //tableModel.setStreamPath(val.streamSever);
				 tableModel.setData(tablexml);
				 tableModel.game="blackjack"
				 _tableList.push(tableModel);
			 }
			 
			 xmllist = val.blackjack.vtable;
			 for (i=0;i<xmllist.length();i++)
			 {
				 tablexml=xmllist[i];
				 tableModel=new TableModel();
				 //tableModel.streamMode=val.streamSever.@mode;
				 //tableModel.setStreamPath(val.streamSever);
				 tableModel.setData(tablexml);
				 tableModel.game="blackjack"
				 _tableList.push(tableModel);
			 }
			 
			 xmllist = val.baccarat.table;
			 for (i=0;i<xmllist.length();i++)
			 {
				 tablexml=xmllist[i];
				 tableModel=new TableModel();
				 //tableModel.streamMode=val.streamSever.@mode;
				 //tableModel.setStreamPath(val.streamSever);
				 tableModel.setData(tablexml);
				 tableModel.game="baccarat"
				 _tableList.push(tableModel);
			 }
			 xmllist = val.baccarat.vtable;
			 for (i=0;i<xmllist.length();i++)
			 {
				 tablexml=xmllist[i];
				 tableModel=new TableModel();
				 //tableModel.streamMode=val.streamSever.@mode;
				 //tableModel.setStreamPath(val.streamSever);
				 tableModel.setData(tablexml);
				 tableModel.game="baccarat"
				 _tableList.push(tableModel);
			 }
		}
	}
}