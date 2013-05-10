package com.ai.core.view
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.clearInterval;
	import flash.utils.setTimeout;
	
	import org.osflash.signals.Signal;
	
	public class TaskbarMenu extends MovieClip
	{
		private var _menuCollection:Array = [];
		private var interval:int;
		
		public var clickSignal:Signal=new Signal();
		public function TaskbarMenu():void {
			visible = false;
			addEventListener(MouseEvent.MOUSE_OVER, mouseEvent);
			addEventListener(MouseEvent.MOUSE_OUT, mouseEvent);
		}
		
		public function createMenuItem(label:String, url:String):void {
			var menuItem:MenuItemMc;
			menuItem = new MenuItemMc();
			menuItem.mouseChildren = false;
			menuItem.buttonMode = true;
			menuItem.label.htmlText = "<b>" + label + "</b>";
			menuItem.url = url;
			menuItem.addEventListener(MouseEvent.CLICK, mouseClick);
			addChild(menuItem);
			
			_menuCollection.push(menuItem);
			menuItem.y += menuItem.height * _menuCollection.length;
		}
		
		private function mouseClick(event:MouseEvent):void {
			visible = false;
			//dispatchEvent(  new TaskbarActionEvent( TaskbarActionEvent.MENUITEM_CLICKED, (event.target as MenuItemMc).url) );
			clickSignal.dispatch((event.target as MenuItemMc).url);
		}
		
		private function mouseEvent(event:MouseEvent):void {
			switch(event.type) {
				case "mouseOver":
					clearInterval(interval);
					break;
				case "mouseOut":
					interval = setTimeout(hideMe, 1000);
					break;
			}
		}
		
		private function hideMe():void {
			visible = false;
		}
		
	}
}

class MenuItemMc extends MenuItem {
	public var url:String;
}