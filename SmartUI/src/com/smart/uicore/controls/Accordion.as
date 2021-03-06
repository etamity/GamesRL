package com.smart.uicore.controls
{
	import com.smart.uicore.controls.managers.SkinLoader;
	import com.smart.uicore.controls.managers.SkinManager;
	import com.smart.uicore.controls.managers.SkinThemeColor;
	import com.smart.uicore.controls.managers.SourceSkinLinkDefine;
	import com.smart.uicore.controls.modeStyles.ButtonStyle;
	import com.smart.uicore.controls.skin.ActionDrawSkin;
	import com.smart.uicore.controls.skin.ListSkin;
	import com.smart.uicore.controls.skin.sourceSkin.ListSourceSkin;
	import com.smart.uicore.controls.support.ColorConversion;
	import com.smart.uicore.controls.support.UIComponent;
	import com.smart.uicore.controls.events.AccordionEvent;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;

	/**
	 * 
	 * 创建和管理导航器按钮（Accordion 标题），您可以使用这些按钮在子代之间导航。
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */
	[Event(name="AccordionEvent.SELECTED",type="com.smart.uicore.controls.events.AccordionEvent")]
	
	public class Accordion extends UIComponent
	{
		public var defaultButtonHeight:Number = 27;
		public var defaultGapHeight:Number = 8;
		protected var btns:Array;
		protected var _contents:Array;
		protected var nowIndex:uint;
		private var _txtFormat:TextFormat = new TextFormat("Arial", 12, 0XFFFFFF, true);
		
		public function Accordion()
		{
			super();
			btns = new Array();
			_contents = new Array();
			_compoWidth = 300;
			_compoHeight = 300;
			styleSet["ellipse"] = 0;
			styleSet["borderColor"] = ColorConversion.transUintToWeb(SkinThemeColor.border);
			styleSet["borderAlpha"] = 0.5;
			styleSet["backgroundColor"] = "#FDFDFD";
			styleSet["backgroundAlpha"] = 1.0;
			_txtFormat.align="center";
			setSize(_compoWidth, _compoHeight);
		}
		
		public function get buttons():Array{
			return btns;
		}
		
		public function get currentIndex():int{
			return nowIndex;
		}
		override public function setDefaultSkin():void {
			setSkin(ListSkin)
		}
		
		override public function setSourceSkin():void {
			setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.ACCORDION));
		}
		
		override public function setSkin(Skin:Class):void {
			if(SkinManager.isUseDefaultSkin == true){
				skin = new Skin();
				ActionDrawSkin(skin).init(this,styleSet);
			}else{
				var sous:ListSourceSkin = new ListSourceSkin();
				sous.init(this,styleSet,Skin);
				skin = sous;
			}
		}
		
		public function add(label:String,content:DisplayObject,icon:Object=null):void{
			var btn:Button;
			btn = new Button(SourceSkinLinkDefine.ACCORDIONBUTTON);
			btn.label = label;
			if(icon != null){
				btn.icon = icon;
			}
			btns.push(btn);
			_contents.push(content);
			btn.setSize(_compoWidth,defaultButtonHeight);
			btn.setStyle(ButtonStyle.TEXT_COLOR,"#FFFFFF");
			btn.setStyle(ButtonStyle.TEXT_OVER_COLOR,"#FFFFFF");
			btn.setStyle(ButtonStyle.TEXT_DOWN_COLOR,"#FFFFFF");
			btn.setTextFormat(_txtFormat);
			btn.addEventListener(MouseEvent.CLICK,switchClick);
			this.addChild(btn);
			this.addChild(content);
			switchTo(0);
		}
		
		protected function switchClick(event:MouseEvent):void
		{
			var index:uint;
			var btn:Button = event.currentTarget as Button;
			for(var i:int=0;i<btns.length;i++){
				if(btns[i] == btn){
					index = i;
				}
			}
			switchTo(index);
		}
		
		public function switchTo(index:uint):void{
			var i:int;
			var btn:Button;
			var dis:DisplayObject;
			for(i=0;i<=index;i++){
				btn = btns[i] as Button;
				btn.y = i*(defaultButtonHeight+defaultGapHeight);
			}
			for(i=index+1;i<btns.length;i++){
				btn = btns[i] as Button;
				btn.y = _compoHeight-(btns.length-i)*(defaultButtonHeight+defaultGapHeight);
			}
			for(i=0;i<_contents.length;i++){
				dis = _contents[i] as DisplayObject;
				if(dis.parent == this) dis.visible=false;
			}
			dis = _contents[index] as DisplayObject;
			//this.addChild(dis);
			dis.visible=true;
			dis.x = 1;
			dis.y = (index+1)*(defaultButtonHeight+defaultGapHeight);
			dis.scrollRect = new Rectangle(0,0,_compoWidth-2,_compoHeight-btns.length*(defaultButtonHeight+defaultGapHeight));
			nowIndex = index;
			this.dispatchEvent(new AccordionEvent(AccordionEvent.SELECTED,nowIndex,btns[nowIndex].label));
		}
		
		/**
		 * 获得内容的裁剪区域大小，当组件大小更改时可以根据此值相应调整内容的排版
		 */ 
		public function get contentScrollRect():Rectangle{
			return new Rectangle(0,0,_compoWidth-2,_compoHeight-btns.length*(defaultButtonHeight));
		}
		
		override public function setSize(newWidth:Number, newHeight:Number):void{
			super.setSize(newWidth,newHeight);
			if(btns.length ==0) return;
			var btn:Button;
			for(var i:int=0;i<btns.length;i++){
				btn = btns[i] as Button;
				btn.setSize(_compoWidth,(defaultButtonHeight));
			}
			switchTo(nowIndex);
		}
		
	}
}