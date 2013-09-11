package com.newco.grand.baccarat.classic.view
{
	import com.newco.grand.core.common.view.ChatView;
	
	public class ChatView extends com.newco.grand.core.common.view.ChatView
	{
		public function ChatView()
		{
			super();
		}
		override public function align():void{
			x=0;
			y=190;
			visible=true;
			Scroll.visible=false;
		}
	}
}