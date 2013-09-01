package com.newco.grand.core.common.service.impl
{
	import com.newco.grand.core.common.controller.signals.ChatEvent;
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.controller.signals.PlayersEvent;
	import com.newco.grand.core.common.controller.signals.StartupDataEvent;
	import com.newco.grand.core.common.controller.signals.StateTableConfigEvent;
	import com.newco.grand.core.common.controller.signals.UIEvent;
	import com.newco.grand.core.common.controller.signals.WinnersEvent;
	import com.newco.grand.core.common.model.LanguageModel;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.StyleModel;
	import com.newco.grand.core.common.model.URLSModel;
	import com.evolutiongaming.ui.Language;
	import com.evolutiongaming.ui.Style;
	import com.newco.grand.core.common.service.api.IService;
	import com.newco.grand.core.utils.GameUtils;
	
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class LanguageService implements IService
	{
		
		[Inject]
		public var service:XMLService;
		
		[Inject]
		public var urls:URLSModel;
		
		[Inject]
		public var signalBus:SignalBus;
		
		public function LanguageService()
		{
		}
		
		public function load(onComplete:Function=null):void
		{
			loadLanguage();
		}
		private function loadLanguage():void {
			debug(urls.language);
			/*service.addLoader(new XMLLoader(new URLRequest(urls.language), Constants.ASSET_LANGUAGE));
			service.getLoader(Constants.ASSET_LANGUAGE).onError.add(showError);
			service.getLoader(Constants.ASSET_LANGUAGE).onComplete.add(setLanguage);			
			service.start();*/
			service.loadURL(urls.language,setLanguage,showError);
		}
		
		private function setLanguage(signal:LoaderSignal, xml:XML):void {
			//debug(xml);
			
			Language.getInstance().xml=xml;
			var nodeName:String;
			for each (var node:XML in xml.children()) {
				nodeName = String(node.name().localName).toUpperCase();
				LanguageModel[nodeName] = node.text();
			}
			//service.remove(Constants.ASSET_LANGUAGE);
			loadStyle();
		}
		
		private function loadStyle():void {
			debug(urls.style);			
			/*service.addLoader(new XMLLoader(new URLRequest(urls.style), Constants.ASSET_STYLE));
			service.getLoader(Constants.ASSET_STYLE).onError.add(showError);
			service.getLoader(Constants.ASSET_STYLE).onComplete.add(setStyle);
			service.start();*/
			service.loadURL(urls.style,setStyle,showError);
		}
		
		private function setStyle(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			Style.getInstance().xml=xml;
			var nodeName:String;
			var attributes:XMLList;
			for each (var node:XML in xml.children()) {
				nodeName = String(node.name().localName).toUpperCase();
				StyleModel[nodeName] = node.text();
				attributes = node.@*;
				for each (var node_att:XML in attributes) {
					StyleModel[nodeName + "_" + node.name()] = node;
				}
				if(node.children().length() > 0) {
					StyleModel[nodeName + "_XML"] = node;
				}
			}
			StyleModel.XMLDATA= xml;
			//service.remove(Constants.ASSET_STYLE);
			signalBus.dispatch(StartupDataEvent.LOADED);
			signalBus.dispatch(StateTableConfigEvent.LOAD);
			signalBus.dispatch(ChatEvent.LOAD_CONFIG);
			signalBus.dispatch(UIEvent.SETUP_ASSET);
			signalBus.dispatch(PlayersEvent.LOAD);
			signalBus.dispatch(WinnersEvent.LOAD);
		}
		
		private function showError(signal:ErrorSignal):void {
			debug("error " + signal.message);
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:signal.message});
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}