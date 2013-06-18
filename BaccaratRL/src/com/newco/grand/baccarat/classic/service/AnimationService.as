package com.newco.grand.baccarat.classic.service
{
	import com.newco.grand.core.common.model.Actor;
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	import caurina.transitions.Tweener;

	public class AnimationService extends Actor
	{
		public var fadeTime:int=1;
		public var delayTime:int=4000;
		public function AnimationService()
		{
			super();
		}

		public function fadeInCenter(mc:MovieClip):void{
			fadeIn(mc,new Point(mc.stage.stageWidth/2,mc.stage.stageHeight/2));
		}
		
		public function fadeIn(mc:MovieClip,pt:Point):void{
			function onFinished(mc:MovieClip):void{
				setTimeout(function (mc:MovieClip):void{
					fadeMove(mc,{alpha:0,x:pt.x,y:pt.y},function(mc:MovieClip):void{
						mc.parent.removeChild(mc);
					});
				},delayTime,mc);
			}
			mc.alpha=0;
			mc.visible=true;
			mc.x=pt.x;
			mc.y=pt.y;
			setTimeout(function (mc:MovieClip):void{
				fadeMove(mc,{x:pt.x,y:pt.y,alpha:1},onFinished);
			},1000,mc);
		}
		private function fadeMove(mc:MovieClip, params:Object,complete:Function=null):void{
			Tweener.addTween(mc,{x:params.x, y:params.y,alpha:params.alpha, time: fadeTime ,onComplete:complete,onCompleteParams:[mc]});
		}
	}
}