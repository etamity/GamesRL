package com.newco.grand.core.common.view
{
	import com.newco.grand.core.common.view.interfaces.IUIView;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.display.Sprite;
	
	public class UIView extends Sprite implements IUIView
	{
		protected var _display:*;
		public function UIView()
		{
			visible = false;
			initDisplay();
		}

		public function init():void
		{
			updateLanguage();
			visible=true;
			align();
		}
		
		public function align():void
		{
		}
		
		public function get view():Sprite
		{
			return this;
		}
		
		public function setSkin(skin:*):void{
			_display = skin;
		}
		
		public function initDisplay():void
		{
		}
		
		public function updateLanguage():void{
			
		}
		
		public function debug(...args):void
		{
			//logger.debug(args);
			GameUtils.log(this,args);
		}
	}
}