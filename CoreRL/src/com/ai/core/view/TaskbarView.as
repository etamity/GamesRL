package com.ai.core.view {
	
	import com.ai.core.controller.signals.BetEvent;
	import com.ai.core.controller.signals.TaskbarActionEvent;
	import com.ai.core.utils.FormatUtils;
	import com.ai.core.utils.GameUtils;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.text.TextFormat;
	
	import org.osflash.signals.Signal;
	
	public class TaskbarView extends TaskbarAsset {
		
		private const ICON_OFF:String = "off";
		private const ICON_OFF_OVER:String = "offover";
		private const ICON_ON:String = "on";
		private const ICON_ON_OVER:String = "onover";
		
		private const CHIPS_COUNT:uint = 6;
		
		private var _chips:Array;
		private var _chipSelected:Number=0;
		private var _menuItems:TaskbarMenu;
		private var _toolTip:Tooltip;
		private var _myAccountURL:String;
		
		private var _mat:Array = [.3,.3,.3,0,0,
								.3,.3,.3,0,0,
								.3,.3,.3,0,0,
								.3,.3,.3,.3,.3];
		private var _colorMat:ColorMatrixFilter = new ColorMatrixFilter(_mat);
		
		private var clearBtn:SMButton;
		private var undoBtn:SMButton;
		private var doubleBtn:SMButton;
		private var repeatBtn:SMButton;
		
		private var confirmBtn:SMButton;
		private var favouritesBtn:SMButton;
		
		public var buttonClickedSignal:Signal= new Signal();
		public var showDefaultSignal:Signal= new Signal();
		public var menuitemClickedSignal:Signal= new Signal();
		public var undoSignal:Signal= new Signal();
		public var clearClickedSignal:Signal= new Signal();
		public var repeatClickedSignal:Signal= new Signal();
		public var doubleClickedSignal:Signal= new Signal();
		public var confirmClickedSignal:Signal= new Signal();
		public var favouritesClickedSignal:Signal= new Signal();
		public var chipClickedSignal:Signal= new Signal();
		
		
		public function TaskbarView() {
			visible = false;
			
			sound.iconMC.gotoAndStop(ICON_OFF);
			fullscreen.iconMC.gotoAndStop(ICON_OFF);
			chat.iconMC.gotoAndStop(ICON_OFF);
			help.iconMC.gotoAndStop(ICON_OFF);
			history.iconMC.gotoAndStop(ICON_OFF);
			responsible.iconMC.gotoAndStop(ICON_OFF);
			settings.iconMC.gotoAndStop(ICON_OFF);
			
			sound.buttonMode = true;
			fullscreen.buttonMode = true;
			chat.buttonMode = true;
			help.buttonMode = true;
			history.buttonMode = true;
			responsible.buttonMode = true;
			settings.buttonMode = true;
			
			sound.mouseChildren = false;
			fullscreen.mouseChildren = false;
			chat.mouseChildren = false;
			help.mouseChildren = false;
			history.mouseChildren = false;
			responsible.mouseChildren = false;
			settings.mouseChildren = false;
			
			/*settings.visible = false;
		
			help.visible = false;
			history.visible = false;*/
			
			clearBtn = new SMButton(clear);
			undoBtn = new SMButton(undo);
			repeatBtn = new SMButton(repeat);
			doubleBtn = new SMButton(double);
			confirmBtn = new SMButton(confirm);
			favouritesBtn = new SMButton(favourites);
			
			
			responsible.visible = false;
			chat.visible = false;
			chat.mouseEnabled=false;
			settings.mouseEnabled=false;
			history.mouseEnabled=false;
			help.mouseEnabled=false;

			/*clear.mouseChildren = false;
			undo.mouseChildren = false;
			repeat.mouseChildren = false;
			double.mouseChildren = false;*/
			myaccount.mouseChildren = false;
			/*clear.buttonMode = true;
			undo.buttonMode = true;
			repeat.buttonMode = true;
			double.buttonMode = true;*/
			lobby.mouseChildren = false;
			lobby.buttonMode = true;
			lobby.visible=false;
			myaccount.buttonMode = true;
			
			fullscreen.addEventListener(MouseEvent.ROLL_OVER, buttonRollOver);
			history.addEventListener(MouseEvent.ROLL_OVER, buttonRollOver);
			help.addEventListener(MouseEvent.ROLL_OVER, buttonRollOver);
			sound.addEventListener(MouseEvent.ROLL_OVER, buttonRollOver);
			
			fullscreen.addEventListener(MouseEvent.ROLL_OUT, buttonRollOut);
			history.addEventListener(MouseEvent.ROLL_OUT, buttonRollOut);
			help.addEventListener(MouseEvent.ROLL_OUT, buttonRollOut);
			sound.addEventListener(MouseEvent.ROLL_OUT, buttonRollOut);
			
			fullscreen.addEventListener(MouseEvent.CLICK, buttonClick);
			sound.addEventListener(MouseEvent.CLICK, buttonClick);
			help.addEventListener(MouseEvent.CLICK, buttonClick);
			history.addEventListener(MouseEvent.CLICK, buttonClick);
			
			myaccount.addEventListener(MouseEvent.CLICK, myAccountClick);
			lobby.addEventListener(MouseEvent.CLICK, buttonClick);
			myAccountEnabled(false);
			
			

			
			
			chat.visible=false;
			settings.visible=false;
			history.visible=false;
			help.visible=false;
			favouritesBtn.enabled=false;
			favouritesBtn.skin.visible=false;
			confirmBtn.skin.visible=false;
		}
		public function myAccountEnabled(val:Boolean):void{
			myaccount.mouseEnabled=val;
			myaccount.buttonMode=val;
			myaccount.visible=val;
		}
		
		public function init():void {
			game = "--";
			//enableChips();
			align();
			disbleUndo();
			disbleClear();
			disbleRepeat();
			disbleDouble();
			disbleConfirm();
			disbleFavourites();
			addTooltip();
			visible = true;
		}
		
		public function align():void {			
			bg.width = stage.stageWidth;
			x = 0;
			//y = stage.stageHeight - height;
			y=523;
		}
		
		private function addTooltip():void {
			_toolTip = new Tooltip();
			addChild(_toolTip);
		}
		
		public function get clearButton():SMButton{
			return clearBtn;
		}
		public function get undoButton():SMButton{
			return undoBtn;
		}
		
		public function get repeatButton():SMButton{
			return repeatBtn;
		}
		
		public function get doubleButton():SMButton{
			return doubleBtn;
		}
		public function get confirmButton():SMButton{
			return confirmBtn;
		}
		
		public function get favouritesButton():SMButton{
			return favouritesBtn;
		}
		
		public function showTooltip(target:Object, txt:String):void {
			_toolTip.showTooltip(target, txt);
		}
		
		private function buttonClick(event:MouseEvent):void {
			_toolTip.hideTooltip();
			buttonClickedSignal.dispatch(event.target);
		}
		
		private function buttonRollOver(event:MouseEvent):void {
			
			if (MovieClip(event.target.iconMC).currentFrameLabel==ICON_OFF)
				MovieClip(event.target.iconMC).gotoAndStop(ICON_OFF_OVER);
			else if (MovieClip(event.target.iconMC).currentFrameLabel==ICON_ON)
				MovieClip(event.target.iconMC).gotoAndStop(ICON_ON_OVER);
			
			showDefaultSignal.dispatch(event.target);
		}
		
		private function buttonRollOut(event:MouseEvent):void {
	
				if (MovieClip(event.target.iconMC).currentFrameLabel==ICON_OFF_OVER)
					MovieClip(event.target.iconMC).gotoAndStop(ICON_OFF);
				else if (MovieClip(event.target.iconMC).currentFrameLabel==ICON_ON_OVER)
					MovieClip(event.target.iconMC).gotoAndStop(ICON_ON);
		}
		
		public function get chipSelected():Number {
			return _chipSelected;
		}
		
		public function set chipSelected(value:Number):void {
			_chipSelected = value;
		}
		
		public function set myAccountURL(value:String):void {
			_myAccountURL = value;
		}
		
		public function set balanceLabel(value:String):void {
			balanceMC.title.htmlText = '<b>'+value+'</b>';
		}
		
		public function set balance(value:String):void {
			balanceMC.value.htmlText = '<b>'+value+'</b>';
		}
		
		public function set betLabel(value:String):void {
			betMC.title.htmlText = '<b>'+value+'</b>';
		}
		
		public function set bet(value:String):void {
			betMC.value.htmlText = '<b>'+value+'</b>';
		}
		
		public function set gameLabel(value:String):void {
			gameMC.title.htmlText = '<b>'+value+'</b>';
		}
		
		public function set game(value:String):void {
			gameMC.value.htmlText = '<b>'+value+'</b>';
		}
		
		public function set myaccountLabel(value:String):void {
			myaccount.label.htmlText = '<b>'+value+'</b>';
		}
		
		public function set repeatLabel(value:String):void {
			repeat.label.htmlText = '<b>'+value+'</b>';
		}
		
		public function set doubleLabel(value:String):void {
			double.label.htmlText = '<b>'+value+'</b>';
		}
		
		public function set undoLabel(value:String):void {
			undo.label.htmlText = '<b>'+value+'</b>';
		}
		
		public function set clearLabel(value:String):void {
			clear.label.htmlText = '<b>'+value+'</b>';
		}
		
		public function set lobbyLabel(value:String):void {
			lobby.label.htmlText = '<b>'+value+'</b>';
		}
		
		public function enableUndo():void {
			/*undo.filters = null;
			undo.mouseEnabled = true;
			undo.addEventListener(MouseEvent.CLICK, buttonAction);*/
			undoBtn.enabled=true;
			undoBtn.skin.addEventListener(MouseEvent.CLICK, buttonAction);
		}
		
		public function disbleUndo():void {
			/*undo.filters = [_colorMat];
			undo.mouseEnabled = false;
			undo.removeEventListener(MouseEvent.CLICK, buttonAction);*/
			undoBtn.enabled=false;
			undoBtn.skin.removeEventListener(MouseEvent.CLICK, buttonAction);
		}
		
		public function enableClear():void {
			/*clear.filters = null;
			clear.mouseEnabled = true;
			clear.addEventListener(MouseEvent.CLICK, buttonAction);*/
			clearBtn.enabled=true;
			clearBtn.skin.addEventListener(MouseEvent.CLICK, buttonAction);
		}
		
		public function disbleClear():void {
			/*clear.filters = [_colorMat];
			clear.mouseEnabled = false;
			clear.removeEventListener(MouseEvent.CLICK, buttonAction);*/
			clearBtn.enabled=false;
			clearBtn.skin.removeEventListener(MouseEvent.CLICK, buttonAction);
		}
		
		public function enableRepeat():void {
			/*repeat.filters = null;
			repeat.mouseEnabled = true;
			repeat.addEventListener(MouseEvent.CLICK, buttonAction);*/
			repeatBtn.skin.addEventListener(MouseEvent.CLICK, buttonAction);
			repeatBtn.enabled=true;
		}
		
		public function disbleRepeat():void {
			/*repeat.filters = [_colorMat];
			repeat.mouseEnabled = false;
			repeat.removeEventListener(MouseEvent.CLICK, buttonAction);*/
			repeatBtn.skin.removeEventListener(MouseEvent.CLICK, buttonAction);
			repeatBtn.enabled=false;
		}
		
		public function enableDouble():void {
			/*double.filters = null;
			double.mouseEnabled = true;
			double.addEventListener(MouseEvent.CLICK, buttonAction);*/
			doubleBtn.skin.addEventListener(MouseEvent.CLICK, buttonAction);
			doubleBtn.enabled=true;
			
		}
		
		public function disbleDouble():void {
			/*double.filters = [_colorMat];
			double.mouseEnabled = false;
			double.removeEventListener(MouseEvent.CLICK, buttonAction);*/
			doubleBtn.skin.removeEventListener(MouseEvent.CLICK, buttonAction);
			doubleBtn.enabled=false;
		}
		
		public function enableConfirm():void {
			/*double.filters = null;
			double.mouseEnabled = true;
			double.addEventListener(MouseEvent.CLICK, buttonAction);*/
			confirmBtn.skin.addEventListener(MouseEvent.CLICK, buttonAction);
			confirmBtn.enabled=true;
			
		}
		
		public function disbleConfirm():void {
			/*double.filters = [_colorMat];
			double.mouseEnabled = false;
			double.removeEventListener(MouseEvent.CLICK, buttonAction);*/
			confirmBtn.skin.removeEventListener(MouseEvent.CLICK, buttonAction);
			confirmBtn.enabled=false;
		}
		
		
		
		public function enableFavourites():void {
			/*double.filters = null;
			double.mouseEnabled = true;
			double.addEventListener(MouseEvent.CLICK, buttonAction);*/
			favouritesBtn.skin.addEventListener(MouseEvent.CLICK, buttonAction);
			favouritesBtn.enabled=true;
			
		}
		
		public function disbleFavourites():void {
			/*double.filters = [_colorMat];
			double.mouseEnabled = false;
			double.removeEventListener(MouseEvent.CLICK, buttonAction);*/
			favouritesBtn.skin.removeEventListener(MouseEvent.CLICK, buttonAction);
			favouritesBtn.enabled=false;
		}
		
		
		
		public function set soundButtonON_OFF(val:int):void {
			if(val == 0)
				sound.iconMC.gotoAndStop(ICON_OFF);
			else 
				sound.iconMC.gotoAndStop(ICON_ON);
		}
		
		
		public function get menuItem():TaskbarMenu {
			if(_menuItems == null) {
				_menuItems = new TaskbarMenu();
				_menuItems.clickSignal.add(menuItemClicked);
				addChild(_menuItems);
			}
			return _menuItems;
		}
		
		private function myAccountClick(event:MouseEvent = null):void {
			if(_menuItems != null) {
				_menuItems.visible = !_menuItems.visible;
				_menuItems.x = myaccount.x;
				_menuItems.y = myaccount.y - (_menuItems.height + myaccount.height);
			} else menuitemClickedSignal.dispatch(_myAccountURL);

		}
		
		private function menuItemClicked(url:String):void {
			menuitemClickedSignal.dispatch(url);
		}
		

		private function buttonAction(event:MouseEvent):void {
			var targetName:String=String(event.target.name).toLowerCase();
			switch(targetName) {
				case "undo":
					//dispatchEvent(new BetEvent(BetEvent.UNDO));
					undoSignal.dispatch(BetEvent.UNDO);
					break;
				case "clear":
					clearClickedSignal.dispatch(BetEvent.CLEAR);
					break;
				case "repeat":
					repeatClickedSignal.dispatch(BetEvent.REPEAT);
					break;
				case "double":
					doubleClickedSignal.dispatch(BetEvent.DOUBLE);
					break;			
				case "confirm":
					confirmClickedSignal.dispatch(BetEvent.CONFRIM);
					break;	
				case "favourites":
					favouritesClickedSignal.dispatch(BetEvent.FAVOURITES);
					break;	
			}
		}
		
		public function enableChips():void {
			var chipClip:MovieClip;
			for (var i:int = 0; i < CHIPS_COUNT; i++) {
				if (_chips[i]!=0)
				{
				chipClip = chipsMC["chip" + i] as MovieClip;
				chipClip.gotoAndStop(1);
				chipClip.buttonMode = true;
				chipClip.mouseChildren = false;
				chipClip.addEventListener(MouseEvent.CLICK, chipClicked);
				chipClip.alpha = 1;
				}
			}
			//chipsMC.visible = false;
		}
		
		public function disbleChips():void {
			var chipClip:MovieClip;
			for (var i:int = 0; i < CHIPS_COUNT; i++) {
				chipClip = chipsMC["chip" + i] as MovieClip;
				chipClip.gotoAndStop(1);
				chipClip.buttonMode = false;
				chipClip.mouseChildren = false;
				chipClip.removeEventListener(MouseEvent.CLICK, chipClicked);
				chipClip.alpha = 0.68;
			}
			//chipsMC.visible = false;
		}
		
		public function get chips():Array {
			return _chips;
		}
		
		public function set chips(value:Array):void {
			_chips = value;
			var chip:MovieClip;
			for (var i:int = 0; i < value.length; i++) {
				chip = chipsMC["chip" + i] as MovieClip;
				chip.base.color.stop();
				chip.value.text = FormatUtils.formatChipStackText(value[i]);
				chip.value.setTextFormat(getTextFormat(11));
				if (_chips[i]!=0)
				GameUtils.adjustFilter(chip.base.color, value[i]);
				else
				chip.alpha = 0.68;
				//chip.base.color.gotoAndStop("c" + value[i]);
				chip.selected.visible = false;
		
			}
			chipsMC.visible = true;
			switchSelectedChip(chipsMC.chip0);
		}
		
		private function chipClicked(event:MouseEvent):void	{
			var chip:MovieClip = event.target as MovieClip;
			switchSelectedChip(chip);
			chipClickedSignal.dispatch();
		}
		
		private function switchSelectedChip(target:MovieClip):void {
			var chipClip:MovieClip;
			for (var i:int = 0; i < CHIPS_COUNT; i++) {
				chipClip = chipsMC["chip" + i] as MovieClip;
				chipClip.selected.visible = false;
			}
			target.selected.visible = true;
			_chipSelected = chips[target.name.substring(target.name.length - 1, target.name.length)];
		}
		
		private function getTextFormat(textSize:int):TextFormat {
			var format:TextFormat = new TextFormat("Arial", textSize, 0x000000, true);
			return format;
		}
		
		private function debug(... args):void
		{
			GameUtils.log(this, args);
		}
	}
}