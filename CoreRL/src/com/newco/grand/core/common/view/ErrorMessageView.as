package com.newco.grand.core.common.view
{
	import com.newco.grand.core.common.view.interfaces.IErrorMessageView;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ErrorMessageView extends Sprite implements IErrorMessageView
	{
		protected var _display:*;
		public function ErrorMessageView()
		{
			super();
			initDisplay();
			_display.errorMsg.text="";
			visible=false;
			_display.closeBtn.addEventListener(MouseEvent.CLICK,doHideEvent);
		}
		public function initDisplay():void
		{
			_display= new ErrorMessageAsset();
			addChild(_display);
		}
		public function init():void
		{
			align()
		}
		private function doHideEvent(evt:MouseEvent):void{
			visible=false;
		}
		public function setErrorMessage(val:String):void{
			align();
			_display.errorMsg.text=val;
			visible=true;
			
		}
		public function align():void
		{
			x=(stage.stageWidth-_display.width)/2;
			y= stage.stageHeight-_display.height;
		}
		
		public function get display():*
		{
			return this;
		}
		

	}
}