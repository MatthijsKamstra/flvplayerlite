/**
SoundBg (AS3), version 1.0

<pre>
 ____                   _      ____ 
|  __| _ __ ___    ___ | | __ |__  |
| |   | '_ ` _ \  / __|| |/ /    | |
| |   | | | | | || (__ |   <     | |
| |__ |_| |_| |_| \___||_|\_\  __| |
|____|                        |____|

</pre>


@class  	: 	SoundBg
@author 	:  	Matthijs C. Kamstra [mck]
@version 	:	1.0 - class creation (AS3)
@since 		:	28-8-2008 12:30 
 

DESCRIPTION:
	Load and controle a background sound

ARGUMENTS:
	1) $fileURL		location of mp3 file (example: 'mp3/foobar.mp3')
	2)	$vars		An object containing param that you want to use with the creation of the SoundBg
						PLAYING:
							autoPlay			: start automatic play 	(default true)
							loopTimes			: sound is loped x times (default int.MAX_VALUE == 2147483647) [not functional yet]
						SPECIAL PROPERTIES:
							onPosition			: feedback on what position the playhead is (also needed for pause)
							onTag				: when the id3 tags are received
							onProgress			: use this to folow the loading progress (from zero to one :: 0 to 1)
							onComplete			: If you'd like to call a function when the tween has finished, use this. 
							onCompleteParams	: An array of parameters to pass the onComplete function (optional) [not functional yet]
							
EXAMPLES: 
	Load a background sound
		
		import nl.matthijskamstra.media.SoundBg; // import
		var soundBG:soundBg = new SoundBg ("mp3/donuts_music_loop.mp3" );
		
		or 
		
		var soundBG:SoundBg = SoundBg.create ("mp3/donuts_music_loop.mp3" ,{isAutoPlay:false} ); 

NOTES:
	- visit my website: http://www.MatthijsKamstra.nl/blog
	- some features descibed here will not be working
	- all your base are belong to us

CHANGELOG:
	v 1.0 [28-8-2008 12:30] - Initial release
		
*/
package nl.matthijskamstra.media {
	
	import flash.display.*;
	import flash.events.*;	
	// import gs.TweenLite;
	
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.net.URLRequest;
    import flash.utils.Timer;
	import flash.media.ID3Info;
	
	import flash.media.SoundTransform;
	
	public class SoundBg {
		
		// Constants:
		public static var CLASS_REF = nl.matthijskamstra.media.SoundBg;
		public static var CLASS_NAME : String = "SoundBg";
		public static var LINKAGE_ID : String = "nl.matthijskamstra.media.SoundBg";
		// vars
		
		public static var version:Number = 1.0;
		
        private var positionTimer		:Timer;
		private var isSoundPlaying		:Boolean;		
		private var isTagSet			:Boolean		= false;	// preventing id3 tags to set twice		
		
        public var mySound				:Sound;
        public var mySoundChannel		:SoundChannel 	= new SoundChannel();		
		public var vars					:Object; 								// Variables (holds things like autoplay)
		public var isAutoPlay			:Boolean 		= true;					// default isAutoPlay on
		public var loopTimes			:int	 		= int.MAX_VALUE;		// sound is loped x times (default int.MAX_VALUE == 2147483647)
		public var pauseTime			:Number;								// if pause is pressed use this to start play again

		
		/**
		* Constructor: create a background sound
		* 
		* @usage 		import nl.matthijskamstra.media.SoundBg; // import
		*				var soundBG:soundBg = new SoundBg ("mp3/donuts_music_loop.mp3" );
		* @param	$fileURL		location of mp3 file (example: 'mp3/foobar.mp3')
		* @param	$vars			extra vars (like autoplay, ...)
		*/
		public function SoundBg($fileURL:String , $vars:Object = null) {
			//trace( "SoundBg.SoundBg > $fileURL : " + $fileURL + ", $vars : " + $vars );
			if ( $fileURL == null ) { return; }
			
			if ($vars != null) {
				this.vars = $vars;
				if ($vars.autoPlay == false) { this.isAutoPlay = false; }
				if ($vars.loopTimes != null) { this.loopTimes = $vars.loopTimes; }
			}
			
            var request:URLRequest = new URLRequest($fileURL);
            mySound = new Sound();
			
            mySound.addEventListener(Event.COMPLETE, completeHandler);
            mySound.addEventListener(Event.ID3, id3Handler);
            mySound.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            mySound.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            mySound.load(request);
			
			if (this.isAutoPlay){
				mySoundChannel = mySound.play(0, this.loopTimes);
				isSoundPlaying = true;
			} else {
				mySoundChannel.stop() ;
				isSoundPlaying = false;
			}
			
			// mySoundChannel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);

            positionTimer = new Timer(50);
            positionTimer.addEventListener(TimerEvent.TIMER, positionTimerHandler);
            positionTimer.start();
        }
        
		//////////////////////////////////////// Sound Controllers ////////////////////////////////////////
		
		public function stop () {
			//trace( "SoundBg.stop" );
			pauseTime = 0;
			mySoundChannel.stop();
		}
		public function play () {
			//trace( "SoundBg.play" );
			mySoundChannel = mySound.play(pauseTime, this.loopTimes );
		}
		public function pause () {
			//trace( "SoundBg.pause" );
			pauseTime = mySoundChannel.position;
			mySoundChannel.stop();
		}
		public function rewind () {
			//trace( "SoundBg.rewind" );
			mySoundChannel = mySound.play(0, this.loopTimes );
		}
		public function forward () {
			//trace( "SoundBg.forward" );
		}
		
		
		//////////////////////////////////////// Handlers ////////////////////////////////////////		
		
		
        public function positionTimerHandler(e:TimerEvent):void {
			//trace( "SoundBg.positionTimerHandler > e : " + e );
            //trace("positionTimerHandler: " + mySoundChannel.position.toFixed(0) + ' ms (millisecond)');
			if (this.vars != null && this.vars.onPosition != null) {
				this.vars.onPosition.apply(null , [mySoundChannel.position.toFixed(0)]);
			}
        }

        private function completeHandler(e:Event):void {
			// trace( "SoundBg.completeHandler > e : " + e );
			if (this.vars != null && this.vars.onComplete != null) {
				this.vars.onComplete.apply(null);
			}
        }

		private function id3Handler(e:Event):void {
			//trace( "SoundBg.id3Handler > e : " + e );
			if (this.vars != null && this.vars.onTag != null && !isTagSet) {	
				isTagSet = true;
				var id3:ID3Info = mySound.id3;
				/*
				for (var propName:String in id3) {
					trace (propName + " = " + id3[propName] );
				}
				trace ("Artist: " + id3.artist );
				trace ("Song name: " + id3.songName );
				trace ("Album: " + id3.album ); 
				*/
				this.vars.onTag.apply(null, [id3]);
			}
        }

        private function ioErrorHandler(e:Event):void {
			trace( "SoundBg.ioErrorHandler > e : " + e );
			positionTimer.stop();
        }

        public function progressHandler(e:ProgressEvent):void {
			//trace( "SoundBg.progressHandler > e : " + e );
			if (this.vars != null && this.vars.onProgress != null) {
				this.vars.onProgress.apply(null, [(e.bytesLoaded / e.bytesTotal)]);
			}
        }

        private function soundCompleteHandler(e:Event):void {
			trace( "SoundBg.soundCompleteHandler > e : " + e );
			positionTimer.stop();
        }
		
		
		//////////////////////////////////////// static ////////////////////////////////////////		
	
		/**
		 * static function to create a backgroun sound
		 * @usage		var soundBG:SoundBg = SoundBg.create ('mp3/donuts_music_loop.mp3'); 
		 * 
		 * @param	$fileURL		location of mp3 file (example: 'mp3/foobar.mp3')
		 * @param	$vars			extra vars (like autoplay, ...)
		 */
		public static function create ($fileURL:String, $vars:Object = null ):SoundBg{
			return new SoundBg ($fileURL, $vars );
		}
		
		//////////////////////////////////////// Listener ////////////////////////////////////////
		
		
	} // end class
	
} // end package

