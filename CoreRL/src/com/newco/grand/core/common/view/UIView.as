package com.newco.grand.core.common.view
{
	import com.newco.grand.core.common.view.interfaces.IUIView;
	
	import flash.display.Sprite;
	
	import robotlegs.bender.framework.api.ILogger;
	
	public class UIView extends Sprite implements IUIView
	{
		[Inject]
		public var logger:ILogger
		
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
		
		public function get display():*
		{
			return this;
		}
		
		public function initDisplay():void
		{
		}
		
		public function updateLanguage():void{
			
		}
		
		public function debug(...args):void
		{
			logger.debug(args);
		}
	}
}