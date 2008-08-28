/**
* SoundMixerMain (AS3), version 1.0
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
* @class  	: 	SoundMixerMain
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

	public class SoundMixerMain extends MovieClip {
		
		// Constants:
		public static var CLASS_REF = nl.matthijskamstra.media.SoundMixerMain;
		public static var CLASS_NAME : String = "SoundMixerMain";
		public static var LINKAGE_ID : String = "nl.matthijskamstra.media.SoundMixerMain";
		// vars
		public static var targetObj:DisplayObjectContainer;	
		
		/**
		* Constructor
		* 
		* @usage   	import nl.matthijskamstra.media.SoundMixerMain; // import
		*			var __SoundMixerMain:SoundMixerMain = new SoundMixerMain ( this );
		* @param	$targetObj		a reference to a movie clip or object
		*/
		public function SoundMixerMain( $targetObj:DisplayObjectContainer = null ) {
			//trace ( '+ ' + LINKAGE_ID + ' class instantiated');
			targetObj = ($targetObj == null) ? this : $targetObj;
			initSoundMixerMain ( targetObj ) ;
		}
		
		//////////////////////////////////////// static ////////////////////////////////////////		

		/**
		* initSoundMixerMain used to jumpstart everything
		* 
		* @usage   	import nl.matthijskamstra.media.SoundMixerMain; // import
		*			var __SoundMixerMain:SoundMixerMain = new SoundMixerMain ();
		*			__SoundMixerMain.initSoundMixerMain( this );
		* @param	$targetObj		a reference to a movie clip or object
		*/
		public function initSoundMixerMain( $targetObj:DisplayObjectContainer ) {
			//trace( "SoundMixerMain.initSoundMixerMain > $targetObj : " + $targetObj );
			// var soundBG:SoundBg = SoundBg.create ("mp3/donuts_music_loop.mp3", { isAutoPlay:true, onProgress:onProgressHandler, onComplete:onCompleteHandler, onTag:onTagHandler } ); 
			
			var controllerMC = $targetObj.getChildByName ('bgSound_mc');
			var _sc:SoundController = new SoundController (controllerMC, "mp3/donuts_music_loop.mp3" , { loopTimes:2, autoPlay:false } );
			
			var controller1MC = $targetObj.getChildByName ('sound1_mc');
			var controller2MC = $targetObj.getChildByName ('sound2_mc');
			var controller3MC = $targetObj.getChildByName ('sound3_mc');
			var _sc1:SoundController = new SoundController (controller1MC, "mp3/donuts_loop_langzaam.mp3" , {  autoPlay:false} );
			var _sc2:SoundController = new SoundController (controller2MC, "mp3/donuts_loop_medium.mp3" , {  autoPlay:false } );
			var _sc3:SoundController = new SoundController (controller3MC, "mp3/donuts_loop_snel.mp3" , {  autoPlay:false  } );
			/**/
			
		}
		

		
		//////////////////////////////////////// Listener/Handler ////////////////////////////////////////
		
		private function onTagHandler($id3):void {
			trace( "SoundMixerMain.onTagHandler > $id3 : " + $id3 );
		}		
		
		private function onCompleteHandler():void {
			trace( "SoundMixerMain.onCompleteHandler" );
			
		}
		
		private function onProgressHandler(i):void {
			trace( "SoundMixerMain.onProgressFunc > i : " + i );
			
		}
		
		
		
		
	} // end class
	
} // end package
