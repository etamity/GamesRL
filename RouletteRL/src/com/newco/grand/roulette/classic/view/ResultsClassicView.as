package com.newco.grand.roulette.classic.view {
	
	import flash.display.MovieClip;
	
	public class ResultsClassicView extends LastTenNumberAsset {
		
		private const RESULT_COLOR_RED:uint = 0xFF0000;
		private const RESULT_COLOR_BLACK:uint = 0xFFAF32;
		private const RESULT_COLOR_GREEN:uint = 0x00FF00;
		private const RESULT_COLOR_CANCEL:uint = 0xFFFFFF;
		
		private var _xml:XMLList;
		private var _results:Array = new Array();
		private var _historyLoaded:Boolean = false;
		
		public function ResultsClassicView() {
			visible = false;
		}		
		
		public function init():void {
		/*	for (var i:uint = 0; i < 15; i++) {
				var row:TextField = new TextField();
				row.name = "row" + i;
				row.selectable = false;
				row.x = 0;
				row.y = 5;
				row.height = 16;
				row.width = 22;
				addChild(row);
			}*/
			align();
		}
		
		public function align():void {
			x = 655;
			y = 236;
			visible = true;
		}

		public function get xml():XMLList {
			return _xml;
		}

		public function set xml(value:XMLList):void {
			_xml = value;
			processHistory();
		}
		
		private function processHistory():void {
			var i:uint = 0;
			var result:Object;
			
			for each (var item:XML in xml.result) {
				result = new Object();
				result.id = item.@id;
				result.value = (Number(item) >= 0) ? item : -1;
				_results.push(result);
			
				i++;
			}
			_historyLoaded = true;
			showHistory();
		}
		
		private function showHistory():void {
			for (var i:uint =0; i < _results.length; i++) {
				var row:MovieClip = MovieClip(getChildByName("LastBetMc" + (9-i)));
				//var rowFormat:TextFormat;
				
				row.NumberMc.gotoAndStop(int(_results[i].value)+1);
				//trace("[Result]: "+ String(int(_results[i].value)+1));
				/*switch (GameUtils.findRouletteBetspotColor(_results[i].value)) {
					case "RED":
						row.NumberMc.gotoAndStop(int(_results[i].value));
						rowFormat = new TextFormat("Arial", 12, RESULT_COLOR_RED, true);
						break;
					case "BLACK":
						row.NumberMc.gotoAndStop(int(_results[i].value));
						rowFormat = new TextFormat("Arial", 12, RESULT_COLOR_BLACK, true);
						break;
					case "GREEN":
						row.NumberMc.gotoAndStop(int(_results[i].value));
						rowFormat = new TextFormat("Arial", 12, RESULT_COLOR_GREEN, true);
						break;
					case "C":
						row.text = "X";
						rowFormat = new TextFormat("Arial", 12, RESULT_COLOR_CANCEL, true);
						break;
				}*/
				//rowFormat.align = TextAlign.CENTER;
				//row.setTextFormat(rowFormat);
				//row.x = i * row.width;		
			}
		}
		
		private function checkForDuplicates(id:String):Boolean {
			for (var i:uint = 0; i < _results.length; i++) {
				if (_results[i].id == id) {
					return true;
				}
			}
			return false;
		}
		
		public function addResult(item:XML):void {
			if (_historyLoaded && !checkForDuplicates(item.@id)) {
				var result:Object = new Object();
				result.id = item.@id;
				result.value = (parseInt(item) >= 0) ? parseFloat(item) : -1;			
				_results.pop();
				_results.unshift(result);
				showHistory();
			}

		}
		
		public function addCancel():void {
			var result:Object = new Object();
			result.id = "";
			result.value = -1;			
			_results.pop();
			_results.unshift(result);
			showHistory();
		}
	}
}