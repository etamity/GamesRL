package com.newco.grand.core.common.view.uicomps
{
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.LanguageModel;
	import com.newco.grand.core.common.view.SMButton;
	
	import flash.display.Loader;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;
	

	public class LanguagePanelView extends LanguagePanelAsset 
	{
		
		public var onChange:Signal=new Signal();
		
		public var path:String;
		public function LanguagePanelView()
		{
			super();
		}
		public function load(data:XML):void{
			var length:int =data.lang.length();
			var bgHeight:int = (length+1) * 21;
			var lang:XMLList=data.lang;
			bg.height=bgHeight+5;
			this.languageLabel.text=LanguageModel.LANGUAGE;
			var langBtn:SMButton;
			for (var i:int=0;i<length;i++)
			{
				langBtn=new SMButton(new LanguageButton());
				langBtn.label=lang[i].@name;
				langBtn.params.lang=lang[i].@code;
				langBtn.onClick.add(function (btn:SMButton):void{
					visible=false;
					onChange.dispatch(btn);
				});

					langBtn.skin.x= 5;
					langBtn.skin.y=25+ i* 22;
					if (FlashVars.PLATFORM==FlashVars.AIR_PLATFORM)
					{
						langBtn.skin.x= 100;
						langBtn.skin.y=85+ i* 22;
					}
				addChild(langBtn.skin);
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError); 
				var urlIcon:String= path +lang[i].@icon+".png";
				trace(urlIcon);
				loader.load(new URLRequest(urlIcon));
				loader.x=langBtn.skin.x;
				loader.y=langBtn.skin.y+4;
				addChild(loader);
			}
		}
		private function onError(evt:IOErrorEvent):void{
			trace(evt);
		}
	}
}