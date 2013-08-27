package com.newco.grand.baccarat.classic.view.scorecard.display {
	
	import com.newco.grand.baccarat.classic.view.scorecard.data.ResultTypes;
	import com.newco.grand.baccarat.classic.view.scorecard.display.road.IRoad;
	import com.newco.grand.baccarat.classic.view.scorecard.display.road.Road;
	import com.newco.grand.baccarat.classic.view.scorecard.display.road.behaviours.AllRoadsAddBehaviour;
	import com.newco.grand.baccarat.classic.view.scorecard.display.road.result.IResult;
	import com.newco.grand.baccarat.classic.view.scorecard.display.tabs.ITabMenu;
	import com.newco.grand.baccarat.classic.view.scorecard.display.tabs.TabMenu;
	import com.newco.grand.core.common.model.Language;
	import com.newco.grand.core.common.view.ui.buttons.GeneralButtonEvent;
	import com.newco.grand.core.common.view.ui.buttons.IGeneralButton;
	import com.newco.grand.core.common.view.ui.views.BaseView;
	import com.newco.grand.core.common.view.ui.views.IBaseView;
	
	import flash.display.MovieClip;
	
	/**
	 * The main display featuring four different Roads. Also includes a tab menu
	 * for switching between them.
	 * 
	 * @author Elliot Harris
	 */
	public class ScoreCardsDisplay extends BaseView implements IScoreCardsDisplay {
		
		protected var _showAllRoadsAtOnce:Boolean;
		protected var _showTabs:Boolean;
		
		protected var _roadWidth:Number;
		protected var _roadHeight:Number;
		
		protected var _bigRoad:IRoad;
		protected var _bigEyeBoyRoad:IRoad;
		protected var _smallRoad:IRoad;
		protected var _cockroachRoad:IRoad;
				
		protected var _roads:Array = new Array();		
		protected var _downRoadsManager:DownRoadsManager;
		
		protected var _tabMenu:ITabMenu;
		 
		public function ScoreCardsDisplay(target:MovieClip) {
			super(target);
		}
		
		/**
		 * Creates the four roads and the DownRoadsManager for controlling
		 * the down roads.
		 */
		protected function buildRoads():void {
			_bigRoad = new Road(_target.addChild(new RoadTarget()) as MovieClip, _roadWidth, _roadHeight);
			_bigRoad.addBehaviour = new AllRoadsAddBehaviour("BigRoadResult");
			_roads.push(_bigRoad);
						
			_bigEyeBoyRoad = new Road(_target.addChild(new RoadTarget()) as MovieClip, _roadWidth, _roadHeight);
			_bigEyeBoyRoad.addBehaviour = new AllRoadsAddBehaviour("BigEyeBoyRoadResult");
			_roads.push(_bigEyeBoyRoad);
			
			_smallRoad = new Road(_target.addChild(new RoadTarget()) as MovieClip, _roadWidth, _roadHeight);
			_smallRoad.addBehaviour = new AllRoadsAddBehaviour("SmallRoadResult");
			_roads.push(_smallRoad);
			
			_cockroachRoad = new Road(_target.addChild(new RoadTarget()) as MovieClip, _roadWidth, _roadHeight);
			_cockroachRoad.addBehaviour = new AllRoadsAddBehaviour("CockroachRoadResult");
			_roads.push(_cockroachRoad);
			
			_downRoadsManager = new DownRoadsManager();
			_downRoadsManager.addDownRoads(_bigEyeBoyRoad, _smallRoad, _cockroachRoad);
		}
		
		/**
		 * Lays out the roads according to whether or not they are all to
		 * be shown at once. If not, they are laid out side-by-side.
		 */
		protected function layoutRoads():void {
			var startX:uint = 2;
			var startY:uint = _tabMenu ? _tabMenu.y + _tabMenu.height + 2 : 2;
			for(var i:uint; i < _roads.length; i++) {
				var r:IRoad = _roads[i];
				if(_showAllRoadsAtOnce) {
					r.x = startX + ((r.width + 5) * i);					
					r.y = startY;
				}
				else {
					r.x = startX;
					r.y = startY;
					if(i > 0) r.visible = false;
				}
			}
		}
		
		protected function buildTabs():void {
			_tabMenu = new TabMenu(_target.addChild(new TabMenuTarget()) as MovieClip);
			_tabMenu.addEventListener(GeneralButtonEvent.CLICK, onTabClick);
			
			var b:Array = _tabMenu.buttons;
			IGeneralButton(b[0]).label = Language.BIGROAD;
			IGeneralButton(b[1]).label = Language.BIGEYEBOYROAD;
			IGeneralButton(b[2]).label = Language.SMALLROAD;
			IGeneralButton(b[3]).label = Language.COCKROACHROAD;
		}
		
		protected function onTabClick(e:GeneralButtonEvent):void {
			hideAllRoads();
			var r:IRoad = _roads[e.id];
			r.visible = true;
		}
		
		protected function hideAllRoads():void {
			for each(var r:IBaseView in _roads) {
				r.visible = false;
			}
		}
		
		/**
		 * Initialises the display.
		 * 
		 * @param width The desired width of the roads
		 * @param height The desired height of the roads
		 * @param showTabs Boolean indicating whether the tab menu is used,
		 * allowing the user to select which road is shown. showAllRoadsAtOnce
		 * must be false if showTabs is true in order for the tab menu to appear
		 * @param showAllRoadsAtOnce A Boolean indicating whether all roads are
		 * shown at once.
		 */
		public function init(width:Number=200, height:Number=200, showTabs:Boolean=true, showAllRoadsAtOnce:Boolean=false):void {
			_roadWidth = width;
			_roadHeight = height;
			_showTabs = showTabs;
			_showAllRoadsAtOnce = showAllRoadsAtOnce;
			
			if(!_showAllRoadsAtOnce && _showTabs) {
				buildTabs();
			}
			buildRoads();
			layoutRoads();
		}
		
		/**
		 * Adds a new result to the display.
		 * 
		 * @param type The type of result, as defined by ResultTypes
		 * @param score An optional score value for the result
		 */
		public function newResult(type:String, score:uint=0, clr:uint=0xFFFFFF):void {
			/*
			 * Save the coordinates of the last big road position
			 * and evaluate the 3x2 grid from this position, one
			 * row further down.
			 * 
			 * No matter if big road starts a new column when the
			 * new result is passed, the down roads 3x2 grid which
			 * affects the down road result is always assumed to
			 * be in the last column. Next time however, if indeed
			 * a new column was started, the last coordinates
			 * retrieved here would reflect that. 
			 */
			var lastXPos:uint = _bigRoad.lastXPos;
			var lastYPos:uint = _bigRoad.lastYPos;
			var lastResult:IResult = _bigRoad.lastResult;
			
			_bigRoad.newResult(type, score, clr);
			
			if(lastResult) {			
				if(type != ResultTypes.TIE) {
					if(type != ResultTypes.CANCELLED) {
						var subset:Array = _bigRoad.getSubset(lastXPos-3, lastYPos, lastXPos, lastYPos+2);
				
						//Send update to down roads via down road manager			
						//Again, the number of columns passed to the downroadsmanager
						//ignores the fact that a new column may have just been added
						_downRoadsManager.applySubset(subset, lastXPos+1, type == lastResult.userType);
					}
				}
			}
		}
		
		public function clear():void {
			for each(var r:IAcceptsResult in _roads) {
				r.clear();
			}
		}
	}
}