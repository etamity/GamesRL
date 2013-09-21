package com.newco.grand.roulette.mobile.view
{
	import com.newco.grand.core.common.model.LanguageModel;
	import com.newco.grand.core.common.view.SMButton;
	import com.newco.grand.roulette.classic.model.BetspotData;
	import com.newco.grand.roulette.classic.view.BetSpotsView;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	public class BetSpotsView extends com.newco.grand.roulette.classic.view.BetSpotsView
	{
		private var nbButton:SMButton;
		public function BetSpotsView()
		{
			super();
		}
		
		override public function initDisplay():void{
			_display=new  Mobile_BetSpotsAsset();
			betspotClass=Mobile_BetSpotAsset;
			addChild(_display);
			
			createSpecialBetspots();
			_display.neighbourBetsMC.visible=false;
			_display.specialBetsMC.visible=false;
			nbButton=new SMButton(_display.nbButton);
			nbButton.skin.addEventListener(MouseEvent.CLICK,doNbClick);
			disableNSBets();
		}
		
		public function createSpecialBetspots():void{
			for (var b:uint=1; b <= 18; b++)
			{
				MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).buttonMode=true;
				MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).mouseChildren=false;

				MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).removeEventListener(MouseEvent.MOUSE_DOWN, higilightSpecial);
				MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).removeEventListener(MouseEvent.MOUSE_MOVE, higilightSpecial);
				MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).removeEventListener(MouseEvent.MOUSE_OUT, hideHigilightSpecial);
				MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).removeEventListener(MouseEvent.MOUSE_UP, placeNeighbourSpecialBets);
				MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).bg.alpha=0.6;
			}
		}
		
		public function disableNSBets():void
		{

				_display.specialBetsMC.visible = false;
				_display.neighbourBetsMC.visible=false;
				nbButton.enabled=false;
				for (var b:uint=1; b <= 18; b++)
				{
					MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).buttonMode=false;
					MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).removeEventListener(MouseEvent.MOUSE_DOWN, higilightSpecial);
					MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).removeEventListener(MouseEvent.MOUSE_MOVE, higilightSpecial);
					MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).removeEventListener(MouseEvent.MOUSE_OUT, hideHigilightSpecial);
					MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).removeEventListener(MouseEvent.MOUSE_UP, placeNeighbourSpecialBets);
					MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).removeEventListener(MouseEvent.ROLL_OVER, higilightSpecial);
					MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).removeEventListener(MouseEvent.ROLL_OUT, hideHigilightSpecial);
					MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).removeEventListener(MouseEvent.CLICK, placeNeighbourSpecialBets);
				}
				for (var n:uint=0; n <= 39; n++)
				{
					MovieClip(_display.neighbourBetsMC.popup.getChildByName("nb" + n)).buttonMode=false;
					MovieClip(_display.neighbourBetsMC.popup.getChildByName("nb" + n)).removeEventListener(MouseEvent.MOUSE_DOWN, higilightNeighbour);
					MovieClip(_display.neighbourBetsMC.popup.getChildByName("nb" + n)).removeEventListener(MouseEvent.MOUSE_MOVE, higilightNeighbour);
					MovieClip(_display.neighbourBetsMC.popup.getChildByName("nb" + n)).removeEventListener(MouseEvent.MOUSE_OUT, removeHigilightNeighbour);
					MovieClip(_display.neighbourBetsMC.popup.getChildByName("nb" + n)).removeEventListener(MouseEvent.MOUSE_UP, placeNeighbourSpecialBets);
					MovieClip(_display.neighbourBetsMC.popup.getChildByName("nb" + n)).removeEventListener(MouseEvent.ROLL_OVER, higilightNeighbour);
					MovieClip(_display.neighbourBetsMC.popup.getChildByName("nb" + n)).removeEventListener(MouseEvent.ROLL_OUT, removeHigilightNeighbour);
					MovieClip(_display.neighbourBetsMC.popup.getChildByName("nb" + n)).removeEventListener(MouseEvent.CLICK, placeNeighbourSpecialBets);
				}
				
				var finalBtn:SimpleButton;
				for (var i:int=0;i<10;i++){
					finalBtn=_display.neighbourBetsMC.finalMc.getChildByName("F"+String(i));
					finalBtn.removeEventListener(MouseEvent.MOUSE_UP, placeNeighbourSpecialBets);
					finalBtn.removeEventListener(MouseEvent.MOUSE_DOWN, higilightNeighbour);
					finalBtn.removeEventListener(MouseEvent.MOUSE_MOVE, higilightNeighbour);
					finalBtn.removeEventListener(MouseEvent.MOUSE_OUT, removeHigilightNeighbour);
				}
		}
		public function enableNSBets():void
		{
			//_display.specialBetsMC.visible=true;
			//_display.neighbourBetsMC.visible=true;
			nbButton.enabled=true;
				for (var b:uint=1; b <= 18; b++)
				{
					MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).buttonMode=true;
					MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).addEventListener(MouseEvent.MOUSE_DOWN, higilightSpecial);
					MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).addEventListener(MouseEvent.MOUSE_MOVE, higilightSpecial);
					MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).addEventListener(MouseEvent.MOUSE_OUT, hideHigilightSpecial);
					MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).addEventListener(MouseEvent.MOUSE_UP, placeNeighbourSpecialBets);
				}
				for (var n:uint=0; n <= 39; n++)
				{
					MovieClip(_display.neighbourBetsMC.popup.getChildByName("nb" + n)).buttonMode=true;
					MovieClip(_display.neighbourBetsMC.popup.getChildByName("nb" + n)).addEventListener(MouseEvent.MOUSE_DOWN, higilightNeighbour);
					MovieClip(_display.neighbourBetsMC.popup.getChildByName("nb" + n)).addEventListener(MouseEvent.MOUSE_MOVE, higilightNeighbour);
					MovieClip(_display.neighbourBetsMC.popup.getChildByName("nb" + n)).addEventListener(MouseEvent.MOUSE_OUT, removeHigilightNeighbour);
					MovieClip(_display.neighbourBetsMC.popup.getChildByName("nb" + n)).addEventListener(MouseEvent.MOUSE_UP, placeNeighbourSpecialBets);
				}
				
				var finalBtn:SimpleButton;
				for (var i:int=0;i<10;i++){
					finalBtn=_display.neighbourBetsMC.finalMc.getChildByName("F"+String(i));
					finalBtn.addEventListener(MouseEvent.MOUSE_UP, placeNeighbourSpecialBets);
					finalBtn.addEventListener(MouseEvent.MOUSE_DOWN, higilightNeighbour);
					finalBtn.addEventListener(MouseEvent.MOUSE_MOVE, higilightNeighbour);
					finalBtn.addEventListener(MouseEvent.MOUSE_OUT, removeHigilightNeighbour);
				}
		}
	
		override public function enableBetting():void{
			super.enableBetting();
			enableNSBets();
		}
		override public function disableBetting():void{
			super.disableBetting();
			disableNSBets();
		}
	
		private function higilightSpecial(evt:MouseEvent):void
		{
			evt.target.alpha=1;
			highlight(evt.target.name);
			//dispatchEvent(new EventParams("HigilightSpecialEvent", false, false, evt));
		}
		
		
		private function hideHigilightSpecial(evt:MouseEvent):void
		{
	
			evt.target.alpha=0.8;
			removeHighlight(evt.target.name);
			//dispatchEvent(new EventParams("HideHigilightSpecialEvent", false, false, evt));
		}
		private function placeNeighbourSpecialBets(evt:MouseEvent):void
		{
			var nme:String=evt.target.name.toUpperCase();
			nme=(nme == "NB0" || nme == "NB1" || nme == "NB3" || nme=="ZEROBETS") ? ("B" + nme) : nme;
			var highlights:Array=BetspotData[nme];
			if (highlights != null && highlights.length > 0)
			{
				for (var i:uint=0; i < highlights.length; i++)
				{
					_betspotMC=getBetspotByName("bs" + highlights[i]);
					if (_betspotMC != null)
					{
						_betspotMC.placeChip(null);
					}
				}
			}
		}
		
		
		public function setZeroGameEvent(val:DisplayObject):void{
			val.addEventListener(MouseEvent.MOUSE_UP, placeNeighbourSpecialBets);
			val.addEventListener(MouseEvent.MOUSE_DOWN, higilightNeighbour);
			val.addEventListener(MouseEvent.MOUSE_MOVE, higilightNeighbour);
			val.addEventListener(MouseEvent.MOUSE_OUT, removeHigilightNeighbour);
			
		}
		override public function updateLanguage():void{
			super.updateLanguage();
			nbButton.label=LanguageModel.NEIGHBOURBETS;
			
			for (var b:uint=1; b <= 18; b++)
			{
				MovieClip(_display.specialBetsMC.popup.getChildByName("sp" + b)).label.text=LanguageModel["SPECIALBET" + b];
			}
			_display.neighbourBetsMC.popup.label1.text=LanguageModel["NEIGHBOURBETS1"].toUpperCase();
			_display.neighbourBetsMC.popup.label2.text=LanguageModel["NEIGHBOURBETS2"].toUpperCase();
			_display.neighbourBetsMC.popup.label3.text=LanguageModel["NEIGHBOURBETS3"].toUpperCase();
		}
		
		private function doNbClick(evt:MouseEvent):void{
			_display.neighbourBetsMC.visible=!_display.neighbourBetsMC.visible;
			_display.specialBetsMC.visible=!_display.specialBetsMC.visible;
		}
	}
}