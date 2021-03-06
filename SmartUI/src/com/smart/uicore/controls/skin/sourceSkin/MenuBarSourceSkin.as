package com.smart.uicore.controls.skin.sourceSkin
{
	import com.smart.uicore.controls.MenuBar;
	import com.smart.uicore.controls.support.UIComponent;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	
	public class MenuBarSourceSkin extends SourceSkin
	{
		
		private static var bd:BitmapData;
		private static var skin:DisplayObject;
		
		private var tar:MenuBar;
		
		public function MenuBarSourceSkin()
		{
			super();
		}
		
		override public function init(target:UIComponent,styleSet:Object,Skin:Class):void {
			super.init(target,styleSet,Skin);
			if(skin == null){
				skin = new Skin() as DisplayObject;
			}
			initBp(skin);
			tar = target as MenuBar;
			if(bd == null){
				bd=new BitmapData(skin.width,skin.height,true,0);
				bd.draw(skin,new Matrix(1,0,0,1,sx,sy));
			}
			bp.sourceBitmapData = bd;
			tar.addChildAt(bp,0);
		}
		
		override public function reDraw():void {
			bp.width = tar.compoWidth+sx*2;
			bp.height = tar.compoHeight+sy*2;
		}
		
	}
}