package com.newco.grand.roulette.classic.view
{
	import com.newco.grand.core.common.view.ChatView;
	
	public class ChatView extends com.newco.grand.core.common.view.ChatView
	{
		public function ChatView()
		{
			super();
		}
		override public function initDisplay():void{
			_display=new ChatAssetRL();
			addChild(_display);
		}
		override public function align():void {	
			this.Scroll.x= 155;
			x =810;
			//x = 0;
			//y = 0;
		}
	}
}