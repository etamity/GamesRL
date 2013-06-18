package com.newco.grand.roulette.classic.view {
	import com.newco.grand.core.utils.StringUtils;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	public class StatisticsView extends StatisticsAsset {

		private var _stats:XML;
		private var redResult:int;
		private var blackResult:int;
		private var zeroResult:int;
		private var oddResult:int;
		private var evenResult:int;
		private var lowResult:int;
		private var highResult:int;
		
		private var objectList:Array=new Array();
		
		
		public function StatisticsView() {
			visible = false;
		}		
		
		public function init():void {			
			align();
			redPrgress.addEventListener(Event.ENTER_FRAME,checkFrameEvent);
			blackPrgress.addEventListener(Event.ENTER_FRAME,checkFrameEvent);
			zeroPrgress.addEventListener(Event.ENTER_FRAME,checkFrameEvent);
			evenPrgress.addEventListener(Event.ENTER_FRAME,checkFrameEvent);
			oddPrgress.addEventListener(Event.ENTER_FRAME,checkFrameEvent);
			highPrgress.addEventListener(Event.ENTER_FRAME,checkFrameEvent);
			lowPrgress.addEventListener(Event.ENTER_FRAME,checkFrameEvent);
		}
		private function checkFrameEvent(evt:Event):void{
			var target:MovieClip= evt.currentTarget as MovieClip;
			switch (target.name){
				case "redPrgress":
					if (target.currentFrame == redResult)
						target.stop();
					break;
				case "blackPrgress":
					if (target.currentFrame == blackResult)
						target.stop();
					break;
				case "zeroPrgress":
					if (target.currentFrame == zeroResult)
						target.stop();
					break;
				case "evenPrgress":
					if (target.currentFrame == evenResult)
						target.stop();
					break;
				case "oddPrgress":
					if (target.currentFrame == oddResult)
						target.stop();
					break;
				case "highPrgress":
					if (target.currentFrame == highResult)
						target.stop();
					break;
				case "lowPrgress":
					if (target.currentFrame == lowResult)
						target.stop();
					break;
			}
		}
		
		public function align():void {
			visible = true;
		}
		
		public function get stats():XML {
			return _stats;
		}
		
		public function loadFromXML(data:XML):void{
			var urlsXML:XMLList = data.number;
			objectList=new Array();

			for (var i:int=0;i<urlsXML.length();i++)
			{
				
				var obj:Object=new Object();
				obj.id=urlsXML[i].@id;
				obj.wins=urlsXML[i].@wins;
				obj.bets=urlsXML[i].@bets;
				obj.results=urlsXML[i].@results;
				objectList.push(obj);
				
				var str:String ="[Statistic Data]: id=#ID# wins=#WINS# bets=#BETS# results=#RESULTS#";
				str= StringUtils.replace(str,"#ID#",obj.id);
				str= StringUtils.replace(str,"#WINS#",obj.wins);
				str= StringUtils.replace(str,"#BETS#",obj.bets);
				str= StringUtils.replace(str,"#RESULTS#",obj.results);
				
			}
			refresh();
		}
		
		private function getTotalBets():int{
			var result:int=0;
			for (var i:int=0;i<objectList.length;i++)
			{
				result += objectList[i].bets;
			}
			return result;
		}
		
		private function getTotalWins():Number{
			var result:Number;
			for (var i:int=0;i<objectList.length;i++)
			{
				result += objectList[i].wins;
			}
			return result;
		}
		
		private function getTotalResult():int{
			var result:int=0;
			for (var i:int=0;i<objectList.length;i++)
			{
				result += int(objectList[i].results);
			}
			return result;
		}
		
		
		private function getRedResult():int{
			var result:int=0;
			for (var i:int=0;i<objectList.length;i++)
			{
				var num:int= int(objectList[i].id);
				switch (num){
					
					case 1:
					case 3:
					case 5:
					case 7:
					case 9:
					case 12:
					case 14:
					case 16:
					case 18:
					case 19:
					case 21:
					case 23:
					case 25:
					case 27:
					case 30:
					case 32:
					case 34:
					case 36:
						result += int(int(objectList[i].results));
						break;
				}
			}
			return result;
		}
		
		
		private function getZeroResult():int{
			var result:int=0;
			for (var i:int=0;i<objectList.length;i++)
			{
				var num:int= int(objectList[i].id);
				switch (num){
					
					case 0:
						result += int(objectList[i].results);
						break;
				}
			}
			return result;
		}
		
		private function getBlackResult():int{
			var result:int=0;
			for (var i:int=0;i<objectList.length;i++)
			{
				var num:int= int(objectList[i].id);
				switch (num){
					
					case 2:
					case 4:
					case 6:
					case 8:
					case 10:
					case 11:
					case 13:
					case 15:
					case 17:
					case 20:
					case 22:
					case 24:
					case 26:
					case 28:
					case 29:
					case 31:
					case 33:
					case 35:
						result += int(objectList[i].results);
						break;
				}
			}
			return result;
		}
		
		
		private function getEvenResult():int{
			var result:int=0;
			for (var i:int=0;i<objectList.length;i++)
			{
				var num:int= int(objectList[i].id);
				switch (num){
					
					case 2:
					case 4:
					case 6:
					case 8:
					case 10:
					case 12:
					case 14:
					case 16:
					case 18:
					case 20:
					case 22:
					case 24:
					case 26:
					case 28:
					case 30:
					case 32:
					case 34:
					case 36:
						result += int(objectList[i].results);
						break;
				}
			}
			return result;
		}
		private function getOddResult():int{
			var result:int=0;
			for (var i:int=0;i<objectList.length;i++)
			{
				var num:int= int(objectList[i].id);
				switch (num){
					
					case 1:
					case 3:
					case 5:
					case 7:
					case 9:
					case 11:
					case 13:
					case 15:
					case 17:
					case 19:
					case 21:
					case 23:
					case 25:
					case 27:
					case 29:
					case 31:
					case 33:
					case 36:
						result += int(objectList[i].results);
						break;
				}
			}
			return result;
		}
		private function getLowResult():int{
			var result:int=0;
			for (var i:int=1;i<19;i++)
			{
				var num:int= int(objectList[i].id);
				
				result += int(objectList[i].results);
				
			}
			return result;
		}
		
		private function getHighResult():int{
			var result:int=0;
			for (var i:int=19;i<37;i++)
			{
				var num:int= int(objectList[i].id);
				result += int(objectList[i].results);
				
				
			}
			return result;
		}
		
		private function caculateRedResults():int{
			var red:int= getRedResult();
			var total:int= getTotalResult();
			var result:int= red / total * 100;
			return result;
		}
		
		private function caculateBlackResults():int{
			var black:int= getBlackResult();
			var total:int= getTotalResult();
			var result:int= black / total * 100;
			return result;
		}
		
		private function caculateZeroResults():int{
			var zero:int =getZeroResult();
			var total:int= getTotalResult();
			var result:int= zero / total * 100;
			return result;
		}
		
		private function caculateOddResults():int{
			var odd:int =getOddResult();
			var total:int= getTotalResult();
			var result:int= odd / total * 100;
			return result;
		}
		
		private function caculateEvenResults():int{
			var even:int =getEvenResult();
			var total:int= getTotalResult();
			var result:int= even / total * 100;
			return result;
		}
		
		private function caculateHighResults():int{
			var high:int =getHighResult();
			var total:int= getTotalResult();
			var result:int= high / total * 100;
			return result;
		}
		
		
		private function caculateLowResults():int{
			var low:int =getLowResult();
			var total:int= getTotalResult();
			var result:int= low / total * 100;
			return result;
		}
		
		public function refresh():void{
			
			redResult = caculateRedResults();
			blackResult= caculateBlackResults();
			zeroResult= caculateZeroResults();
			oddResult= caculateOddResults();
			evenResult= caculateEvenResults();
			lowResult= caculateLowResults();
			highResult= caculateHighResults();
			
			
			redPrgress.gotoAndStop(1);
			blackPrgress.gotoAndStop(1);
			zeroPrgress.gotoAndStop(1);
			evenPrgress.gotoAndStop(1);
			oddPrgress.gotoAndStop(1);
			highPrgress.gotoAndStop(1);
			lowPrgress.gotoAndStop(1);
			
			
			var str:String ="[Statistic_Result]: redResult=#RED# blackResult=#BLACK# zeroResult=#ZERO# oddResult=#ODD# evenResult=#EVEN# lowResult=#LOW# highResult=#HIGH#";
			str= StringUtils.replace(str,"#RED#",String(redResult));
			str= StringUtils.replace(str,"#BLACK#",String(blackResult));
			str= StringUtils.replace(str,"#ZERO#",String(zeroResult));
			str= StringUtils.replace(str,"#ODD#",String(oddResult));
			str= StringUtils.replace(str,"#EVEN#",String(evenResult));
			str= StringUtils.replace(str,"#LOW#",String(lowResult));
			str= StringUtils.replace(str,"#HIGH#",String(highResult));
			
			redPrgress.play();
			blackPrgress.play();
			zeroPrgress.play();
			evenPrgress.play();
			oddPrgress.play();
			highPrgress.play();
			lowPrgress.play();
		}
		
		public function set stats(value:XML):void {
			_stats = value;
			loadFromXML(value);
			showStats();
		}
		
		private function showStats():void {
			
			var total:int =getTotalResult();
			for each (var item:XML in stats.number) {
				var id:String =item.@id;
				var pos:String =item.@results;
				pos= String((int(pos)>10)?10:int(pos));
				mcWheel["r" + id].mcMask.gotoAndStop("m" + pos);
			}
			
			/*var r:int = 0;
			var b:int = 0;
			for each (var item:XML in stats.number) {
				TextField(getChildByName("n" + item.@id)).text = item.@results;
				if(GameUtils.findRouletteBetspotColor(item.@id) == "RED") {
					r += int(item.@results);
				}
				if(GameUtils.findRouletteBetspotColor(item.@id) == "BLACK") {
					b += int(item.@results);
				}
			}
			red.text = "" + r;
			black.text = "" + b;*/
		}
	}
}