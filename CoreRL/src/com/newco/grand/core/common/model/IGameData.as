package com.newco.grand.core.common.model
{
	import flash.utils.Dictionary;

	public interface IGameData
	{
		 function get dealer():String;
		
		 function set dealer(value:String):void ;
		 function get table():String ;
		
		 function set table(value:String):void ;
		
		 function get videoSettings():XML	;
		
		 function set videoSettings(value:XML):void ;
		 function get videoApplication():String	;
		
		 function set videoApplication(value:String):void ;
		 function get server():String	;
		
		 function set server(value:String):void ;
		 function get gameID():String ;
		
		 function set gameID(value:String):void ;
		
		 function get gameTime():String ;
		
		 function set gameTime(value:String):void ;
		 function set videoStream(value:String):void;
		 function get videoStream():String;
		
		 function set videoStreams(value:Array):void;
		 function get videoStreams():Array;
		 
		 function get countdown():int;
		
		 function set countdown(value:int):void ;
		 function get chips():Array ;
		
		 function set chips(value:Array):void ;
		
		 function get chipSelected():Number;
		
		 function set chipSelected(value:Number):void ;
		
		 function get fullscreen():Boolean ;
		
		 function set fullscreen(value:Boolean):void ;
		
		 function get sound():Boolean ;
		
		 function set sound(value:Boolean):void ;
		 function get min():Number ;
		
		 function set min(value:Number):void ;
		
		 function get max():int;
		
		 function set max(value:int):void;
		 function get resultXML():XML;
		 function set resultXML(value:XML):void;
		 function get response():String;
		 
		 function set response(value:String):void;
		 function get statusMessage():String;
		 function set statusMessage(value:String):void;
		 function get game():String;
		  
		 function set game(value:String):void;
		 function get layoutPoints():Dictionary;
		 function get httpStream():String;
		 function set httpStream(val:String):void;
		 function get xmodeStream():String;
		 function set xmodeStream(val:String):void;
	}
}