
package com.newco.grand.baccarat.classic.view.tournamenet   {
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
	
	import caurina.transitions.Tweener;
	
	public class PlayerList extends MovieClip {
		
		private var playerItems:Array;
		private var xmlLoader:URLLoader;
		private var urlString:String;
		private var refreshInterval:int = 20000;
		
		private var maxDisplayItem:int=5;
		
		public function PlayerList(url:String) {
			// constructor code
			urlString = url;
			xmlLoader = new URLLoader();			
			xmlLoader.addEventListener(Event.COMPLETE, xmlConfigLoadingSuccessed);
            xmlLoader.addEventListener(IOErrorEvent.IO_ERROR,  xmlConfigLoadingFailed);
			playerItems = [];
			
			loadXML();
		}
		
		
		private function loadXML():void {
			var url:String = urlString + "?rtime=" + String(new Date().getTime());
            xmlLoader.load( new URLRequest( url) );
			//trace("Tournament URL:"+url);
		}
		
		private function xmlConfigLoadingSuccessed(event:Event):void {
			var load_config:XML = new XML( event.target.data );
			var item:PlayerItem;
			
			//trace( load_config.item );
			
			while (numChildren>0)
				this.removeChildAt(0);
			
			playerItems=[];
			
			var length:int = (maxDisplayItem > load_config.item.length() ) ? load_config.item.length() : maxDisplayItem;
			
			for(var i:int=0; i<length; i++) {
				var temp:XML = load_config.item[i];
				
				item = new PlayerItem();
				item.label = temp.@playerName;
				item.points = temp.@points;
				item.y += (i * item.height);
				item.bg.visible = Boolean( (i+1) %2);
				playerItems.push(item);
				item.alpha = 0;
				addChild(item);
				
				setTimeout(animate, i*150, item);
			}
			setTimeout(loadXML, refreshInterval);
			//stage.dispatchEvent(new Event(Event.RESIZE) );
		}
		
		private function animate(item:PlayerItem):void {
		 Tweener.addTween(item,{alpha:1,time:1});
		}
				
		private function xmlConfigLoadingFailed(event:IOErrorEvent):void {
			debug(event.text);
			setTimeout(loadXML, refreshInterval);
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
	
}
