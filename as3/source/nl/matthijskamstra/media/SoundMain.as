/**
* SoundMain (AS3), version 1.0
*
* Enter description here
*
* <pre>
*  ____                   _      ____ 
* |  __| _ __ ___    ___ | | __ |__  |
* | |   | '_ ` _ \  / __|| |/ /    | |
* | |   | | | | | || (__ |   <     | |
* | |__ |_| |_| |_| \___||_|\_\  __| |
* |____|                        |____|
* 
* </pre>
*
* @class  	: 	SoundMain
* @author 	:  	Matthijs C. Kamstra [mck]
* @version 	:	1.0 - class creation (AS3)
* @since 	:	28-8-2008 11:44 
*
* Changelog:
*
* 		v 1.0 [28-8-2008 11:44] - Initial release
*
* 
*/
package nl.matthijskamstra.media {
	
	import flash.display.*;
	import flash.events.*;	

	public class SoundMain extends MovieClip {
		
		// Constants:
		public static var CLASS_REF = nl.matthijskamstra.media.SoundMain;
		public static var CLASS_NAME : String = "SoundMain";
		public static var LINKAGE_ID : String = "nl.matthijskamstra.media.SoundMain";
		// vars
		public static var targetObj:DisplayObjectContainer;	
		private var bgSoundLiteController:SoundLiteController;
		private var _soundLiteMixer:SoundLiteMixer;
		
		/**
		* Constructor
		* 
		* @usage   	import nl.matthijskamstra.media.SoundMain; // import
		*			var __SoundMain:SoundMain = new SoundMain ( this );
		* @param	$targetObj		a reference to a movie clip or object
		*/
		public function SoundMain( $targetObj:DisplayObjectContainer = null ) {
			//trace ( '+ ' + LINKAGE_ID + ' class instantiated');
			targetObj = ($targetObj == null) ? this : $targetObj;
			initSoundMain ( targetObj ) ;
		}
		
		//////////////////////////////////////// static ////////////////////////////////////////		

		/**
		* initSoundMain used to jumpstart everything
		* 
		* @usage   	import nl.matthijskamstra.media.SoundMain; // import
		*			var __SoundMain:SoundMain = new SoundMain ();
		*			__SoundMain.initSoundMain( this );
		* @param	$targetObj		a reference to a movie clip or object
		*/
		public function initSoundMain( $targetObj:DisplayObjectContainer ) {
			//trace( "SoundMain.initSoundMain > $targetObj : " + $targetObj );
			// var soundBG:SoundLite = SoundLite.create ("mp3/donuts_music_loop.mp3", { isAutoPlay:true, onProgress:onProgressHandler, onComplete:onCompleteHandler, onTag:onTagHandler } ); 
			
			Button.onRelease (MovieClip($targetObj).soundBtn_mc , soundOnHandler );
			Button.onRelease (MovieClip($targetObj).soundOffBtn_mc , soundOffHandler);

			
			var controllerMC = $targetObj.getChildByName ('bgSound_mc');
			bgSoundLiteController = new SoundLiteController (controllerMC, "mp3/donuts_music_loop.mp3" , { loopTimes:2, autoPlay:false, onTag:onTagHandler } );
			
			var controller1MC = $targetObj.getChildByName ('sound1_mc');
			var controller2MC = $targetObj.getChildByName ('sound2_mc');
			var controller3MC = $targetObj.getChildByName ('sound3_mc');
			var _sc1:SoundLiteController = new SoundLiteController (controller1MC, "mp3/donuts_loop_langzaam.mp3" , {  autoPlay:false} );
			var _sc2:SoundLiteController = new SoundLiteController (controller2MC, "mp3/donuts_loop_medium.mp3" , {  autoPlay:false } );
			var _sc3:SoundLiteController = new SoundLiteController (controller3MC, "mp3/donuts_loop_snel.mp3" , {  autoPlay:false  } );
			/**/
			
			
			//_soundLiteMixer = new SoundLiteMixer (["mp3/donuts_loop_langzaam.mp3", "mp3/donuts_loop_medium.mp3", "mp3/donuts_loop_snel.mp3"]);
			_soundLiteMixer = new SoundLiteMixer (["mp3/donuts_loop_langzaam_01.mp3", "mp3/donuts_loop_langzaam_02.mp3", "mp3/donuts_loop_langzaam_03.mp3"]);
			
			
			Button.onRelease (MovieClip($targetObj).btn1_mc, soundMixerHandler, 0 );
			Button.onRelease (MovieClip($targetObj).btn2_mc, soundMixerHandler, 1 );
			Button.onRelease (MovieClip($targetObj).btn3_mc, soundMixerHandler, 2 );
			
			
		}
		
		private function soundMixerHandler($id:uint):void {
			trace( "SoundMain.soundMixerHandler > $id : " + $id );
			_soundLiteMixer.activateTrack ($id);
		}
		
		//////////////////////////////////////// Listener/Handler ////////////////////////////////////////		
		
		private function soundOffHandler():void {
			//trace( "SoundMain.soundOffHandler" );
			bgSoundLiteController.buttonActivateButton('pause');
		}
		
		private function soundOnHandler():void {
			//trace( "SoundMain.soundOnHandler" );
			bgSoundLiteController.buttonActivateButton('play');
		}
		
		
		
		private function onTagHandler($id3):void {
			trace( "SoundMain.onTagHandler > $id3 : " + $id3 );
			trace ("Artist: " + $id3.artist );
			trace ("Song name: " + $id3.songName );
			trace ("Album: " + $id3.album ); 
		}		
		
		private function onCompleteHandler():void {
			trace( "SoundMain.onCompleteHandler" );
			
		}
		
		private function onProgressHandler(i):void {
			trace( "SoundMain.onProgressFunc > i : " + i );
			
		}
		
		
		
		
	} // end class
	
} // end package
