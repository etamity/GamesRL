package com.ai.core.utils {
	
	public class StringUtils {
		
		public static function trim(str:String):String {
			if (str == null) {
				return null;
			}
			return str.replace(/^\s*/, "").replace(/\s*$/, "");
		}
		
		public static function capitalize(str:String):String {
			return str.charAt(0).toUpperCase() + str.slice(1);
		}
		
		public static function uncapitalize(str:String):String {
			return str.charAt(0).toLowerCase() + str.slice(1);
		}
		
		public static function replace(text:String, pattern:String, repl:String):String {
			return text.replace(new RegExp(pattern, "g"), repl);
		}
		
		public static function titleize(str:String):String {
			var words:Array = str.toLowerCase().split(" ");			
			for (var i:int = 0; i < words.length; i++) {
				words[i] = capitalize(words[i]);
			}
			return words.join(" ");
		}
		
		public static function abbreviate(str:String, offset:int, maxWidth:int):String {			
			if (str.length <= maxWidth) {
				return str;
			}
			return str.substring(0, maxWidth - 3) + "...";
		}
		
		public static function parseURL(url:String, replace:Object):String {
			for(var o:String in replace)
			{
				var what:RegExp = new RegExp(o, 'ig')
				if (replace[o]!="")
					url = url.replace(what, replace[o]);
			}
			return url;
		}
		public static function floatCorrection(val:Number):Number {
			var correction:Number = Math.pow(10, 5);
			return Math.round(correction * val) / correction;
		}
	}
}