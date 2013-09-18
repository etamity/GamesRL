package com.newco.grand.core.common.view {
	
	import com.newco.grand.core.common.controller.signals.BetEvent;
	import com.newco.grand.core.common.controller.signals.TaskbarActionEvent;
	import com.newco.grand.core.common.controller.signals.TooltipEvent;
	import com.newco.grand.core.common.model.LanguageModel;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.view.interfaces.ITaskbarView;
	import com.newco.grand.core.common.view.uicomps.LanguagePanelView;
	import com.newco.grand.core.utils.FormatUtils;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.media.SoundMixer;
	import flash.text.TextFormat;
	
	import caurina.transitions.Tweener;
	
	public class TaskbarView extends UIView implements ITaskbarView {
		
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
		private var lobbyBtn:SMButton;
		/*private var _buttonClickedSignal:Signal= new Signal();
		private var _showDefaultSignal:Signal= new Signal();
		private var _menuitemClickedSignal:Signal= new Signal();
		private var _undoSignal:Signal= new Signal();
		private var _clearClickedSignal:Signal= new Signal();
		private var _repeatClickedSignal:Signal= new Signal();
		private var _doubleClickedSignal:Signal= new Signal();
		private var _confirmClickedSignal:Signal= new Signal();
		private var _favouritesClickedSignal:Signal= new Signal();
		private var _chipClickedSignal:Signal= new Signal();*/
		
		private var _signalBus:SignalBus=new SignalBus();
		
		
		private var buttonsPTs:Array;
		
		private var languagePanel:LanguagePanelView;
		public function TaskbarView() {
			super();
			initSkin();
		}
		
		override public function initDisplay():void{
			_display=new TaskbarAsset();
			addChild( _display);
	
		}
		
		
		protected function initSkin():void{
			_display.sound.iconMC.gotoAndStop(ICON_OFF);
			_display.fullscreen.iconMC.gotoAndStop(ICON_OFF);
			_display.chat.iconMC.gotoAndStop(ICON_OFF);
			_display.help.iconMC.gotoAndStop(ICON_OFF);
			_display.history.iconMC.gotoAndStop(ICON_OFF);
			_display.responsible.iconMC.gotoAndStop(ICON_OFF);
			_display.settings.iconMC.gotoAndStop(ICON_OFF);
			
			_display.sound.buttonMode = true;
			_display.fullscreen.buttonMode = true;
			_display.chat.buttonMode = true;
			_display.help.buttonMode = true;
			_display.history.buttonMode = true;
			_display.responsible.buttonMode = true;
			_display.settings.buttonMode = true;
			
			_display.sound.mouseChildren = false;
			_display.fullscreen.mouseChildren = false;
			_display.chat.mouseChildren = false;
			_display.help.mouseChildren = false;
			_display.history.mouseChildren = false;
			_display.responsible.mouseChildren = false;
			_display.settings.mouseChildren = false;
			
			_display.language.iconMC.gotoAndStop(ICON_OFF);
			_display.language.mouseChildren = false;
			_display.language.buttonMode = true;
			/*settings.visible = false;
			
			help.visible = false;
			history.visible = false;*/
			
			clearBtn = new SMButton( _display.clear);
			undoBtn = new SMButton( _display.undo);
			repeatBtn = new SMButton( _display.repeat);
			doubleBtn = new SMButton( _display.double);
			confirmBtn = new SMButton( _display.confirm);
			favouritesBtn = new SMButton( _display.favourites);
			lobbyBtn =new SMButton( _display.lobby);
			
			_display.responsible.visible = false;
			_display.chat.visible = false;
			_display.chat.mouseEnabled=false;
			_display.settings.mouseEnabled=false;
			// _display.history.mouseEnabled=false;
			_display.help.mouseEnabled=false;
			
			/*clear.mouseChildren = false;
			undo.mouseChildren = false;
			repeat.mouseChildren = false;
			double.mouseChildren = false;*/
			_display.myaccount.mouseChildren = false;
			/*clear.buttonMode = true;
			undo.buttonMode = true;
			repeat.buttonMode = true;
			double.buttonMode = true;
			_display.lobby.mouseChildren = false;
			_display.lobby.buttonMode = true;
			_display.lobby.visible=true;*/
			_display.myaccount.buttonMode = true;
			
			_display.fullscreen.addEventListener(MouseEvent.ROLL_OVER, buttonRollOver);
			_display.history.addEventListener(MouseEvent.ROLL_OVER, buttonRollOver);
			_display.help.addEventListener(MouseEvent.ROLL_OVER, buttonRollOver);
			_display.sound.addEventListener(MouseEvent.ROLL_OVER, buttonRollOver);
			_display.language.addEventListener(MouseEvent.ROLL_OVER, buttonRollOver);
			
			_display.fullscreen.addEventListener(MouseEvent.ROLL_OUT, buttonRollOut);
			_display.history.addEventListener(MouseEvent.ROLL_OUT, buttonRollOut);
			_display.help.addEventListener(MouseEvent.ROLL_OUT, buttonRollOut);
			_display.sound.addEventListener(MouseEvent.ROLL_OUT, buttonRollOut);
			_display.language.addEventListener(MouseEvent.ROLL_OUT, buttonRollOut);
			
			_display.fullscreen.addEventListener(MouseEvent.CLICK, buttonClick);
			_display.sound.addEventListener(MouseEvent.CLICK, buttonClick);
			_display.help.addEventListener(MouseEvent.CLICK, buttonClick);
			_display.history.addEventListener(MouseEvent.CLICK, buttonClick);
			_display.language.addEventListener(MouseEvent.CLICK, buttonClick);
			
			_display.myaccount.addEventListener(MouseEvent.CLICK, myAccountClick);
			lobbyBtn. skin.addEventListener(MouseEvent.CLICK, buttonClick);
			myAccountEnabled(false);
			
			
			
			_display.language
			_display.chat.visible=false;
			_display.settings.visible=false;
			_display.history.visible=true;
			_display.help.visible=false;
			favouritesBtn.enabled=false;
			favouritesBtn. skin.visible=false;
			confirmBtn. skin.visible=false;
			buttonsPTs=[];
			
			
			buttonsPTs.push(new Point(clearBtn. skin.x,clearBtn. skin.y));
			buttonsPTs.push(new Point(undoBtn. skin.x,undoBtn. skin.y));
			buttonsPTs.push(new Point(repeatBtn. skin.x,repeatBtn. skin.y));
			buttonsPTs.push(new Point(doubleBtn. skin.x,doubleBtn. skin.y));
			
			languagePanel=new LanguagePanelView();
			addChild(languagePanel);
			languagePanel.x=_display.language.x -languagePanel.width/2;
			languagePanel.y= _display.language.y -languagePanel.height; 
			languagePanel.visible=false;
			languagePanel.onChange.add(function (btn:SMButton):void{
				_signalBus.dispatch(TaskbarActionEvent.LOAD_LANGUAGE ,{eventType:TaskbarActionEvent.LOAD_LANGUAGE,lang:btn.params.lang});	
				
			});
			
			game = "--";
			//enableChips();
			disbleUndo();
			disbleClear();
			disbleRepeat();
			disbleDouble();
			disbleConfirm();
			disbleFavourites();
			addTooltip();
			
			soundButtonON_OFF=SoundMixer.soundTransform.volume;
		}
		
		
		public function loadLanguages(data:XML,path:String):void{
			languagePanel.path=path;
			languagePanel.load(data);
			languagePanel.y= _display.language.y -languagePanel.height;
		}
		
		
		/*public function get buttonClickedSignal:Signal{
			return _buttonClickedSignal;
		}
		public function get showDefaultSignal:Signal{
			return _showDefaultSignal;
		}
		public function get menuitemClickedSignal:Signal{
			return _menuitemClickedSignal;
		}
		public function get undoSignal:Signal{
			return _undoSignal;
		}
		public function get clearClickedSignal:Signal{
			return _clearClickedSignal;
		}
		public function get repeatClickedSignal:Signal{
			return _clearClickedSignal;
		}
		public function get doubleClickedSignal:Signal{
			return _doubleClickedSignal;
		}
		public function get confirmClickedSignal:Signal{
			return _confirmClickedSignal;
		}
		public function get favouritesClickedSignal:Signal{
			return _favouritesClickedSignal;
		}
		public function get chipClickedSignal:Signal{
			return _chipClickedSignal;
		}*/
		override public function updateLanguage():void{
			balanceLabel=LanguageModel.BALANCE;
			betLabel=LanguageModel.BET;
			gameLabel=LanguageModel.GAMEID;
			myaccountLabel=LanguageModel.MYACCOUNT;
			myaccountLabel="";

			repeatButton.label=LanguageModel.REBET;
			doubleButton.label=LanguageModel.DOUBLEBET;
			undoButton.label=LanguageModel.UNDO;
			clearButton.label=LanguageModel.CLEARALL
			confirmButton.label=LanguageModel.CONFIRM;
			favouritesButton.label=LanguageModel.FAVOURITES
			lobbyLabel=LanguageModel.LOBBY;
		}
		
		
		
		public function myAccountEnabled(val:Boolean):void{
			 _display.myaccount.mouseEnabled=val;
			 _display.myaccount.buttonMode=val;
			 _display.myaccount.visible=val;
		}
		
		override public function align():void {

			// _display.bg.width = stage.stageWidth;
			x = 0;
			//y = stage.stageHeight - height;
			y=550;
		}
		
		private function addTooltip():void {
			_toolTip = new Tooltip();
			addChild(_toolTip);
		}
		public function get signalBus():SignalBus{
			return _signalBus;
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
			var target:MovieClip= event.target as MovieClip;
			
			switch (target){
				case  _display.fullscreen:
					_signalBus.dispatch(TaskbarActionEvent.BUTTON_CLICKED,{eventType:TaskbarActionEvent.FULLSCREEN_CLICKED});
					break;
				case  _display.sound:
					_signalBus.dispatch(TaskbarActionEvent.BUTTON_CLICKED,{eventType:TaskbarActionEvent.SOUND_CLICKED});
					break;
				case  _display.lobby:
					_signalBus.dispatch(TaskbarActionEvent.LOBBY_CLICKED,{eventType:TaskbarActionEvent.LOBBY_CLICKED});
					break;
				case  _display.help:
					_signalBus.dispatch(TaskbarActionEvent.BUTTON_CLICKED,{eventType:TaskbarActionEvent.HELP_CLICKED});
					break;
				case  _display.history:
					_signalBus.dispatch(TaskbarActionEvent.LOBBY_CLICKED,{eventType:TaskbarActionEvent.HISTORY_CLICKED});	
					break;
				case  _display.language:
					languagePanel.visible=!languagePanel.visible;
					break;
			}
			
			//_buttonClickedSignal.dispatch(event.target);
	
			soundButtonON_OFF=SoundMixer.soundTransform.volume;
		}
		
		private function buttonRollOver(event:MouseEvent):void {
			
			if (MovieClip(event.target.iconMC).currentFrameLabel==ICON_OFF)
				MovieClip(event.target.iconMC).gotoAndStop(ICON_OFF_OVER);
			else if (MovieClip(event.target.iconMC).currentFrameLabel==ICON_ON)
				MovieClip(event.target.iconMC).gotoAndStop(ICON_ON_OVER);
			
			//_showDefaultSignal.dispatch(event.target);
			_signalBus.dispatch(TooltipEvent.SHOW_DEFAULT,{target:event.target});
		}
		public function createMenuItem(label:String, url:String):void{
			menuItem.createMenuItem(label,url);
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
			 _display.balanceMC.title.htmlText = '<b>'+value+'</b>';
			 _display.balanceCenterMC.title.htmlText = '<b>'+value+'</b>';
			
		}
		
		public function set balance(value:String):void {
			 _display.balanceMC.value.htmlText = '<b>'+value+'</b>';
			 _display.balanceCenterMC.value.htmlText = '<b>'+value+'</b>';
		}
		
		public function set betLabel(value:String):void {
			 _display.betMC.title.htmlText = '<b>'+value+'</b>';
		}
		
		public function set bet(value:String):void {
			 _display.betMC.value.htmlText = '<b>'+value+'</b>';
		}
		
		public function set gameLabel(value:String):void {
			 _display.gameMC.title.htmlText = '<b>'+value+'</b>';
		}
		
		public function set game(value:String):void {
			 _display.gameMC.value.htmlText = '<b>'+value+'</b>';
		}
		
		public function set myaccountLabel(value:String):void {
			 _display.myaccount.label.htmlText = '<b>'+value+'</b>';
		}
		
		public function set repeatLabel(value:String):void {
			// _display.repeat.label.htmlText = '<b>'+value+'</b>';
		}
		
		public function set doubleLabel(value:String):void {
			// _display.double.label.htmlText = '<b>'+value+'</b>';
		}
		
		public function set undoLabel(value:String):void {
			// _display.undo.label.htmlText = '<b>'+value+'</b>';
		}
		
		public function set clearLabel(value:String):void {
			// _display.clear.label.htmlText = '<b>'+value+'</b>';
		}
		
		public function set lobbyLabel(value:String):void {
			// _display.lobby.label.htmlText = '<b>'+value+'</b>';
		}
		
		public function enableUndo():void {
			/*undo.filters = null;
			undo.mouseEnabled = true;
			undo.addEventListener(MouseEvent.CLICK, buttonAction);*/
			undoBtn.enabled=true;
			undoBtn. skin.addEventListener(MouseEvent.CLICK, buttonAction);
		}
		
		public function disbleUndo():void {
			/*undo.filters = [_colorMat];
			undo.mouseEnabled = false;
			undo.removeEventListener(MouseEvent.CLICK, buttonAction);*/
			undoBtn.enabled=false;
			undoBtn. skin.removeEventListener(MouseEvent.CLICK, buttonAction);
			
		}
		
		
		public function slideUpButtons():void{
			Tweener.addTween(clearBtn. skin,{y:buttonsPTs[0].y, time:0.5});
			Tweener.addTween(undoBtn. skin,{y:buttonsPTs[1].y, time:0.5});
			Tweener.addTween(repeatBtn. skin,{y:buttonsPTs[2].y, time:0.5});
			Tweener.addTween(doubleBtn. skin,{y:buttonsPTs[3].y, time:0.5});
		}
		public function slideDownButtons():void{
			Tweener.addTween(undoBtn. skin,{y:100, time:0.5});
			Tweener.addTween(repeatBtn. skin,{y:100, time:0.5});
			Tweener.addTween(clearBtn. skin,{y:100, time:0.5});
			Tweener.addTween(doubleBtn. skin,{y:100, time:0.5});
		}
		public function enableClear():void {
			/*clear.filters = null;
			clear.mouseEnabled = true;
			clear.addEventListener(MouseEvent.CLICK, buttonAction);*/
			clearBtn.enabled=true;
			clearBtn. skin.addEventListener(MouseEvent.CLICK, buttonAction);

			
		}
		
		public function disbleClear():void {
			/*clear.filters = [_colorMat];
			clear.mouseEnabled = false;
			clear.removeEventListener(MouseEvent.CLICK, buttonAction);*/
			clearBtn.enabled=false;
			clearBtn. skin.removeEventListener(MouseEvent.CLICK, buttonAction);
		}
		
		public function enableRepeat():void {
			/*repeat.filters = null;
			repeat.mouseEnabled = true;
			repeat.addEventListener(MouseEvent.CLICK, buttonAction);*/
			repeatBtn. skin.addEventListener(MouseEvent.CLICK, buttonAction);
			repeatBtn.enabled=true;
			
		
		}
		
		public function disbleRepeat():void {
			/*repeat.filters = [_colorMat];
			repeat.mouseEnabled = false;
			repeat.removeEventListener(MouseEvent.CLICK, buttonAction);*/
			repeatBtn. skin.removeEventListener(MouseEvent.CLICK, buttonAction);
			repeatBtn.enabled=false;
	
		}
		
		public function enableDouble():void {
			/*double.filters = null;
			double.mouseEnabled = true;
			double.addEventListener(MouseEvent.CLICK, buttonAction);*/
			doubleBtn. skin.addEventListener(MouseEvent.CLICK, buttonAction);
			doubleBtn.enabled=true;
			
		}
		
		public function disbleDouble():void {
			/*double.filters = [_colorMat];
			double.mouseEnabled = false;
			double.removeEventListener(MouseEvent.CLICK, buttonAction);*/
			doubleBtn. skin.removeEventListener(MouseEvent.CLICK, buttonAction);
			doubleBtn.enabled=false;
		}
		
		public function enableConfirm():void {
			/*double.filters = null;
			double.mouseEnabled = true;
			double.addEventListener(MouseEvent.CLICK, buttonAction);*/
			confirmBtn. skin.addEventListener(MouseEvent.CLICK, buttonAction);
			confirmBtn.enabled=true;
			
		}
		
		public function disbleConfirm():void {
			/*double.filters = [_colorMat];
			double.mouseEnabled = false;
			double.removeEventListener(MouseEvent.CLICK, buttonAction);*/
			confirmBtn. skin.removeEventListener(MouseEvent.CLICK, buttonAction);
			confirmBtn.enabled=false;
		}
		
		
		
		public function enableFavourites():void {
			/*double.filters = null;
			double.mouseEnabled = true;
			double.addEventListener(MouseEvent.CLICK, buttonAction);*/
			favouritesBtn. skin.addEventListener(MouseEvent.CLICK, buttonAction);
			favouritesBtn.enabled=true;
			
		}
		
		public function disbleFavourites():void {
			/*double.filters = [_colorMat];
			double.mouseEnabled = false;
			double.removeEventListener(MouseEvent.CLICK, buttonAction);*/
			favouritesBtn. skin.removeEventListener(MouseEvent.CLICK, buttonAction);
			favouritesBtn.enabled=false;
		}
		public function disableButtons():void{
			disbleUndo();
			disbleClear();
			disbleRepeat();
			disbleDouble();
			disbleChips();
			disbleFavourites();
			disbleConfirm();
		}

		
		public function set soundButtonON_OFF(val:int):void {
			if(val == 0)
				 _display.sound.iconMC.gotoAndStop(ICON_OFF);
			else 
				 _display.sound.iconMC.gotoAndStop(ICON_ON);
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
				_menuItems.x =  _display.myaccount.x;
				_menuItems.y =  _display.myaccount.y - (_menuItems.height +  _display.myaccount.height);
			} else {
				_signalBus.dispatch(TaskbarActionEvent.MENUITEM_CLICKED,{url:_myAccountURL});
				//_menuitemClickedSignal.dispatch(_myAccountURL);
			
			}

		}
		
		private function menuItemClicked(url:String):void {
			//_menuitemClickedSignal.dispatch(url);
			_signalBus.dispatch(TaskbarActionEvent.MENUITEM_CLICKED,{url:_myAccountURL});
		}
		

		private function buttonAction(event:MouseEvent):void {
			var targetName:String=String(event.target.name).toLowerCase();
			switch(targetName) {
				case "undo":
					//dispatchEvent(new BetEvent(BetEvent.UNDO));
					//_undoSignal.dispatch(BetEvent.UNDO);
					_signalBus.dispatch(BetEvent.UNDO,{target:event.target});
					break;
				case "clear":
					//_clearClickedSignal.dispatch(BetEvent.CLEAR);
					_signalBus.dispatch(BetEvent.CLEAR,{target:event.target});
					break;
				case "repeat":
					//_repeatClickedSignal.dispatch(BetEvent.REPEAT);
					_signalBus.dispatch(BetEvent.REPEAT,{target:event.target});
					break;
				case "double":
					//_doubleClickedSignal.dispatch(BetEvent.DOUBLE);
					_signalBus.dispatch(BetEvent.DOUBLE,{target:event.target});
					break;			
				case "confirm":
					//_confirmClickedSignal.dispatch(BetEvent.CONFRIM);
					_signalBus.dispatch(BetEvent.CONFRIM,{target:event.target});
					break;	
				case "favourites":
					//_favouritesClickedSignal.dispatch(BetEvent.FAVOURITES);
					_signalBus.dispatch(BetEvent.FAVOURITES,{target:event.target});
					break;	
			}
		}
		
		public function enableChips():void {
			var chipClip:MovieClip;
			for (var i:int = 0; i < CHIPS_COUNT; i++) {
				if (_chips[i]!=0)
				{
				chipClip =  _display.chipsMC["chip" + i] as MovieClip;
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
				chipClip =  _display.chipsMC["chip" + i] as MovieClip;
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
				chip =  _display.chipsMC["chip" + i] as MovieClip;
				chip.base.color.stop();
				chip.value.text = FormatUtils.formatChipStackText(value[i]);
				//chip.value.setTextFormat(getTextFormat(11));
				if (_chips[i]!=0)
				GameUtils.adjustFilter(chip.base.color, value[i]);
				else
				chip.alpha = 0.68;
				//chip.base.color.gotoAndStop("c" + value[i]);
				chip.selected.visible = false;
		
			}
			 _display.chipsMC.visible = true;
			switchSelectedChip( _display.chipsMC.chip0);
		}
		
		private function chipClicked(event:MouseEvent):void	{
			var chip:MovieClip = event.target as MovieClip;
			switchSelectedChip(chip);
			//_chipClickedSignal.dispatch();
			_signalBus.dispatch(TaskbarActionEvent.CHIP_CLICKED,{target:event.target});
		}
		
		private function switchSelectedChip(target:MovieClip):void {
			var chipClip:MovieClip;
			for (var i:int = 0; i < CHIPS_COUNT; i++) {
				chipClip =  _display.chipsMC["chip" + i] as MovieClip;
				chipClip.selected.visible = false;
			}
			target.selected.visible = true;
			_chipSelected = chips[target.name.substring(target.name.length - 1, target.name.length)];
		}
		
		private function getTextFormat(textSize:int):TextFormat {
			var format:TextFormat = new TextFormat("Arial", textSize, 0xFFFFFF, true);
			return format;
		}
	}
}