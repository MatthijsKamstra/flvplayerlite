/**
SoundLite (AS3), version 1.2

<pre>
 ____                   _      ____ 
|  __| _ __ ___    ___ | | __ |__  |
| |   | '_ ` _ \  / __|| |/ /    | |
| |   | | | | | || (__ |   <     | |
| |__ |_| |_| |_| \___||_|\_\  __| |
|____|                        |____|

</pre>


@class  	: 	SoundLite
@author 	:  	Matthijs C. Kamstra [mck]
@version 	:	1.2 - class creation (AS3)
@since 		:	28-8-2008 12:30 
 

DESCRIPTION:
	Load and controle a background sound

ARGUMENTS:
	1) $fileURL		location of mp3 file (example: 'mp3/foobar.mp3')
	2)	$vars		An object containing param that you want to use with the creation of the SoundLite
						PLAYING:
							autoPlay			: start automatic play 	(default true)
							loopTimes			: sound is loped x times (default int.MAX_VALUE == 2147483647)
						SPECIAL PROPERTIES:
							onPosition			: feedback on what position the playhead is (also needed for pause)
							onTag				: when the id3 tags are received
							onProgress			: use this to folow the loading progress (from zero to one :: 0 to 1)
							onComplete			: If you'd like to call a function when the tween has finished, use this. 
							onCompleteParams	: An array of parameters to pass the onComplete function (optional) [not functional yet]
							
EXAMPLES: 
	Load a background sound
		
		import nl.matthijskamstra.media.SoundLite; // import
		var _SoundLite:SoundLite = new SoundLite ("mp3/donuts_music_loop.mp3" );
		
		or 
		
		var _SoundLite:SoundLite = SoundLite.create ("mp3/donuts_music_loop.mp3" ,{isAutoPlay:false} ); 

NOTES:
	- visit my website: http://www.MatthijsKamstra.nl/blog
	- some features descibed here will not be working
	- all your base are belong to us

CHANGELOG:
	v 1.2 [02-09-2008 14:27] - extra comment to understand handlers and volume function 
	v 1.1 [29-08-2008 13:40] - changed name from SoundBg to SoundLite 
	v 1.0 [28-08-2008 12:30] - Initial release
		
*/
package nl.matthijskamstra.media {
	
	import flash.display.*;
	import flash.events.*;	
	
	import gs.TweenLite;
	
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.net.URLRequest;
    import flash.utils.Timer;
	import flash.media.ID3Info;
	
	import flash.media.SoundTransform;
	
	
	
	public class SoundLite {
		
		// Constants:
		public static var CLASS_REF = nl.matthijskamstra.media.SoundLite;
		public static var CLASS_NAME : String = "SoundLite";
		public static var LINKAGE_ID : String = "nl.matthijskamstra.media.SoundLite";
		// vars
		
		public static var version:Number = 1.2;
		
        private var positionTimer		:Timer;
		private var isSoundPlaying		:Boolean;		
		private var isTagSet			:Boolean		= false;	// preventing id3 tags to set twice		
		
        public var mySound				:Sound;
        public var mySoundChannel		:SoundChannel 	= new SoundChannel();		
		public var vars					:Object; 								// Variables (holds things like autoplay)
		public var isAutoPlay			:Boolean 		= true;					// default isAutoPlay on
		public var loopTimes			:int	 		= int.MAX_VALUE;		// sound is looped x times (default int.MAX_VALUE == 2147483647)
		public var pauseTime			:Number;								// if pause is pressed use this to start play again

		
		/**
		* Constructor: create a background sound
		* 
		* @usage 		import nl.matthijskamstra.media.SoundLite; // import
		*				var _SoundLite:SoundLite = new SoundLite ("mp3/donuts_music_loop.mp3" );
		* @param	$fileURL		location of mp3 file (example: 'mp3/foobar.mp3')
		* @param	$vars			extra vars (like autoplay, ...)
		*/
		public function SoundLite($fileURL:String , $vars:Object = null) {
			//trace( "SoundLite.SoundLite > $fileURL : " + $fileURL + ", $vars : " + $vars );
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
			
			mySoundChannel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);

            positionTimer = new Timer(50);
            positionTimer.addEventListener(TimerEvent.TIMER, positionTimerHandler);
            positionTimer.start();
        }
        
		//////////////////////////////////////// Sound Controllers ////////////////////////////////////////
		
		public function stop () {
			//trace( "SoundLite.stop" );
			pauseTime = 0;
			mySoundChannel.stop();
			isSoundPlaying = false;
		}
		public function play ($skipMs:Number = NaN) {
			//trace( "SoundLite.play" );
			if (!isSoundPlaying) {
				if (!isNaN ($skipMs)) { pauseTime = $skipMs; }
				mySoundChannel = mySound.play(pauseTime, this.loopTimes );
				isSoundPlaying = true;
			}
		}
		public function pause () {
			//trace( "SoundLite.pause" );
			pauseTime = mySoundChannel.position;
			mySoundChannel.stop();
			isSoundPlaying = false;
		}
		public function rewind () {
			//trace( "SoundLite.rewind" );
			mySoundChannel = mySound.play(0, this.loopTimes );
		}
		public function forward () {
			//trace( "SoundLite.forward" );
		}
		
		/**
		 * setVolume 
		 * @usage		import nl.matthijskamstra.media.SoundLink; // import
		 * 				var _soundLink:SoundLink = new SoundLink ( new track6() );
		 * 				_soundLink.volume (.1);
		 * @param	$volume		The volume, ranging from 0 (silent) to 1 (full volume). (default = 1)
		 */
		public function volume ($volume:Number = 1) {
			//trace( "SoundLite.volume > $volume : " + $volume );
			
			// gs.tweenlite 
			var transform:SoundTransform = mySoundChannel.soundTransform;
			TweenLite.to (mySoundChannel, 1, { volume: $volume} );
			/*
			// no external classes
			var _transform:SoundTransform = new SoundTransform($volume);
			mySoundChannel.soundTransform = _transform;
			*/
		}
		
		
		//////////////////////////////////////// getter/setters ////////////////////////////////////////
		
		/**
		* import nl.matthijskamstra.media.SoundLite; // import
		* set: 		var _soundLite:SoundLite = new SoundLite ();
		*			_soundLite.trackPosition = $value ;
		* get:		var _soundLite:SoundLite = new SoundLite ();
		*			trace( "_soundLite.trackPosition : " + _soundLite.trackPosition );
		*/
		public function set trackPosition( $value )  { pauseTime = $value ; }
		public function get trackPosition() { return mySoundChannel.position; }
		
		public function get trackTotal() { return mySound.length; }
		
		
		
		//////////////////////////////////////// Handlers ////////////////////////////////////////		
		
		
        public function positionTimerHandler(e:TimerEvent):void {
			//trace( "SoundLite.positionTimerHandler > e : " + e );
            //trace("positionTimerHandler: " + mySoundChannel.position.toFixed(0) + ' ms (millisecond)');
			if (this.vars != null && this.vars.onPosition != null) {
				this.vars.onPosition.apply(null , [mySoundChannel.position.toFixed(0)]);
			}
        }

		// Dispatched when data has loaded successfully. 
        public function completeHandler(e:Event):void {
			// trace( "SoundLite.completeHandler > e : " + e );
			if (this.vars != null && this.vars.onComplete != null) {
				this.vars.onComplete.apply(null);
			}
        }

		// Dispatched by a Sound object when ID3 data is available for an MP3 sound. 
		public function id3Handler(e:Event):void {
			//trace( "SoundLite.id3Handler > e : " + e );
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

		// Dispatched when an input/output error occurs that causes a load operation to fail. 
        private function ioErrorHandler(e:Event):void {
			trace( "SoundLite.ioErrorHandler > e : " + e );
			positionTimer.stop();
        }
		
		// Dispatched when data is received as a load operation progresses. 
        public function progressHandler(e:ProgressEvent):void {
			//trace( "SoundLite.progressHandler > e : " + e );
			if (this.vars != null && this.vars.onProgress != null) {
				this.vars.onProgress.apply(null, [(e.bytesLoaded / e.bytesTotal)]);
			}
        }
		
		// Dispatched when data has loaded successfully. 
        public function soundCompleteHandler(e:Event):void {
			trace( "SoundLite.soundCompleteHandler > e : " + e );
			positionTimer.stop();
        }
		
		
		//////////////////////////////////////// static ////////////////////////////////////////		
	
		/**
		 * static function to create a backgroun sound
		 * @usage		var _SoundLite:SoundLite = SoundLite.create ('mp3/donuts_music_loop.mp3'); 
		 * 
		 * @param	$fileURL		location of mp3 file (example: 'mp3/foobar.mp3')
		 * @param	$vars			extra vars (like autoplay, ...)
		 */
		public static function create ($fileURL:String, $vars:Object = null ):SoundLite{
			return new SoundLite ($fileURL, $vars );
		}
		
		//////////////////////////////////////// Listener ////////////////////////////////////////
		
		
	} // end class
	
} // end package

