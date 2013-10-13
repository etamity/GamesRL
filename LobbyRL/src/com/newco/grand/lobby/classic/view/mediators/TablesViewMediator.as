package com.newco.grand.lobby.classic.view.mediators
{
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.lobby.classic.controller.signals.LobbyEvents;
	import com.newco.grand.lobby.classic.model.LobbyModel;
	import com.newco.grand.lobby.classic.model.TableModel;
	import com.newco.grand.lobby.classic.view.BaccaratTable;
	import com.newco.grand.lobby.classic.view.TablesView;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class TablesViewMediator extends Mediator
	{
		[Inject]
		public var contextView:ContextView;
		[Inject]
		public var signalBus:SignalBus;
		[Inject]
		public var lobbyModel:LobbyModel;
		[Inject]
		public var player:Player;
		[Inject]
		public var view:TablesView;
		[Inject]
		public var flashvars:FlashVars;
		[Inject]
		public var urlsModel:URLSModel;
		public function TablesViewMediator()
		{
			super();
		}
		override public function initialize():void {
	
			signalBus.add(LobbyEvents.LOBBYDATA_LOADED ,setupModel);
			signalBus.add(LobbyEvents.SHOW_TABLE,doShowTable);
			view.selectSignal.add(doSelectTable);
			view.openGameSignal.add(openGameEvent);
		}
		private function doSelectTable(table:TableModel):void{
			var vtables:Array= lobbyModel.getVTables(table.tableid,table.game);
			if (vtables.length<=0)
			{
				openGameEvent(table);
			}else
			{				
			view.showVTables(vtables);
			signalBus.dispatch(LobbyEvents.SHOW_VIRTUALTABLE);
			}
		}
		private function setupModel(signal:BaseSignal):void{
			var url:String;
		
			url=urlsModel.statistics;//flashvars.server+urlsModel.urlsXml.baccarat.statistics;
			view.scoreBoradUrl=url;
			view.avatarsUrl=urlsModel.lobbyAvatar;
			view.avatarsData=lobbyModel.avatarData;
			loadTable();
		}
		private function doShowTable(signal:BaseSignal):void{
			view.viewTables();
		}
		
		private function loadTable():void{
			var table:TableModel;
			var tableView:BaccaratTable;
			var btables:Array=lobbyModel.getTables("baccarat");
			var rtables:Array=lobbyModel.getTables("roulette");
			view.clear();
			view.showTables(btables);
			view.showTables(rtables);
		}
		
		
		private function openGameEvent(table:TableModel):void{
			var url:String=urlsModel.opengame+"?game="+table.game+"&table_id="+table.tableid+"&gameType="+table.gameType+"&lang="+flashvars.lang+"&client="+flashvars.client;
			var urlRequest:URLRequest = new URLRequest(url);
			navigateToURL(urlRequest, "_self");
			
		}
	}
}