
package com.newco.grand.baccarat.classic.view.tournamenet   {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
	
	import fl.transitions.Tween;
	import fl.transitions.easing.Strong;
	
	public class PlayerList extends MovieClip {
		
		private var playerItems:Array;
		private var xmlLoader:URLLoader;
		private var urlString:String;
		private var refreshInterval:int = 20000;
		
		private var maxDisplayItem:int;
		
		public function PlayerList(url:String) {
			// constructor code
			urlString = url;
			xmlLoader = new URLLoader();			
			xmlLoader.addEventListener(Event.COMPLETE, xmlConfigLoadingSuccessed);
            xmlLoader.addEventListener(IOErrorEvent.IO_ERROR,  xmlConfigLoadingFailed);
			playerItems = [];
			
			loadXML();
		}
		
		public function updateNow(h:Number):void {
			maxDisplayItem = h / 38;
			trace( 'maxDisplayItem', maxDisplayItem );
		}
		
		private function loadXML():void {
			var url:String = urlString;// + "&random=" + (Math.random() );
            xmlLoader.load( new URLRequest( url) );
			trace("Tournament URL:"+url);
		}
		
		private function xmlConfigLoadingSuccessed(event:Event):void {
			var load_config:XML = new XML( event.target.data );
			var item:PlayerItem;
			
			//trace( load_config.item );
			
			if(playerItems.length > 0) {
				while (playerItems.length > 0) {
					removeChild( playerItems[ playerItems.length-1 ] );
					playerItems.pop();
				}
			}
			
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
			
			//stage.dispatchEvent(new Event(Event.RESIZE) );
		}
		
		private function animate(item:PlayerItem):void {
			var tween:Tween = new Tween(item, "alpha", Strong.easeIn, 0, 1, 1, true);
		}
				
		private function xmlConfigLoadingFailed(event:IOErrorEvent):void {
			trace(event);
			setTimeout(loadXML, refreshInterval);
		}

	}
	
}
