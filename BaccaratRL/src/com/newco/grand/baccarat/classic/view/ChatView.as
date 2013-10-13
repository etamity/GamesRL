package com.newco.grand.baccarat.classic.view
{
	import com.newco.grand.core.common.view.ChatView;
	import com.newco.grand.core.common.view.SMButton;
	
	import flash.events.MouseEvent;
	
	import caurina.transitions.Tweener;
	
	public class ChatView extends com.newco.grand.core.common.view.ChatView
	{
		private var _closeBtn:SMButton;
		protected var _extended:Boolean=false;
		public function ChatView()
		{
			super();
	
		}
		
		override public function initDisplay():void{
			_display=new Baccarat_ChatAsset();
			addChild(_display);
			_closeBtn=new SMButton(_display.closeBtn);
			_closeBtn.skin.addEventListener(MouseEvent.CLICK,doShowHide);
		}
		private function doShowHide(evt:MouseEvent):void{
			extended=!extended;
		}
		public function get extended():Boolean{
			return _extended;
		}
		public function set extended(val:Boolean):void{
			
			if (_extended==false){
				
				Tweener.addTween(view,{x:-250,time:0.5,onComplete:function ():void{}});
			}else{
				Tweener.addTween(view,{x:0,time:0.5,onComplete:function ():void{}});	
			}
			_extended=val;
		}
		override public function align():void{
			x=0;
			y=190;
			visible=true;
			Scroll.visible=false;
		}
	}
}