package com.newco.grand.core.utils {
	
	public class FormatUtils {
		
		public static function formatBalance(amount:Number, decimals:Boolean = true):String {
			if (amount == 0) {
				return "0";
			}
			
			amount = amount * 100;
			amount = Math.round(amount);
			
			var stramount:String = String(Math.floor(amount));
			if(stramount.length == 1) {
				return ("0.0" + amount);				
			}
			else if(stramount.length == 2) {
				return ("0." + amount);				
			}
			
			var deciValues:String = stramount.slice( -2);			
			stramount = stramount.substring(0, stramount.length - 2);			
			
			var wholeValues:Array = new Array();
			do {
				wholeValues.push(stramount.slice( -3));				
				stramount = stramount.substring(0, stramount.length - 3);
			}
			while(stramount.length > 3);
			
			if (stramount.length) {
				wholeValues.push(stramount);
			}
			wholeValues.reverse();
			if (Number(deciValues) > 0 && decimals) {
				return (wholeValues.join() + "." + deciValues);
			}
			else {
				return (wholeValues.join());
			}			
		}
		
		public static function formatChipText(val:Number):String {			
			var formattedValue:String;
			if (val < 10) {
				formattedValue = floatCorrection(val) + "";
			}
			else if (val < 1000 && String(val / 100).length <= 4) {
				formattedValue = floatCorrection(Math.floor(val)) + "";
			}
			else if (val < 1000 && String(val / 100).length > 4) {
				formattedValue = floatCorrection(Math.floor(val)) + "+";
			}			
			else if (val / 1000 < 1) {
				formattedValue = floatCorrection(Math.floor(val)) + "";
			}
			else if (val / 1000 > 1 && val % 1000 > 0) {			
				formattedValue = floatCorrection(Math.floor(val)/1000) + "k+";
			}
			else if ((val / 1000 >= 1) && val % 1000 == 0) {
				formattedValue = floatCorrection(Math.floor(val)/1000) + "k";
			}			
			return formattedValue;
		}
		
		public static function formatChipStackText(val:Number):String {
			var formattedValue:String = "";
			if (val / 1000 < 1) {
				formattedValue = "" + val;
			}
			else if (val / 1000 >= 1) {
				formattedValue = (val / 1000) + "k";
			}
			return formattedValue;
		}
		
		public static function floatCorrection(val:Number):Number {
			var correction:Number = Math.pow(10, 5);
			return Math.round(correction * val) / correction;
		}
		
		public static function formetURL(url:String, replace:Object):String {
			for(var o:String in replace)
			{
				var what:RegExp = new RegExp(o, 'ig')
				url = url.replace(what, replace[o]);
			}
			return url;
		}
		
	}
}