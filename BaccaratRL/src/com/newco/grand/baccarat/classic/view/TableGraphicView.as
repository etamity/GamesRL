package com.newco.grand.baccarat.classic.view
{
	import com.newco.grand.baccarat.classic.view.interfaces.ITableGraphicView;
	import com.newco.grand.core.common.view.UIView;
	
	public class TableGraphicView extends UIView implements ITableGraphicView
	{
		protected var _skin:TableGraphicAsset;
		public function TableGraphicView()
		{
			super();
			
		}
		override public function initDisplay():void{
			 _skin=new TableGraphicAsset();
			addChild(_skin);
			_display=_skin;
		}

	}
}