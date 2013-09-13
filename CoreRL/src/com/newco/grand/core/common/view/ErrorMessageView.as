package com.newco.grand.core.common.view
{
	import com.newco.grand.core.common.view.interfaces.IErrorMessageView;
	
	import flash.events.MouseEvent;
	
	public class ErrorMessageView extends UIView implements IErrorMessageView
	{
		protected var _skin:ErrorMessageAsset;
		public function ErrorMessageView()
		{
			super();
			visible=false;
		}
		override public function initDisplay():void
		{
			 _skin= new ErrorMessageAsset();
			addChild( _skin);
			 _skin.errorMsg.text="";
			 _skin.closeBtn.addEventListener(MouseEvent.CLICK,doHideEvent);
			_display= _skin;
		}

		private function doHideEvent(evt:MouseEvent):void{
			visible=false;
		}
		public function setErrorMessage(val:String):void{
			align();
			 _skin.errorMsg.htmlText+=val+"<br />";
			
			visible=true;
			
		}
		override public function align():void
		{
			x=(stage.stageWidth- _skin.width)/2;
			y= stage.stageHeight- _skin.height;
			visible=false;
		}
		

	}
}