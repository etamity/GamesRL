package com.newco.grand.lobby.classic.view.mediators
{
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.lobby.classic.controller.signals.LobbyEvents;
	import com.newco.grand.lobby.classic.model.LobbyModel;
	import com.newco.grand.lobby.classic.model.TableModel;
	import com.newco.grand.lobby.classic.view.LobbyView;
	import com.newco.grand.lobby.classic.view.TableView;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class LobbyViewMediator extends Mediator
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
		public var view:LobbyView;
		
		[Inject]
		public var flashvars:FlashVars;
		
		public function LobbyViewMediator()
		{
			super();
		}
		override public function initialize():void {
			signalBus.add(LobbyEvents.DATALOADED ,setupModel);
			
			
			view.gameChangeSignal.add(doGameChange);
			view.loadHistorySignal.add(doLoadHistory);
		}
		
		private function doLoadHistory():void{
			signalBus.dispatch(LobbyEvents.LOADHISTORY);
		}
		private function doGameChange(val:String):void{
			loadTable(val);
		}
		private function setupModel(signal:BaseSignal):void{
			loadTable(lobbyModel.mainGame);
			player.currencyCode="£";
			view.setBalance(player.balanceFormatted);
		}
		
		private function loadTable(type:String):void{
			var table:TableModel;
			var tableView:TableView;
			
			while(view.tablesLayer.numChildren>0)
			{
				tableView=view.tablesLayer.getChildAt(0) as TableView;
				tableView.destory();
				view.tablesLayer.removeChild(tableView);
			}
			
			view.count=0;
			for (var i:int=0;i<lobbyModel.tables.length;i++)
			{
				table=lobbyModel.tables[i];
				if (table.game.toLowerCase()==type.toLowerCase())
				{
					tableView=new TableView();
					tableView.setModel(table);
					//tableView.playDetialSignal.add(playDetialEvent);
					//tableView.stopDetialSignal.add(stopDetialEvent);
					tableView.openGameSignal.add(openGameEvent);
					
					view.addTable(tableView);
					tableView.screenshot.gotoAndStop(view.count);
				}
			}
			
			view.setRoulette(lobbyModel);
		}
		
		private function playDetialEvent():void{
			view.showDetial();
		}
		
		private function stopDetialEvent():void{
			view.hideDetial();
		}
		private function openGameEvent(table:TableModel):void{
			var url:String=flashvars.server+lobbyModel.opengameUrl+"?game="+table.game+"&table_id="+table.tableid+"&gameType="+table.gameType+"&lang=en&client=generic&gameInterface=view1";
			var urlRequest:URLRequest = new URLRequest(url);
				navigateToURL(urlRequest, "_blank");
			
		}
	}
}