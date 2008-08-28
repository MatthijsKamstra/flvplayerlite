/**
SoundController (AS3), version 1.1

Enter description here

<pre>
 ____                   _      ____ 
|  __| _ __ ___    ___ | | __ |__  |
| |   | '_ ` _ \  / __|| |/ /    | |
| |   | | | | | || (__ |   <     | |
| |__ |_| |_| |_| \___||_|\_\  __| |
|____|                        |____|

</pre>

@class  	: 	SoundController
@author 	:  	Matthijs C. Kamstra [mck]
@version 	:	1.1 - class creation (AS3)
@since 		:	8-5-2008 14:47 

DESCRIPTION:
	Every feature of SoundBg will also work here
	For more detailed information see nl.matthijskamstra.media.soundBg.as

EXAMPLES:
	loop the soundfile 2 times
		import nl.matthijskamstra.media.SoundController; // import
		var _sc:SoundController = new SoundController (controllerMC, "mp3/donuts_music_loop.mp3" ,{loopTimes:2});
		
NOTES:
	- some features descibed here will not be working, yet
	- visit my site: http://www.matthijskamstra.nl/blog
	- all your base are belong to us

CHANGELOG:
 		v 1.1 [28-08-2008 16:07] 	- Based upon FLVPlayerLiteController and 
 		v 1.0 [2008-05-08] 			- Initial release

*/
package nl.matthijskamstra.media {
	
	import flash.display.*;
	import flash.events.*;	

	public class SoundController extends SoundBg {
		
		// Constants:
		public static var CLASS_REF = nl.matthijskamstra.media.SoundController;
		public static var CLASS_NAME : String = "SoundController";
		public static var LINKAGE_ID : String = "nl.matthijskamstra.media.SoundController";
		
		// var
		private var mediaController:Object;
		
		/**
		* Constructor: create a sound-controler
		* 
		* @usage   	import nl.matthijskamstra.media.SoundController; // import
		*			var _sc:SoundController = new SoundController (  "mp3/donuts_music_loop.mp3" );
		* 
		* @param	$targetObj		a reference to a movie clip or object
		* @param	$fileURL		location of mp3 file (example: 'mp3/foobar.mp3')
		* @param	$vars			extra vars (like autoplay, ...)
		*/
		public function SoundController( $targetObj:DisplayObjectContainer, $fileURL:String, $vars:Object = null) {
			// trace ( '+ ' + LINKAGE_ID + ' class instantiated');
			super($fileURL, $vars);
			setupControler ($targetObj);
		}
		
		/**
		 * setup the buttons
		 */
		private function setupControler ($targetObj:DisplayObjectContainer) {
			//trace( "SoundController.setupControler > $targetObj : " + $targetObj );
			
			mediaController = $targetObj as MovieClip;
			if (mediaController == null) {
				generateControler ();
				return;
			}
			
			mediaController.loaderBar_mc.width = 0;
			mediaController.loaderProgress_mc.width = 0;
			
			// setup controlers
			Button.onRelease (mediaController.playBtn_mc , buttonActivateButton, 'play');
			Button.onRelease (mediaController.pauseBtn_mc , buttonActivateButton, 'pause');
			//Button.onRelease (mediaController.soundBtn_mc , buttonActivateButton, 'playSound');
			//Button.onRelease (mediaController.soundOffBtn_mc , buttonActivateButton, 'stopSound');
			
			// trace( "isAutostart: " + isAutostart);
			if (isAutoPlay) {
				mediaController.playBtn_mc.visible = false;
			} 
		}
		
		/**
		 * generate a controler
		 * [not functinal yet]
		 */
		private function generateControler():void{
			trace (':: no mediaController, so it needs to be generated >> doesn\'t work yet')
		}
		
		/**
		 * a general function for the buttons
		 * @param	$id
		 */
		private function buttonActivateButton($id:String):void {
			switch ($id) {
				case 'pause': 
					//trace('buttonActivateButton >> pause');
					mediaController.playBtn_mc.visible = true;
					mediaController.soundBtn_mc.visible = false;
					pause ();
					break;
				case 'play': 
					//trace('buttonActivateButton >> play');
					mediaController.playBtn_mc.visible = false;
					mediaController.soundBtn_mc.visible = true;
					play();
					break;
				default:
					trace( "case '" + $id + "': \n\ttrace('"+$id+"');\n\tbreak;");
			}
		}
		
		/**
		 * create a 2 digit number for numbers lower then 10 (example '2' becomes '02')
		 * @param	$sec	seconds you want to change to xx:xx
		 * @return		'xx:xx'
		 */
		private function timeNotation ($sec:Number):String {
			var minutes = Math.floor ($sec / 60);
			var seconds = Math.floor ($sec % 60);
			if (minutes < 10) { minutes = "0" + minutes; }
			if (seconds < 10) { seconds = "0" + seconds; }
			return (minutes + ":" + seconds);
		}
		
		//////////////////////////////////////// override Handlers ////////////////////////////////////////
		
		override public function progressHandler(e:ProgressEvent):void {
			mediaController.loaderProgress_mc.width = mediaController.loaderSize_mc.width / (e.bytesLoaded / e.bytesTotal);
        }
		
		override public function positionTimerHandler(e:TimerEvent):void {
			mediaController.loaderBar_mc.width = ((mediaController.loaderSize_mc.width) * ( mySoundChannel.position / mySound.length ))/loopTimes;
			mediaController.currentTime_txt.text = timeNotation (mySoundChannel.position/1000);
			mediaController.totalTime_txt.text = timeNotation ((mySound.length * loopTimes )/1000);
        }
		
		/////////////////////////////////////// Static ///////////////////////////////////////
		
		/**
		* create a lite FLV player with controler
		* 
		* @usage   	import nl.matthijskamstra.media.SoundController; // import
		*			SoundController.create ( this , 'mp3/foobar.mp3' );
		* @param	$targetObj		a reference to a movie clip or object
		* @param	$fileURL		path to FLV file (example: '../mp3/foobar.mp3')
		* @param	$vars			object with extra param
		*/
		public static function create ( $targetObj:DisplayObjectContainer, $fileURL:String, $vars:Object = null):SoundBg {
			return new SoundController ($targetObj, $fileURL, $vars);
		}
	
		
	} // end class
	
} // end package
