/**
FLVPlayerLiteController (AS3), version 1.0

Enter description here

<pre>
 ____                   _      ____ 
|  __| _ __ ___    ___ | | __ |__  |
| |   | '_ ` _ \  / __|| |/ /    | |
| |   | | | | | || (__ |   <     | |
| |__ |_| |_| |_| \___||_|\_\  __| |
|____|                        |____|

</pre>

@class  	: 	FLVPlayerLiteController
@author 	:  	Matthijs C. Kamstra [mck]
@version 	:	1.0 - class creation (AS3)
@since 		:	8-5-2008 14:47 



NOTES:
	- this project is opensource: http://code.google.com/p/flvplayerlite/
	- some features descibed here will not be working currently so visit the project homepage for detailed information
	- visit my site: http://MatthijsKamstra.nl/blog
	- all your base are belong to us
	- will add 9KB to your .SWF (3,11 KB (3.185 bytes) from the FLVPlayerLite)

CHANGELOG:
 		v 1.0 [2008-05-08] - Initial release

*/
package nl.matthijskamstra.media {
	
	import flash.display.*;
	import flash.events.*;	

	public class FLVPlayerLiteController extends FLVPlayerLite {
		
		// Constants:
		public static var CLASS_REF = nl.matthijskamstra.media.FLVPlayerLiteController;
		public static var CLASS_NAME : String = "FLVPlayerLiteController";
		public static var LINKAGE_ID : String = "nl.matthijskamstra.media.FLVPlayerLiteController";
		
		// var
		private var FLVPlayerControler:Object;
		
		// vars
		
		/**
		* Constructor: create a lite FLV player with controler
		* 
		* @usage   	import nl.matthijskamstra.media.FLVPlayerLiteController; // import
		*			var __FLVPlayerLiteController:FLVPlayerLiteController = new FLVPlayerLiteController ( this , 'flv/Final_Mov_Sequence.flv' );
		* 			(read comments in 'nl.matthijskamstra.media.FLVPlayerLite' & 'nl.matthijskamstra.media.FLVPlayerLiteController')
		* 
		* @param	$targetObj		a reference to a movie clip or object
		* @param	$url			path to FLV file (example: '../flv/foobar.flv')
		* @param	$obj			object with extra param (read mor about this in the comments on the top)
		*/
		public function FLVPlayerLiteController( $targetObj:DisplayObjectContainer, $url:String, $obj:Object = null) {
			//trace ( '+ ' + LINKAGE_ID + ' class instantiated');
			super($targetObj, $url, $obj);
		}
		
		/**
		 * 
		 */
		private function setupControler () {
			//trace( "\t|\t " + CLASS_NAME + " :: setupControler  "  );
			
			FLVPlayerControler = targetObj.getChildByName ('flvControler_mc');
			var FLVPlayerLite = targetObj.getChildByName ('FLVPlayerLite');
			
			if (FLVPlayerControler == null) {
				generateControler ();
				return;
			}
			
			targetObj.swapChildren(FLVPlayerControler as DisplayObject, FLVPlayerLite as DisplayObject);
			
			// get original width from loader
			
			// position is defined when the size of the movie is known (onMetaDataListener)
			FLVPlayerControler.x = 0;
			FLVPlayerControler.y = videoObj_vid.height;
			
			FLVPlayerControler.bg_mc.width = videoObj_vid.width - 1;
			FLVPlayerControler.soundBtn_mc.x = videoObj_vid.width - 1 - FLVPlayerControler.soundBtn_mc.width;
			FLVPlayerControler.soundOffBtn_mc.x = videoObj_vid.width - 1 - FLVPlayerControler.soundOffBtn_mc.width;
			
			FLVPlayerControler.currentTime_txt.x = videoObj_vid.width - 1 - (350 - 267);
			FLVPlayerControler.totalTime_txt.x = videoObj_vid.width - 1 - (350 - 297);
			
			FLVPlayerControler.loaderSize_mc.width = FLVPlayerControler.currentTime_txt.x - 5 - FLVPlayerControler.loaderSize_mc.x
			FLVPlayerControler.loaderBar_mc.width = 0;
			FLVPlayerControler.loaderProgress_mc.width = (FLVpercentLoaded / 100) * FLVPlayerControler.loaderSize_mc.width ;
			//FLVPlayerControler.loaderProgress_mc.width = 0;
			
			// setup controlers
			FLVPlayerLiteControllerButton.onRelease (FLVPlayerControler.playBtn_mc , buttonActivateButton, 'play');
			FLVPlayerLiteControllerButton.onRelease (FLVPlayerControler.pauseBtn_mc , buttonActivateButton, 'pause');
			FLVPlayerLiteControllerButton.onRelease (FLVPlayerControler.soundBtn_mc , buttonActivateButton, 'playSound');
			FLVPlayerLiteControllerButton.onRelease (FLVPlayerControler.soundOffBtn_mc , buttonActivateButton, 'stopSound');
			
			FLVPlayerLiteControllerButton.onRollover (FLVPlayerControler.playBtn_mc , buttonActivateButton, 'rolloverPlay');
			FLVPlayerLiteControllerButton.onRollover (FLVPlayerControler.pauseBtn_mc , buttonActivateButton, 'rolloverPause');			
			FLVPlayerLiteControllerButton.onRollover (FLVPlayerControler.soundBtn_mc , buttonActivateButton, 'rolloverPlaySound');
			FLVPlayerLiteControllerButton.onRollover (FLVPlayerControler.soundOffBtn_mc , buttonActivateButton, 'rolloverStopSound');			
			
			// trace( "isAutostart: " + isAutostart);
			if (isAutostart) {
				FLVPlayerControler.playBtn_mc.visible = false;
			}
			if (isSoundOnStart) {
				FLVPlayerControler.soundBtn_mc.visible = true;
			}
			
			/*	
			| 	 0.	 name:size_mc	 type:object	[object MovieClip]
			| 	 1.	 name:bg_mc	 type:object	[object MovieClip]
			| 	 2.	 name:loaderSize_mc	 type:object	[object MovieClip]
			| 	 3.	 name:loaderProgress_mc	 type:object	[object MovieClip]
			| 	 4.	 name:loaderBar_mc	 type:object	[object MovieClip]
			| 	 5.	 name:currentTime_txt	 type:object	[object TextField]
			| 	 6.	 name:totalTime_txt	 type:object	[object TextField]
			| 	 7.	 name:soundOffBtn_mc	 type:object	[object soundOffBtn_mc_5]
			| 	 8.	 name:soundBtn_mc	 type:object	[object soundBtn_mc_6]
			| 	 9.	 name:pauseBtn_mc	 type:object	[object pauseBtn_mc_7]
			| 	 10.	 name:playBtn_mc	 type:object	[object playBtn_mc_8]
			*/
			
			
			
		}
		
		private function generateControler():void{
			trace (':: no FLVPlayerControler, so it needs to be generated >> doesn\'t work yet')
		}
		
		private function buttonActivateButton($id:String):void {
			//trace( "++ buttonActivateButton : " + buttonActivateButton );
			//trace( "$id : " + $id );
			switch ($id) {
				case 'play': 
					//trace('play');
					playMedia();
					FLVPlayerControler.playBtn_mc.visible = false;
					break;
				case 'pause': 
					//trace('pause');
					pauseMedia();
					FLVPlayerControler.playBtn_mc.visible = true;
					break;
				case 'playSound': 
					//trace('playSound');
					mute();
					FLVPlayerControler.soundBtn_mc.visible = false;
					break;
				case 'stopSound': 
					//trace('stopSound');
					mute();
					FLVPlayerControler.soundBtn_mc.visible = true;
					break;
				case 'rolloverPause': 
					//trace('rolloverPause');
					break;
				case 'rolloverPlay': 
					//trace('rolloverPlay');
					break;
				case 'rolloverStopSound': 
					//trace('rolloverStopSound');
					break;
				case 'rolloverPlaySound': 
					//trace('rolloverPlaySound');
					break;
				default:
					trace( "case '" + $id + "': \n\ttrace('"+$id+"');\n\tbreak;");
			}
			
		}
		
	
		////////////////////////////////// start: FLV loading ///////////////////////////////////
		
		override public function onLoadProgress($percent:Number):void {
			//trace( "\t|\t " + CLASS_NAME + " :: onLoadProgress -- $percent : " + $percent );
			if (FLVPlayerControler != null) {
				FLVPlayerControler.loaderProgress_mc.width = ($percent / 100) * FLVPlayerControler.loaderSize_mc.width;
			}
		}
		
		////////////////////////////////// end: FLV loading ///////////////////////////////////
		
		////////////////////////////////// start: FLV playhead ///////////////////////////////////
		
		override public function onPlayProgress($percent:Number, $currentTime:Number, $totalTime:Number):void {
			//trace( "\t|\t " + CLASS_NAME + " :: onPlayProgress -- $percent : " + $percent + " | $currentTime : " + $currentTime + " | $totalTime : " + $totalTime );
			if (FLVPlayerControler != null) {
				FLVPlayerControler.loaderBar_mc.width = ($percent / 100) * FLVPlayerControler.loaderSize_mc.width;
				FLVPlayerControler.currentTime_txt.text = timeNotation ($currentTime);
				FLVPlayerControler.totalTime_txt.text = timeNotation ($totalTime);
			}
		}
		
		////////////////////////////////// end: FLV playhead ///////////////////////////////////
		
		private function timeNotation ($sec:Number):String {
			var minutes = Math.floor ($sec / 60);
			var seconds = Math.floor ($sec % 60);
			if (minutes < 10) { minutes = "0" + minutes; }
			if (seconds < 10) { seconds = "0" + seconds; }
			return (minutes + ":" + seconds);
		}
		
		/////////////////////////////////////// Static ///////////////////////////////////////
		
		/**
		* create a lite FLV player with controler
		* 
		* @usage   	import nl.matthijskamstra.media.FLVPlayerLiteController; // import
		*			FLVPlayerLiteController.create ( this , 'flv/Final_Mov_Sequence.flv' );
		* 			(read comments in 'nl.matthijskamstra.media.FLVPlayerLite' & 'nl.matthijskamstra.media.FLVPlayerLiteController')
		* 
		* @param	$targetObj		a reference to a movie clip or object
		* @param	$url			path to FLV file (example: '../flv/foobar.flv')
		* @param	$obj			object with extra param (read mor about this in the comments on the top)
		*/
		public static function create ( $targetObj:DisplayObjectContainer , $url:String, $obj:Object=null):FLVPlayerLite {
			return new FLVPlayerLiteController ($targetObj, $url, $obj);
		}
		
		//////////////////////////////////////// Listener ////////////////////////////////////////
		
		
		override public function onMetaDataListener(info:Object):void {
			//trace( "onMetaDataListener : " + onMetaDataListener );
			// for( var i:String in info ) //trace( "key : " + i + ", value : " + info[ i ] );
			
			// data used by FLVPlayerLite
			nDuration = info.duration;	
			
			var vidWidth:Number 	= info.width;
			var vidHeight:Number 	= info.height;
			
			videoObj_vid.width		= vidWidth;
			videoObj_vid.height 	= vidHeight;
			
			// extra data by the FLVPlayerLiteController
			setupControler ();
			
		}
		
		
	} // end class
	
} // end package
