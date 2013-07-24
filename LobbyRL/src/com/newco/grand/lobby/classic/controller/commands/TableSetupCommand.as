package com.newco.grand.lobby.classic.controller.commands
{
	import com.newco.grand.core.common.controller.commands.BaseCommand;
	import com.newco.grand.lobby.classic.model.LobbyModel;
	
	public class TableSetupCommand extends BaseCommand
	{
		[Inject]
		public var lobbyModel:LobbyModel;
		
		public function TableSetupCommand()
		{
			super();
		}
		
		override public function execute():void {	
			
		}
	}
}