package com.slc.games.help.views {

	import com.slc.events.GeneralButtonEvent;
	import com.slc.events.ViewEvent;
	import com.slc.games.help.controller.IHelpController;
	import com.slc.games.help.events.ContentsEvent;
	import com.slc.games.help.events.HelpControllerEvent;
	import com.slc.games.help.model.HelpModel;
	import com.slc.games.help.views.components.contents.Contents;
	import com.slc.games.help.views.components.helppage.HelpPage;
	import com.slc.ui.Language;
	import com.slc.ui.Style;
	import com.slc.ui.buttons.GeneralButton;
	import com.slc.ui.buttons.IGeneralButton;
	import com.slc.ui.text.IText;
	import com.slc.ui.text.Text;
	import com.slc.ui.views.BaseView;
	import com.slc.ui.views.IBaseView;
	import com.slc.ui.views.components.IBaseComponentView;
	import com.slc.utilities.StyleUtils;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.text.TextField;

	public class HelpView extends BaseView {
		protected var _model:HelpModel;
		protected var _controller:IHelpController;

		//Sub-views
		protected var _loading:IBaseView;
		protected var _contents:IBaseComponentView;
		protected var _helpPage:HelpPage;

		protected var _title:IText;
		protected var _headerFill:Sprite;
		protected var _backgroundFill:Sprite;

		public var _close:IGeneralButton;
		//protected var _headerButton:IGeneralButton;

		//The index of the help page that is either being
		//displayed or being loaded
		protected var _helpPageIndex:uint;

		public function HelpView(target:Sprite, model:HelpModel, controller:IHelpController) {
			super(target);

			_model = model;
			_controller = controller;
		}

		protected function onXMLComplete(e:HelpControllerEvent):void {
			_title.htmlText = (_model.helpTitle != null && _model.helpTitle != "") ? Language.getInstance().getProperty("helptitle").toUpperCase() + " - " + _model.helpTitle.toUpperCase() : Language.getInstance().getProperty("helptitle").toUpperCase();

			_contents.parseXML(_model.helpXML);
			_contents.visible = true;

			_helpPage.visible = true;
			loadHelpPage(0);

			_loading.visible = false;
		}

		protected function onHelpPageComplete(e:HelpControllerEvent):void {
			loadHelpPage(_helpPageIndex);
		}

		protected function onCloseClick(e:GeneralButtonEvent):void {
			dispatchEvent(new ViewEvent(ViewEvent.CLOSE_CLICK));
		}

		protected function onHeaderMouseDown(e:GeneralButtonEvent):void {
			//Sprite(_target.parent).startDrag(false, new Rectangle(0, -375, 250, -260));
		}

		protected function onHeaderMouseUp(e:GeneralButtonEvent):void {
			//Sprite(_target.parent).stopDrag();
		}

		protected function onContentsItemClick(e:ContentsEvent):void {
			loadHelpPage(e.index);
		}

		protected function loadHelpPage(index:uint):void {
			_helpPageIndex = index;
			if (_model.helpPages[index]) {
				_helpPage.htmlText = "<font color='#" + Style.getInstance().getProperty("helpTxtColor") + "'>" + _model.helpPages[index] + "</font>";
			}
			else {
				_controller.loadHelpPage(index);
			}
		}

		/**
		 * Initialises the sub views and styles the main elements,
		 * then proceeds to load the XML immediately.
		 */
		public function init():void {
			//Title text
			_title = new Text(_target.getChildByName("title") as TextField);
			_title.style = "helpTitleTxt";

			//Fill colour(s) behind the title text
			_headerFill = _target.getChildByName("headerFill") as Sprite;
			StyleUtils.createGradient(_headerFill, Style.getInstance().getPropertyAsColor("helpHeaderBg1"), Style.getInstance().getPropertyAsColor("helpHeaderBg2"), 540, 25);

			//Fill colour(s) used as the background for the component
			_backgroundFill = _target.getChildByName("backgroundFill") as Sprite;
			StyleUtils.createGradient(_backgroundFill, Style.getInstance().getPropertyAsColor("helpBgColor1"), Style.getInstance().getPropertyAsColor("helpBgColor2"), 550, 360);

			//Header drag button
			var m:MovieClip = new MovieClip();
			m.graphics.beginFill(0, 0);
			m.graphics.drawRoundRect(_headerFill.x, _headerFill.y, _headerFill.width, _headerFill.height, 5, 5);
			_target.addChild(m);
			//_headerButton = new GeneralButton(m, 1);
			//_headerButton.addEventListener(GeneralButtonEvent.MOUSE_DOWN, onHeaderMouseDown);
			//_headerButton.addEventListener(GeneralButtonEvent.MOUSE_UP, onHeaderMouseUp);

			//Close button
			_close = new GeneralButton(_target.getChildByName("close") as MovieClip, 0);
			_target.addChild(_close.target); //Puts the close button on top
			_close.addEventListener(GeneralButtonEvent.CLICK, onCloseClick);
			
			var newColorTransform:ColorTransform = _close.target.transform.colorTransform;
			newColorTransform.color = (Style.getInstance().getProperty("closeBtnColor") != null) ? Style.getInstance().getPropertyAsColor("closeBtnColor") : 0xFFFFFF;
			_close.target.transform.colorTransform = newColorTransform;

			//View displayed whilst loading occurs		
			_loading = new BaseView(_target.getChildByName("loading") as Sprite);

			//The contents pane
			_contents = new Contents(_target.getChildByName("contents") as Sprite);
			_contents.addEventListener(ContentsEvent.CONTENTS_ITEM_CLICK, onContentsItemClick);
			_contents.visible = false;

			//The main text area
			_helpPage = new HelpPage(_target.getChildByName("helpPage") as Sprite);
			_helpPage.visible = false;

			//Add a listener to the controller and begin loading immediatelys
			_controller.addEventListener(HelpControllerEvent.XML_COMPLETE, onXMLComplete);
			_controller.addEventListener(HelpControllerEvent.HELP_PAGE_COMPLETE, onHelpPageComplete);
		}
	}
}

