package com.newco.grand.roulette.classic.view
{
	import com.newco.grand.core.common.view.ChatView;
	import com.newco.grand.core.common.view.SMButton;
	
	public class ChatView extends com.newco.grand.core.common.view.ChatView
	{
		public function ChatView()
		{
			super();
		}
		override public function initDisplay():void{
			_display=new ChatAsset();
			addChild(_display);
			sendBtn=new SMButton(_display.sendBtn);
		}
		override public function align():void {			
			x =810;
			//x = 0;
			//y = 0;
		}
	}
}