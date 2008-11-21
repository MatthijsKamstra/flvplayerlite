/**
SoundLink (AS3), version 1.1

<pre>
 ____                   _      ____ 
|  __| _ __ ___    ___ | | __ |__  |
| |   | '_ ` _ \  / __|| |/ /    | |
| |   | | | | | || (__ |   <     | |
| |__ |_| |_| |_| \___||_|\_\  __| |
|____|                        |____|

</pre>


@class  	: 	SoundLink
@author 	:  	Matthijs C. Kamstra [mck]
@version 	:	1.0 - class creation (AS3)
@since 		:	2-9-2008
 

DESCRIPTION:
	Load and controle a background sound

ARGUMENTS:
	1) $file		location of mp3 file (example: 'mp3/foobar.mp3')
	2)	$vars		An object containing param that you want to use with the creation of the SoundLink
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
		
		import nl.matthijskamstra.media.SoundLink; // import
		var _SoundLink:SoundLink = new SoundLink (new track2());
		
		or 
		
		var _SoundLink:SoundLink = SoundLink.create (new track2() ,{isAutoPlay:false} ); 

NOTES:
	- visit my website: http://www.MatthijsKamstra.nl/blog
	- some features descibed here will not be working
	- all your base are belong to us

CHANGELOG:

	v 1.0 [02-09-2008] - Initial release
		
*/
package nl.matthijskamstra.media {
	
	import flash.display.*;
	import flash.events.*;	
	// import gs.TweenLite;
	
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.utils.Timer;
	
	public class SoundLink extends SoundLite {
		
		// Constants:
		public static var CLASS_REF = nl.matthijskamstra.media.SoundLink;
		public static var CLASS_NAME : String = "SoundLink";
		public static var LINKAGE_ID : String = "nl.matthijskamstra.media.SoundLink";
		// vars
		
		public static var version:Number = 1.0;
		
//        public var positionTimer		:Timer;
		private var isSoundPlaying		:Boolean;		
		private var isTagSet			:Boolean		= false;	// preventing id3 tags to set twice		
		
		/**
		* Constructor: create a background sound
		* 
		* @usage 		import nl.matthijskamstra.media.SoundLink; // import
		*				var _SoundLink:SoundLink = new SoundLink ( new track2() );
		* @param	$file		linkage >> class name (linkage properties) (example: 'track2')
		* @param	$vars			extra vars (like autoplay, ...)
		*/
		public function SoundLink($file:* , $vars:Object = null) {
			//trace( "SoundLink.SoundLink > $file : " + $file + ", $vars : " + $vars );
			super (null); // start constructor but do nothing
			/*	
			var mySound:Sound = $file;
			var myChannel:SoundChannel = mySound.play(0, int.MAX_VALUE); 
			*/
			
			if ( $file == null ) { return; }
			
			if ($vars != null) {
				this.vars = $vars;
				if ($vars.autoPlay == false) { this.isAutoPlay = false; }
				if ($vars.loopTimes != null) { this.loopTimes = $vars.loopTimes; }
			}
			
            mySound = $file;
			
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
		
		//////////////////////////////////////// static ////////////////////////////////////////		
		
		/**
		 * static function to create a backgroun sound
		 * @usage		var _SoundLink:SoundLink = SoundLink.create ('mp3/donuts_music_loop.mp3'); 
		 * 
		 * @param	$file		location of mp3 file (example: 'mp3/foobar.mp3')
		 * @param	$vars			extra vars (like autoplay, ...)
		 */
		public static function create ($file:*, $vars:Object = null ):SoundLink{
			return new SoundLink ($file, $vars );
		}
		
		//////////////////////////////////////// Listener ////////////////////////////////////////
		
	
	} // end class
	
} // end package

