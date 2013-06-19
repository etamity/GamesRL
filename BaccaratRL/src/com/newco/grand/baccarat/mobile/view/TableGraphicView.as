package com.newco.grand.baccarat.mobile.view
{
	import com.newco.grand.baccarat.classic.view.TableGraphicView;
	

	public class TableGraphicView extends com.newco.grand.baccarat.classic.view.TableGraphicView
	{

		override public function align():void{
			y=515;
			visible=true;
		}
		override public function initDisplay():void{
			_display=new Mobile_TableGraphicAsset();
			addChild(_display);
		}
	}
}