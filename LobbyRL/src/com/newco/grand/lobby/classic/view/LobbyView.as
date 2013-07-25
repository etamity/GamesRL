package com.newco.grand.lobby.classic.view
{
	import com.newco.grand.core.common.view.SMButton;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	import caurina.transitions.Tweener;
	
	import org.osflash.signals.Signal;

	public class LobbyView extends Sprite
	{
		public var tablesLayer:MovieClip=new MovieClip();
		
		private var _count:int=0;
		
		private var layout:LayoutAsset=new LayoutAsset();
		private var bottomPanel:BottomPanelAsset;
		
		public var rouletteBtn:SMButton;
		public var baccaratBtn:SMButton;
		public var blackjackBtn:SMButton;
		
		public var gameChangeSignal:Signal=new Signal();
		public function LobbyView()
		{
			addChild(tablesLayer);
			bottomPanel=new BottomPanelAsset();
			addChild(bottomPanel);
			rouletteBtn=new SMButton(bottomPanel.rouletteBtn);
			baccaratBtn=new SMButton(bottomPanel.baccaratBtn);
			blackjackBtn=new SMButton(bottomPanel.blackjackBtn);
			
			
			rouletteBtn.label="Roulette";
			baccaratBtn.label="Baccarat";
			blackjackBtn.label="Blackjack";
			
			rouletteBtn.skin.addEventListener(MouseEvent.CLICK,doChangeGame);
			baccaratBtn.skin.addEventListener(MouseEvent.CLICK,doChangeGame);
			blackjackBtn.skin.addEventListener(MouseEvent.CLICK,doChangeGame);	
		}
		
		public function doChangeGame(evt:MouseEvent):void{
			var target:SimpleButton=evt.target as SimpleButton;
			switch (target.name)
			{
				case "rouletteBtn":
					gameChangeSignal.dispatch("Roulette");
					break;
				case "baccaratBtn":
					gameChangeSignal.dispatch("Baccarat");
					break;
				case "blackjackBtn":
					gameChangeSignal.dispatch("Blackjack");
					break;
			}
			
	
			trace(target.name);
		}
		
		public function setBalance(val:Number):void{
			bottomPanel.balanceMC.value.text=String(val);
		}
		
		public function get count():int{
			return _count;
		}
		
		public function set count(val:int):void{
			 _count=val;

		}
		public function addTable(mc:TableView):void{
			if (_count<4)
			{
			var pt:Point=new Point(layout.getChildByName("table"+String(_count)).x,layout.getChildByName("table"+String(_count)).y);
			tablesLayer.addChild(mc);
			mc.alpha=0;
			mc.x= (count % 2==0)?-300:1000;
			mc.y= pt.y;
	
			setTimeout(function ():void{
			Tweener.addTween(mc,{x:pt.x,y:pt.y,alpha:1,time:0.5});
			},_count*500);
			
	
			_count++;
			}
		}
	}
}