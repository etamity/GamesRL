package com.newco.grand.core.common.components.scorecard {
	
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.core.utils.StringUtils;
	import com.newco.grand.core.common.components.scorecard.display.IScoreCardsDisplay;
	import com.newco.grand.core.common.components.scorecard.display.ScoreCardsDisplay;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class ScoreCard extends MovieClip implements IScoreCard {
		private var xmlLoader:URLLoader = new URLLoader();
		protected var _scoreCardsDisplay:IScoreCardsDisplay;
		protected var _resultsURL:String = "testing/bigroad.xml";
		
		protected var _loadResultsFlag:Boolean;
		
		protected var _tableID:String;
		
		protected var _txtClr:uint;
		
		protected var _initialized:Boolean = false;
		
		public function ScoreCard() {
			//_xmlLoader = new XMLLoader();
			//init(242, 85, true, false, "46fgsa1ajaxg735q", 0x000000);
			//onResultsXMLComplete();
		}
		
		protected function onResultsXMLComplete(e:Event):void
		{
			XML.ignoreWhitespace = true;
			//<result id="10" score="8">banker</result>
			var xml:XML = new XML(e.target.data);
			var results:XMLList = xml.result;			
			trace("BIGROAD RESPONSE: " + results);
			_initialized = true;
			_scoreCardsDisplay.clear();
			for(var i:uint = 0; i < results.length(); i++)
			{
				var type:String = results[i];
				var score:uint = uint( results[i].@score );
				_scoreCardsDisplay.newResult(type, score, _txtClr);
			}			
		}
		public function generateScorecard(results:XMLList):void {
			if (_initialized) {
				debug("BIGROAD UPDATE: " + results[0].text() + " " + uint(results[0].@score));
				updateResults(results[0].text(), uint(results[0].@score));
			}
			else {
				debug("BIGROAD INIT: " + results);
				_initialized = true;
				_scoreCardsDisplay.clear();
				for(var i:int = results.length() - 1; i >= 0; i--) {
					debug("BIGROAD >>>> " + results[i] + "  " + i);
					var type:String = results[i];
					var score:uint = uint( results[i].@score );
					_scoreCardsDisplay.newResult(type, score, _txtClr);
				}
			}
		}
		
		public function updateLanguage():void{
			_scoreCardsDisplay.updateLanguage();
		}
		public function updateResults(type:String, score:uint):void {
			_scoreCardsDisplay.newResult(type, score, _txtClr);
		}
		
		/**
		 * Intialises and displays the component, including the loading of XML.
		 * 
		 * <p>The loadURLXML Boolean determins whether or not the XML containing 
		 * the correct URLs for the server calls is loaded.Note that if this isn't 
		 * loaded, the paths may be set through the model property of this class. 
		 * If you ask the URL XML to be loaded, and loading fails, this component 
		 * will fail to initialise.</p>
		 * 
		 * @param loadURLXML Indicates whether to load the XML containing the 
		 * appropriate URLs
		 * @param width The desired width of the roads
		 * @param height The desired height of the roads
		 * @param showTabs Boolean indicating whether the tab menu is used,
		 * allowing the user to select which road is shown. showAllRoadsAtOnce
		 * must be false if showTabs is true in order for the tab menu to appear
		 * @param showAllRoadsAtOnce A Boolean indicating whether all roads are
		 * shown at once.
		 */
		public function init(width:Number = 200, height:Number = 200, showTabs:Boolean = true, showAllRoadsAtOnce:Boolean = false, tableId:String = "", txtClr:uint = 0xFFFFFF, url:String = ""):void {
			_tableID = tableId;
			_txtClr = txtClr;
			_scoreCardsDisplay = new ScoreCardsDisplay(addChild(new MovieClip()) as MovieClip);
			_scoreCardsDisplay.init(width, height, showTabs, showAllRoadsAtOnce);			
		
			if (url != "") {
				_resultsURL = StringUtils.replace(url, "#TABLE_ID#", _tableID);
				_resultsURL = StringUtils.replace(_resultsURL, "#RAN_NO#", "" + Math.random() + Math.random());
				debug("BIGROAD PARAMS NEW: " + width + " " + height + " " + showTabs + " " + showAllRoadsAtOnce + " " + tableId + " " + txtClr + " " + _resultsURL);
				
				loadResults();
			}
			else {
				_scoreCardsDisplay.visible = true;
			}
		}
		
		/**
		 * Initiates a call to the server to get the latest batch of results
		 */
		public function loadResults():void {
			//This statement is just in case the init() function is called and then followed
			//by a call to loadResults(). Obviously if the URL XML is still loading, it will
			//not be possible to load the results as the URL from which to get them is not
			//yet known. This IF statement checks the xmlLoader isn't busy, and if it is
			//a flag is set to call loadResults afterwards
			/*if(!_xmlLoader.isLoading) {
				_xmlLoader.loadXML(_resultsURL);
				_xmlLoader.addEventListener(XMLLoaderEvent.COMPLETE, onResultsXMLComplete)
				Debug.log("LOADING BIGROAD: " + _resultsURL);
			}*/
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, onResultsXMLComplete);
			xmlLoader.load(new URLRequest(_resultsURL));
		}
		
		/**
		 * Returns the IScoreCardsDisplay component, which can then be hooked up
		 * to the tester.
		 */
		public function get scoreCardsDisplay():IScoreCardsDisplay{ return _scoreCardsDisplay; }
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}