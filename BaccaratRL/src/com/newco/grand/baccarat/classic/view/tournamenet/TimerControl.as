package  com.newco.grand.baccarat.classic.view.tournamenet {
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class TimerControl extends TimerControlSkin {
		
		public static const MILLISECONDS_PER_MINUTE:int = 1000 * 60;
		public static const MILLISECONDS_PER_HOUR:int = 1000 * 60 * 60;
		public static const MILLISECONDS_PER_DAY:int = 1000 * 60 * 60 * 24;
		
		private var timer:Timer;
		private var targetDate:Date;
		
		public function TimerControl( date:Date ) {
			targetDate = date;
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, _tick);
			timer.start();
		}
		
		private function _tick(event:TimerEvent):void {
			
			var currentDate:Date = new Date();
			var diff:Number = (targetDate.valueOf() - currentDate.valueOf());
			
			if (diff < 0) diff = 0;
			
			var daysLeft:int = Math.floor((diff / (60*60*24)) / 1000);
			var daysPortion:Number = (100-(daysLeft*100/30))/100;
			diff -= (daysLeft * MILLISECONDS_PER_DAY);
			
			var hoursLeft:int = Math.floor((diff / (60*60))/1000);
			var hoursPortion:Number = (100-(hoursLeft*100/24))/100;
			diff -= (hoursLeft * MILLISECONDS_PER_HOUR);
			
			var minutesLeft:int = Math.floor((diff / 60)/1000);
			var minutesPortion:Number = (100-(minutesLeft*100/60))/100;
			diff -= (minutesLeft * MILLISECONDS_PER_MINUTE);
			
			var secondsLeft:int = Math.floor(diff/1000);
			var secondsPortion:Number = (100-(secondsLeft*100/60))/100;
			
			//trace( daysLeft, hoursLeft, minutesLeft, secondsLeft );
			
			daysTxt.text = getDoubleDigit( daysLeft );
			hoursTxt.text = getDoubleDigit( hoursLeft );
			minutesTxt.text = getDoubleDigit( minutesLeft );
			secondsTxt.text = getDoubleDigit( secondsLeft );
		}
		
		private function getDoubleDigit(num:int):String {
			return String( (num < 10) ? '0' + num : num );
		}
	}
	
}
