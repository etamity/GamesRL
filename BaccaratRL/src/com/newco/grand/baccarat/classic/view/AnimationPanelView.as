package com.newco.grand.baccarat.classic.view
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class AnimationPanelView extends Sprite
	{
		public function AnimationPanelView()
		{
			super();
		}
		
		public function showWinningBox(amount:String,side:String):MovieClip{
			var winAnimationAsset:WinAnimationAsset = new WinAnimationAsset();
			winAnimationAsset.stop();
			winAnimationAsset.gotoAndStop(side);
			winAnimationAsset.winAmontLabel.text=amount;
			winAnimationAsset.visible=false;
			addChild(winAnimationAsset);
			return winAnimationAsset;
		}
		public function showWinningCup():MovieClip{
			var mc:WinnerBadgetAsset = new WinnerBadgetAsset();
			mc.stop();
			mc.visible=false;
			addChild(mc)
			return mc;
		}
	}
}