package com.newco.grand.core.common.view
{
	import com.newco.grand.core.common.view.interfaces.IErrorMessageView;
	
	import flash.events.MouseEvent;
	
	public class ErrorMessageView extends UIView implements IErrorMessageView
	{
		public function ErrorMessageView()
		{
			super();
			_display.errorMsg.text="";
			_display.closeBtn.addEventListener(MouseEvent.CLICK,doHideEvent);
		}
		override public function initDisplay():void
		{
			_display= new ErrorMessageAsset();
			addChild( _display);

		}

		private function doHideEvent(evt:MouseEvent):void{
			visible=false;
		}
		public function setErrorMessage(val:String):void{
			align();
			_display.errorMsg.htmlText+=val+"<br />";
			
			visible=false;
			
		}
		override public function align():void
		{
			x=(stage.stageWidth- _display.width)/2;
			y= stage.stageHeight- _display.height;
			visible=false;
		}
		

	}
}