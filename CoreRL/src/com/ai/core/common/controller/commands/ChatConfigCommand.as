package com.ai.core.common.controller.commands {
	
	import com.ai.core.common.controller.signals.ChatEvent;
	import com.ai.core.common.controller.signals.MessageEvent;
	import com.ai.core.model.Chat;
	import com.ai.core.model.Constants;
	import com.ai.core.model.FlashVars;
	import com.ai.core.model.IGameData;
	import com.ai.core.model.Player;
	import com.ai.core.model.SignalBus;
	import com.ai.core.model.URLSModel;
	import com.ai.core.utils.GameUtils;
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.loaders.XMLLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class ChatConfigCommand extends BaseCommand {
		
		[Inject]
		public var service:IAssetLoader;
		
		[Inject]
		public var urls:URLSModel;
		
		[Inject]
		public var game:IGameData;
		
		[Inject]
		public var player:Player;
		
		[Inject]
		public var chat:Chat;
		
		[Inject]
		public var flashvars:FlashVars;
		
		[Inject]
		public var signalBus:SignalBus;
		
		override public function execute():void {
			loadState();			
		}
		
		private function loadState():void {
			debug(urls.chatConfig + "?room_id=" + flashvars.room);
			service.addLoader(new XMLLoader(new URLRequest(urls.chatConfig + "?room_id=" + flashvars.room), Constants.SERVER_CHAT_CONFIG));
			service.getLoader(Constants.SERVER_CHAT_CONFIG).onError.add(showError);
			service.getLoader(Constants.SERVER_CHAT_CONFIG).onComplete.add(setConfig);			
			service.start();
		}
		
		private function setConfig(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			player.id = xml.userid;
			player.name = xml.username;
			player.type = xml.usertype;
			chat.server = xml.server;
			chat.port = xml.port;
			chat.room = xml.room;
			chat.serverSignupPath = xml.server_signup_path;
			chat.serverSignupString = xml.server_signup_string;			
			
			service.remove(Constants.SERVER_CHAT_CONFIG);
			authenticateChat();
		}
		
		private function authenticateChat():void {
			debug(chat.serverSignupPath + " encode: " + chat.serverSignupString);
			var request:URLRequest = new URLRequest(chat.serverSignupPath);
			var variables:URLVariables = new URLVariables();
			variables.encoded = chat.serverSignupString;
			request.data = variables;
			request.method = URLRequestMethod.POST;
			
			service.addLoader(new XMLLoader(request, Constants.SERVER_CHAT_SIGNUP));
			service.getLoader(Constants.SERVER_CHAT_SIGNUP).onError.add(showError);
			service.getLoader(Constants.SERVER_CHAT_SIGNUP).onComplete.add(connectToChatServer);
			service.start();
			
			signalBus.dispatch(ChatEvent.CONNECT);
		}
		
		private function connectToChatServer(signal:LoaderSignal, xml:XML):void {
			debug(xml);			
			service.remove(Constants.SERVER_CHAT_SIGNUP);			
			signalBus.dispatch(ChatEvent.CONNECT);
		}
		
		private function showError(signal:ErrorSignal):void {
			debug("Error:" +signal.message);
			signalBus.dispatch(MessageEvent.ERROR,{error:signal.message});
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}