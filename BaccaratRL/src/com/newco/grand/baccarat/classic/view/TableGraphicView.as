package com.newco.grand.baccarat.classic.view
{
	import com.newco.grand.baccarat.classic.view.interfaces.ITableGraphicView;
	
	import flash.display.Sprite;
	
	public class TableGraphicView extends Sprite implements ITableGraphicView
	{
		protected var _display:*;
		public function TableGraphicView()
		{
			initDisplay();
			visible=false;
			
		}
		public function init():void{
			align();
		}
		
		public function align():void{
			visible=false;
		}
		public function get display():*{
			return this;
		}
		public function initDisplay():void{
			_display=new TableGraphicAsset();
			addChild(_display);
		}
	}
}