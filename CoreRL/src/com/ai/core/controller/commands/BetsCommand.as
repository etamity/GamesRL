package com.ai.core.controller.commands {
	
	import com.ai.core.controller.signals.BalanceEvent;
	import com.ai.core.controller.signals.BetEvent;
	import com.ai.core.model.Constants;
	import com.ai.core.model.FlashVars;
	import com.ai.core.model.IGameData;
	import com.ai.core.model.Player;
	import com.ai.core.model.SignalBus;
	import com.ai.core.model.URLSModel;
	import com.ai.core.utils.GameUtils;
	
	import flash.net.URLRequest;
	
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.loaders.XMLLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class BetsCommand extends BaseCommand {
		
		[Inject]
		public var service:IAssetLoader;
		
		[Inject]
		public var urls:URLSModel;
		
		[Inject]
		public var player:Player;
		
		[Inject]
		public var game:IGameData;
		
		[Inject]
		public var flashvars:FlashVars;
		
		[Inject]
		public var signalBus:SignalBus;
		
		public function BetsCommand():void{
	
		}
		
		override public function execute():void {
			sendBets();
		}
		
		private function sendBets():void {
			if (service.getLoader(Constants.SERVER_SEND_BETS)==null)
			service.addLoader(new XMLLoader(new URLRequest(urls.sendBets + "?user_id=" + player.id + "&table_id=" + flashvars.table_id+ "&vt_id="+flashvars.vt_id + "&game_id=" + game.gameID + player.betString + "&noOfBets=" + player.betCount), Constants.SERVER_SEND_BETS));
			service.getLoader(Constants.SERVER_SEND_BETS).onError.add(showError);
			service.getLoader(Constants.SERVER_SEND_BETS).onComplete.add(betsResponse);
			service.start();
			debug(urls.sendBets + "?user_id=" + player.id + "&table_id=" + flashvars.table_id + "&vt_id="+flashvars.vt_id + "&game_id=" + game.gameID + player.betString + "&noOfBets=" + player.betCount);
		}
		
		private function betsResponse(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			if(xml.hasOwnProperty("error")) {
				signalBus.dispatch(BetEvent.BETS_REJECTED);
			}
			else {
				player.balance = Number(xml.balance);
				signalBus.dispatch(BetEvent.BETS_ACCEPTED);
				signalBus.dispatch(BalanceEvent.LOADED);
			}
			if (service.getLoader(Constants.SERVER_SEND_BETS)!=null)
			service.remove(Constants.SERVER_SEND_BETS);
			
			/*<response>
				<session>online</session>
				<sitting>true</sitting>
				<error id="1001"/>
			  </response>
			*/
		}
		
		private function showError(signal:ErrorSignal):void {
			debug("error");
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}