package com.ai.core.service {
	
	public interface ISocketService	{
		function connectToSocket(server:String, port:int):void;
		function closeSocketConnection():void;
	}
}