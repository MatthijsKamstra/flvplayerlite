/**

FLVPlayerLite (AS3), version 0.1

<pre>
 ____                   _      ____ 
|  __| _ __ ___    ___ | | __ |__  |
| |   | '_ ` _ \  / __|| |/ /    | |
| |   | | | | | || (__ |   <     | |
| |__ |_| |_| |_| \___||_|\_\  __| |
|____|                        |____|

</pre>

@class  	: 	FLVPlayerLite
@author 	:  	Matthijs C. Kamstra [mck]
@version 	:	0.1 - class creation (AS3)
@since 		:	7-4-2008 17:07 


DESCRIPTION:
	FLV video is the native video format for Flash, and because of that probably the 
	most use video format on the internet (YouTube, Google Video).

	This FLV Player doesn't have all the features that you have when you use a Flash component, 
	but the basics: play, pause, mute. In the nearby future it will also have a playback bar, 
	loading progress and a dragable seek button (). 
	It is the basics that I use, and there for this FLV player will be lite. 
	
	I love the lite versions, because you can use in big OOP projects, but also in small (banners) project. 
	My favorite lite class is tweenlite (AS3) or AS2. Frequent Tweenlite users will recognize the syntax.

	So what is the difference between the Flash component and FLVPlayerLite? 
	Besides the restrictions I mentioned before (basic features) the SWF will be much "liter"
	
	Flash component: 52,0 KB (53.248 bytes) -- VS -- FLVPlayerLite: 4,00 KB (4.096 bytes)


ARGUMENTS:
	1) $targeObj: 	Target MovieClip (or any other object) where the FLVPlayerLite will be created
	2) $url: 		path to FLV file
	3) $obj: 		An object containing param that you want to use with the creation of the FLVPlayerLite, playing or ending of the FLV
						CREATION: 
							x					: set the FLVPlayerLite's x position
							y					: set the FLVPlayerLite's y position
							depth				: set the FLVPlayerLite's depth 
							name				: set the FLVPlayerLite's name
						PLAYING:
							autoPlay			: start automatic play (default true)
						SPECIAL PROPERTIES:
							onCuePoint			: If you'd like to call a function when a cuepoint is entered, use this. 
							onCuePointParams	: An array of parameters to pass the onCuePoint function (optional)
							onComplete			: If you'd like to call a function when the tween has finished, use this. 
							onCompleteParams	: An array of parameters to pass the onComplete function (optional)
							
EXAMPLES: 
	Load a .FLV on a timeline
		
		import nl.matthijskamstra.media.FLVPlayerLite; // import
		var __FLVPlayerLite:FLVPlayerLite = new FLVPlayerLite ( this, 'flv/foobar.flv' );
		
		or 
		
		FLVPlayerLite.create ( this, 'flv/foobar.flv' );
		
	Load a .FLV in a movieclip
		
		import nl.matthijskamstra.media.FLVPlayerLite; // import
		FLVPlayerLite.create ( flvContainer2_mc, 'flv/foobar.flv' );
		
		
	More controle over your .FLV
	but the flv doesn't start playing (autoPlay:false) unless you deside to, at the end of the flv (onComplete) a function (example: "flvOneOnComplete") is triggered
		
		import nl.matthijskamstra.media.FLVPlayerLite; // import
		var __FLVPlayerLite2:FLVPlayerLite = new FLVPlayerLite ( player1Container_mc, 'flv/foobar.flv', { autoPlay:false , onComplete:flvOneOnComplete } );
		private function flvOneOnComplete():void {
			//trace( ":: flvOneOnComplete ::");
		}
		
		
		
		
		var __FLVPlayerLite1 = new FLVPlayerLite ( Container_mc, 'flv/foobar.flv', { autoPlay:false , onComplete:flvOneOnComplete , onCuePoint:flvOnCuePoint} );
		private function flvOnCuePoint( $name:String, $time:Number, ...arg ):void {
			//trace( "|| flvOnCuePoint ||" );
			//trace( "$name : " + $name  + ' - '+ typeof ($name));
			//trace( "$time : " + $time + ' - '+ typeof ($time));
			for( var i:String in arg ) //trace( "key : " + i + ", value : " + arg[ i ] );
			switch ($name) {
				case 'foobar':
					trace('<< foobar >>');
					break;
				default:
					trace(">> " + $name);
			}
		}
		
		
		


NOTES:
	- this project is opensource: http://code.google.com/p/flvplayerlite/
	- 



CHANGELOG:
	
	v1.0 [7-4-2008] - Initial release
		
*/
package nl.matthijskamstra.media {
	
	import flash.display.*;
	import flash.events.*; 
	import flash.media.SoundTransform;
    import flash.media.Video;
	import flash.net.NetConnection;
    import flash.net.NetConnection;
    import flash.net.NetStream;

    public class FLVPlayerLite extends Sprite {
		
		public static var version:Number = 0.1;
		
		// Constants:
		public static var CLASS_REF = nl.matthijskamstra.media.FLVPlayerLite;
		public static var CLASS_NAME : String = "FLVPlayerLite";
		public static var LINKAGE_ID : String = "nl.matthijskamstra.media.FLVPlayerLite";
		// vars
		public static var targetObj:DisplayObjectContainer;	
		
		//compulsory vars passed via constructor
		//private var url				:String;			//flv file that is to be played
		private var fileURL				:String; 			//flv file that is to be played
		  
		//optional switches 
		public var isLooping			:Boolean = false;	//enables video looping
		public var isAutostart			:Boolean = true;	//determines whether video is paused at the beginning
		public var isSoundOnStart		:Boolean = true;	//determines whether audio is muted at the begining
		//public var isSoundOnStart		:Boolean = false;	//determines whether audio is muted at the begining
		
		//configurable public buffering values	
		public var minBufferNumber		:Number = 2;		//default number of seconds of playback available before playing can start
		public var maxBufferNumber		:Number = 15;		//increased number of seconds for buffering after minBufferNumber is insufficient for continuous playback
	
		//loader properties
		public var isPlaying			:Boolean = false;	//determines whether playback is in progress
		public var nDuration			:Number = 0;		//duration of the flv. Only available after and if metadata has been received
		public var isSoundOn			:Boolean = true;	//mute on / off status of the player
		
		public var ncVideo				:NetConnection;
		public var nsVideo				:NetStream;
		public var videoObj_vid			:Video;	
		static var trackingEngine		:Object;
		static var loadCheckingEngine	:Object;
		// extra object values 
		private var xPos				:Number = 0;
		private var yPos				:Number = 0;
		
		private var onComplete			:Function; 			//The function that should be triggered when this tween has completed
		private var onCompleteParams	:Array; 			//An array containing the parameters that should be passed to the this.onComplete when this tween has finished.
		private var onCuePoint			:Function; 			//The function that should be triggered when a cuepoint is entered
		private var onCuePointParams	:Array; 			//An array containing the parameters that should be passed to the this.onCuePoint when this tween has finished.
	
		//static var pausedOnce			:Boolean = false;

		/**
		* Constructor
		* 
		* @usage   	import nl.matthijskamstra.media.FLVPlayerLite; // import
		*			var __FLVPlayerLite:FLVPlayerLite = new FLVPlayerLite ( this , '../deploy/flv/Final_Mov_Sequence.flv' );
		* 
		* @param	$targetObj		a reference to a movie clip or object
		* @param	$url			path to FLV file
		* @param	$obj			object with extra param
		*/
		public function FLVPlayerLite( $targetObj:DisplayObjectContainer , $url:String, $obj:Object = null) {
			//trace ( '+ ' + LINKAGE_ID + ' class instantiated');
			targetObj = ($targetObj == null) ? this : $targetObj;
			
			//trace( "\t|\t - targetObj : " + targetObj.name );
			//trace( "\t|\t - $url : " + $url );
			//trace( "\t|\t - $obj : " + $obj );
			
			if ($obj != null) {
				if ($obj.autoPlay != null) {
					isAutostart = $obj.autoPlay;
				}
				if ($obj.autoLoop != null) {
					isLooping = $obj.autoLoop;
				}
				this.xPos = $obj.x;
				this.yPos = $obj.y;
				this.onComplete = $obj.onComplete;
				this.onCompleteParams = $obj.onCompleteParams || [];
				this.onCuePoint = $obj.onCuePoint;
				this.onCuePointParams = $obj.onCuePointParams || [];
			}
			
			this.fileURL = $url;
			
			this.videoObj_vid = new Video ();
			videoObj_vid.name = 'FLVPlayerLite'
			initFLVPlayerLite () ;
		}
		
		/**
		 * init
		 */
        public function initFLVPlayerLite( ):void {
            ncVideo = new NetConnection();
            ncVideo.addEventListener(NetStatusEvent.NET_STATUS, onNetStatusListener);
            ncVideo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorListener);
            ncVideo.connect(null);
        }
		
		/**
		 * mute the sound
		 */
		public function mute():void	{
			//trace( "\t|\t mute sound");
			var __SoundTransform:SoundTransform = new SoundTransform();
			if (isSoundOn){
				//trace ('no sound')
				__SoundTransform.volume = 0;
				nsVideo.soundTransform = __SoundTransform;
				isSoundOn = false;
			} else {
				//trace ('yes sound')
				__SoundTransform.volume = 1;
				nsVideo.soundTransform = __SoundTransform;
				isSoundOn = true;
			}
			//// updateButtonStatus();
		}
		
		/////////////////////////////////////// start :: FLVPlayerLite Controlers ///////////////////////////////////////
		
		public function playPauseToggle():void {
			//trace( "\t| :: playPauseToggle : " + playPauseToggle );
			if (isPlaying){
				pauseMedia();
			} else {
				playMedia();
			}
		}
		
		public function stopMedia ():void {
			//trace( "\t| :: isPlaying : " + isPlaying );
			if (isPlaying) {
				pauseMedia();
			}
		}
		
		public function pauseMedia():void {
			//trace( "\t| :: pauseMedia : " + pauseMedia );
			nsVideo.togglePause();
			isPlaying = false;
			// updateButtonStatus();
		}
		
		public function playMedia():void {
			//trace( "\t| :: playMedia : " + playMedia );
			nsVideo.togglePause();
			isPlaying = true;
			// updateButtonStatus();
		}
		
		public function rewToStart():void {
			//trace( "\t| :: rewToStart : " + rewToStart );
			nsVideo.seek(0);
			pauseMedia();
			playMedia();
		}
		
		public function rewToStartAndStop():void {
			//trace( "\t| :: rewToStart : " + rewToStart );
			nsVideo.seek(0);
			stopMedia()
		}	
		
		public function scrub(perc:Number):void	{
			//trace( "\t| :: scrub : " + scrub );
			var seekTime:Number = nDuration/100 * perc;
			nsVideo.seek(seekTime);		
		}
		
		public function seek($sec:Number):void	{
			//trace( "\t| :: scrub : " + scrub );
			nsVideo.seek($sec);		
		}

		/////////////////////////////////////// end :: FLVPlayerLite Controlers ///////////////////////////////////////
   
		/*
		public function loadVideo():void {
			videoObj_vid.attachVideo(nsVideo);
			startPlayheadTrackingEngine();
			startLoadCheckingEngine();
			
			if (!isAutostart){
				pauseMedia();
			} else {
				playMedia();
			}
		}*/
	
		private function connectStream():void {
			
			var customClient:Object = new Object();
			customClient.onCuePoint = onCuePointListener;
			customClient.onMetaData = onMetaDataListener;
			customClient.onPlayStatus = onPlayStatusListener;
			
            nsVideo = new NetStream(ncVideo);
            nsVideo.addEventListener(NetStatusEvent.NET_STATUS, onNetStatusListener);
            nsVideo.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			nsVideo.client = customClient;
           
			videoObj_vid.attachNetStream(nsVideo);
            nsVideo.play(fileURL);
            nsVideo.bufferTime = minBufferNumber;
			targetObj.addChild(videoObj_vid);
			
			if (!isAutostart) {
				//trace( "isAutostart : " + isAutostart );
				pauseMedia();
			} 
        }

		
		function onFLVLoadProgress () : void {
			var totalBytes:Number  	= nsVideo.bytesTotal;
			var loadedBytes:Number  = nsVideo.bytesLoaded;
			if (totalBytes > 4)	{
				var pctLoaded:Number = Math.floor(loadedBytes/totalBytes*100);
				//onLoadProgress(pctLoaded);
				if (pctLoaded >= 100) {
					// stopLoadCheckingEngine();
				}
			}
		}
	
		protected function startLoadCheckingEngine():void {
			/*
			loadCheckingEngine = new Object();
			loadCheckingEngine.onEnterFrame = onFLVLoadProgress;
			MovieClip.addListener(loadCheckingEngine);
			*/
		}
		
		protected function stopLoadCheckingEngine():void {
			//MovieClip.removeListener(loadCheckingEngine);
		}	
		
		
		protected function startPlayheadTrackingEngine():void {
			/*			
			trackingEngine = new Object();
			trackingEngine.onEnterFrame =onPlayheadProgress;
			MovieClip.addListener(trackingEngine);
			*/		
		}
		
		protected function stopPlayheadTrackingEngine():void{
			//MovieClip.removeListener(trackingEngine);
		}
		
		
		function onPlayheadProgress () : void {
			var nPercent:Number = 100 * nsVideo.time / nDuration;
			//	onPlayProgress(Math.floor(nPercent));
		}
	
		/**
		 * kill every thing!!!
		 */
		public function destroy():void {
			//trace( "\t| :: destroy : " + destroy );
			stopPlayheadTrackingEngine();
			stopLoadCheckingEngine();
			nsVideo.close();
			ncVideo.close();
			videoObj_vid.clear();
		}
		
		/////////////////////////////////////// Static ///////////////////////////////////////
		
		
		public static function create ( $targetObj:DisplayObjectContainer , $url:String, $obj:Object):FLVPlayerLite {
			return new FLVPlayerLite ($targetObj, $url, $obj);
		}
		
		
		/////////////////////////////////////// Listeners ///////////////////////////////////////
		
		private function onNetStatusListener(event:NetStatusEvent):void {
            
			var netStatusCode = event.info.code;
			var netStatusLevel = event.info.level;
			////trace ("\t|\t onNetStatusListener || event.info.code: '"+netStatusCode+"'\te.info.level : "+netStatusLevel);
			
			// STOND ER ALL
			switch (netStatusCode) {
				case "NetConnection.Connect.Success":
                    connectStream();
                    break;
                case "NetStream.Play.StreamNotFound":
					// ERROR MANAGEMENT
                    trace("Unable to locate video: '" + fileURL + "'");
                    break;
				case "NetStream.Play.Stop":
					// when playhed reached the end rewind to beginning
					//trace("\t| Stop [" + nsVideo.time.toFixed(3) + " seconds]");
					// //trace ('end?')
					if (this.onComplete != null) {
						this.onComplete.apply(null, this.onCompleteParams);
					}
					if (isLooping){
						rewToStart();
					} else {
						isPlaying = false;
						//// updateButtonStatus();
						//onMediaStop();
					}  
					break;
				case "NetStream.Play.Start":
					// Playback has started.
					//trace("\t| Start [" + nsVideo.time.toFixed(3) + " seconds]");

					if (!isSoundOnStart || !isSoundOn){
						mute();
					}
					if (isAutostart){
						isPlaying = true;
						//// updateButtonStatus();
						//onMediaStart();
					} 
					break;
				case "NetStream.Buffer.Full":
					// DYNAMIC BUFFERING
					// The buffer is full and the stream will begin playing.
					nsVideo.bufferTime = maxBufferNumber;
					break;
				case "NetStream.Buffer.Empty":
					//DYNAMIC BUFFERING
					/* 
					Data is not being received quickly enough to fill the buffer. 
					Data flow will be interrupted until the buffer refills, at which time a 
					NetStream.Buffer.Full message will be sent and the stream will begin playing again.
					*/
					nsVideo.bufferTime = minBufferNumber;
					break;			
				default:
					// //trace ('\t|\t\t|\t netStatusCode: ' + netStatusCode)
					//trace ("\t|\t onNetStatusListener || event.info.code: '"+netStatusCode+"'\te.info.level : "+netStatusLevel);
			}
		}
		
        private function onSecurityErrorListener(event:SecurityErrorEvent):void {
            //trace("\t|\t onSecurityErrorListener: " + event);
        }
        
        private function asyncErrorHandler(event:AsyncErrorEvent):void {
            // ignore AsyncErrorEvent events.
        }

		/**
		 * received metadata
		 */
		public function onMetaDataListener(info:Object):void {
			//trace("\t|\t onMetaDataListener :: duration = " + info.duration + "\t width = " + info.width + "\t height = " + info.height + "\t framerate = " + info.framerate + "\t --> fileURL : " + fileURL);
			// for( var i:String in info ) //trace( "key : " + i + ", value : " + info[ i ] );
			
			nDuration = info.duration;	
			
			var vidWidth:Number 	= info.width;
			var vidHeight:Number 	= info.height;
			
			videoObj_vid.width		= vidWidth;
			videoObj_vid.height 	= vidHeight;
			
		}
		
		public function onCuePointListener(info:Object):void {
			//trace("\t|\t onCuePointListener :: cuepoint: time = " + info.time + "\t  name = " + info.name + "\t  type = " + info.type);
			if (this.onCuePoint != null) {
				this.onCuePointParams = [];
				this.onCuePointParams.push(info.name);
				this.onCuePointParams.push(info.time);
				this.onCuePoint.apply(null, this.onCuePointParams);
			}
		}

		public function onPlayStatusListener(info:Object):void {
			//trace("t|\t onPlayStatusListener :: info" + info);
		    //trace("NetStream.onPlayStatus called");
			for (var prop in info) {
				//trace("\t"+prop+":\t"+info[prop]);
			}
			//trace("");
		}		
		
    } // end class
} // end package