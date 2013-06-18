package com.ai.core.common.controller.commands {	
	
	import com.ai.core.common.controller.signals.ChatEvent;
	import com.ai.core.common.controller.signals.MessageEvent;
	import com.ai.core.common.controller.signals.PlayersEvent;
	import com.ai.core.common.controller.signals.StartupDataEvent;
	import com.ai.core.common.controller.signals.StateTableConfigEvent;
	import com.ai.core.common.controller.signals.UIEvent;
	import com.ai.core.common.controller.signals.WinnersEvent;
	import com.ai.core.common.model.Constants;
	import com.ai.core.common.model.Language;
	import com.ai.core.common.model.SignalBus;
	import com.ai.core.common.model.Style;
	import com.ai.core.common.model.URLSModel;
	import com.ai.core.utils.GameUtils;
	
	import flash.net.URLRequest;
	
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.loaders.XMLLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class StartupDataCommand extends BaseCommand {
		
		[Inject]
		public var service:IAssetLoader;
		
		[Inject]
		public var urls:URLSModel;
		
		[Inject]
		public var signalBus:SignalBus;
		override public function execute():void {
			loadLanguage();			
		}
		private function loadLanguage():void {
			debug(urls.language);
			service.addLoader(new XMLLoader(new URLRequest(urls.language), Constants.ASSET_LANGUAGE));
			service.getLoader(Constants.ASSET_LANGUAGE).onError.add(showError);
			service.getLoader(Constants.ASSET_LANGUAGE).onComplete.add(setLanguage);			
			service.start();
		}
		
		private function setLanguage(signal:LoaderSignal, xml:XML):void {
			//debug(xml);
			var nodeName:String;
			for each (var node:XML in xml.children()) {
				nodeName = String(node.name().localName).toUpperCase();
				Language[nodeName] = node.text();
			}
			service.remove(Constants.ASSET_LANGUAGE);
			loadStyle();
		}
		
		private function loadStyle():void {
			debug(urls.style);			
			service.addLoader(new XMLLoader(new URLRequest(urls.style), Constants.ASSET_STYLE));
			service.getLoader(Constants.ASSET_STYLE).onError.add(showError);
			service.getLoader(Constants.ASSET_STYLE).onComplete.add(setStyle);
			service.start();
		}
		
		private function setStyle(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			var nodeName:String;
			var attributes:XMLList;
			for each (var node:XML in xml.children()) {
				nodeName = String(node.name().localName).toUpperCase();
				Style[nodeName] = node.text();
				attributes = node.@*;
				for each (var node_att:XML in attributes) {
					Style[nodeName + "_" + node.name()] = node;
				}
				if(node.children().length() > 0) {
					Style[nodeName + "_XML"] = node;
				}
			}
			Style.XMLDATA= xml;
			service.remove(Constants.ASSET_STYLE);
			signalBus.dispatch(StartupDataEvent.LOADED);
			signalBus.dispatch(StateTableConfigEvent.LOAD);
			signalBus.dispatch(ChatEvent.LOAD_CONFIG);
			signalBus.dispatch(UIEvent.SETUP_ASSET);
			signalBus.dispatch(PlayersEvent.LOAD);
			signalBus.dispatch(WinnersEvent.LOAD);
		}
		
		private function showError(signal:ErrorSignal):void {
			debug("error " + signal.message);
			signalBus.dispatch(MessageEvent.ERROR,{error:signal.message});
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}