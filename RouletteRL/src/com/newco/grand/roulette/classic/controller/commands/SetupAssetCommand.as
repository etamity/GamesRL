package com.newco.grand.roulette.classic.controller.commands
{
	import com.newco.grand.core.common.controller.commands.BaseCommand;
	import com.newco.grand.core.common.controller.signals.UIEvent;
	import com.newco.grand.core.common.model.Constants;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.display.MovieClip;
	import flash.net.URLRequest;
	
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.loaders.SWFLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class SetupAssetCommand extends BaseCommand
	{
		[Inject]
		
		public var service:IAssetLoader;
		
		[Inject]
		public var urls:URLSModel;
		
		[Inject]
		public var signalBus:SignalBus;
		
		public function SetupAssetCommand()
		{
			super();
		}
		
		override public function execute():void {
			//loadLobby();
		}
		
		/** load help swf file **/
		private function loadHelp():void {
			debug(urls.help);
			service.addLoader(new SWFLoader(new URLRequest(urls.help), Constants.ASSET_HELP));
			service.getLoader(Constants.ASSET_HELP).onError.add(showError);
			service.getLoader(Constants.ASSET_HELP).onComplete.add(setHelp);
			service.start();
		}
		
		private function setHelp(signal:LoaderSignal, data:MovieClip):void {
			trace('setHelp', data);
			//eventDispatcher.dispatchEvent( new UIEvent( UIEvent.HELP_LOADED, data) );
			
			signalBus.dispatch(UIEvent.HELP_LOADED,{movieclip:data});
			
			//loadLobby();
		}
		
		
		/** load lobby swf file **/
		private function loadLobby():void {
			debug(urls.lobby);
			service.addLoader(new SWFLoader(new URLRequest(urls.lobbySWF), Constants.ASSET_LOBBY));
			service.getLoader(Constants.ASSET_LOBBY).onError.add(showError);
			service.getLoader(Constants.ASSET_LOBBY).onComplete.add(setLobby);
			service.start();
		}
		
		private function setLobby(signal:LoaderSignal, data:MovieClip):void {
			trace('lobby', data);
			//eventDispatcher.dispatchEvent( new UIEvent( UIEvent.LOBBY_LOADED, data) );
			signalBus.dispatch(UIEvent.LOBBY_LOADED,{movieclip:data});
		}
		
		
		private function showError(signal:ErrorSignal):void {
			debug("Error " + signal.message);
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}