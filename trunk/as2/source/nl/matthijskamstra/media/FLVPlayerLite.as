
import mx.utils.Delegate;
import mx.transitions.OnEnterFrameBeacon;

/**
 * @author Slavomir Durej
 * ©2008 durej.com
 */
class nl.matthijskamstra.media.FLVPlayerLite {
	
	public static var version:Number = 0.1;
		
	// Constants:
	public static var CLASS_REF = nl.matthijskamstra.media.FLVPlayerLite;
	public static var CLASS_NAME : String = "FLVPlayerLite";
	public static var LINKAGE_ID : String = "nl.matthijskamstra.media.FLVPlayerLite";
	
	//compulsory vars passed via constructor
	private var fileURL				:String;			// flv file that is to be played
	private var target_mc			:MovieClip;			// target_mc is a movie clip that is wrapping video object
	
	//optional switches
	public var isLooping			:Boolean = false;	// enables video looping
	public var isAutostart			:Boolean = true;	// determines whether video is paused at the beginning
	public var isSoundOnStart		:Boolean = true;	// determines whether audio is muted at the begining
	
	//configurable public buffering values
	public var minBufferNumber		:Number = 2;		// default number of seconds of playback available before playing can start
	public var maxBufferNumber		:Number = 5;		// increased number of seconds for buffering after minBufferNumber is insufficient for continuous playback
	
	//loader properties
	public var isPlaying			:Boolean = false;	// determines whether playback is in progress
	public var nDuration			:Number;			// duration of the flv. Only available after and if metadata has been received
	public var isSoundOn			:Boolean = true;	// mute on / off status of the player
	
	//loader events
	public var onLoadProgress:Function;
	public var onPlayProgress:Function;
	public var onPlaybackFinished:Function;
	public var onError:Function;
	public var onMediaStart:Function;
	public var onMediaStop:Function;
	public var updateButtonStatus:Function;
	
	private var ncVideo:NetConnection;
	private var nsVideo:NetStream;
	private var videoObj_vid:Video;
	private var trackingEngine:Object;
	private var loadCheckingEngine:Object;
	
	private var flvAudio:MovieClip;
	private var movieSound:Sound;
	private var pausedOnce:Boolean = false;
	
	private var statusCode:String;
	
	/**
	* Constructor: create a lite FLV player
	* 
	* @usage   	import nl.matthijskamstra.media.FLVPlayerLite; // import
	*			var __FLVPlayerLite:FLVPlayerLite = new FLVPlayerLite ( this , 'flv/Final_Mov_Sequence.flv' );
	* 			(read comments in 'nl.matthijskamstra.media.FLVPlayerLite')
	* 
	* @param	$target_mc		a reference to a movie clip or object
	* @param	$url			path to FLV file (example: '../flv/foobar.flv')
	* @param	$obj			object with extra param (read mor about this in the comments on the top)
	*/
	function FLVPlayerLite($target_mc:MovieClip , $url:String, $obj:Object) {
		trace ( '+ ' + LINKAGE_ID + ' class instantiated');
		target_mc = ($target_mc == null) ? this : $target_mc;
			
		trace( "\t|\t - $target_mc : " + $target_mc );
		trace( "\t|\t - $url : " + $url );
		trace( "\t|\t - $obj : " + $obj );
		
		this.target_mc = $target_mc;
		this.fileURL = $url;
		this.videoObj_vid = $target_mc.videoObj;
		init();
	}
	
	private function init():Void{
		if(isSoundOnStart == undefined){
			isSoundOnStart = false;
		}
		OnEnterFrameBeacon.init();
		minBufferNumber = 2;
		maxBufferNumber = 15;
		ncVideo = new NetConnection();
		ncVideo.connect(null);
		nsVideo = new NetStream(ncVideo);
		nsVideo.play(fileURL);
		nsVideo.setBufferTime(minBufferNumber);
		nsVideo.onMetaData = Delegate.create(this, onNetStreamMetadata);
		nsVideo.onStatus = Delegate.create(this, onNetStreamStatus);
		nDuration = 0;
		//audio setup
		if(flvAudio == undefined){
			flvAudio = target_mc.createEmptyMovieClip("flvAudio", 8741);
		}
		flvAudio.attachAudio(nsVideo);
		movieSound = new Sound(flvAudio);
	}
	

	
	private function onNetStreamStatus(oStatus:Object):Void{
		statusCode = oStatus.code;
		//trace ("onNetStreamStatus statusCode"+statusCode+"   oStatus.level : "+oStatus.level);
		//------------------------------------------------------------------------ //when playhed reached the end rewind to beginning
		if(oStatus.level == "status" && statusCode == "NetStream.Play.Stop"){
			if(isLooping){
				rewToStart();
			} else {
				isPlaying = false;
				updateButtonStatus();
				onMediaStop();
			}
		}
		if(oStatus.level == "status" && statusCode == "NetStream.Play.Start"){
			if(! isSoundOnStart || ! isSoundOn){
				mute();
			}
			if(isAutostart){
				isPlaying = true;
				updateButtonStatus();
				onMediaStart();
			}
		}
		//-------------------------------------------------------------------------------- ERROR MANAGEMENT
		if(oStatus.level == "error"){
			onError("ERROR : " + statusCode);
		}
		//--------------------------------------------------------------------------------- DYNAMIC BUFFERING
		if(statusCode == "NetStream.Buffer.Full"){
			/*
			if (!isAutostart&& !pausedOnce) {
				pauseMedia();
				movieSound.setVolume(100);
				pausedOnce = true;
			}
			*/
			nsVideo.setBufferTime(maxBufferNumber);
		} else if(statusCode == "NetStream.Buffer.Empty"){
			nsVideo.setBufferTime(minBufferNumber);
		}
	}

	public function loadVideo():Void{
		videoObj_vid.attachVideo(nsVideo);
		startPlayheadTrackingEngine();
		startLoadCheckingEngine();
		if(! isAutostart){
			pauseMedia();
		} else {
			playMedia();
		}
	}
	
	
	/////////////////////////////////////// start :: FLVPlayerLite Controlers ///////////////////////////////////////
	
	
	// mute the sound
	public function mute():Void{
		if(isSoundOn){
			movieSound.setVolume(0);
			isSoundOn = false;
		} else {
			movieSound.setVolume(100);
			isSoundOn = true;
		}
		updateButtonStatus();
	}	
	
	public function playPauseToggle():Void{
		if(isPlaying){
			pauseMedia();
		} else {
			playMedia();
		}
	}
	
	public function pauseMedia():Void{
		nsVideo.pause(true);
		isPlaying = false;
		updateButtonStatus();
	}
	
	public function playMedia():Void{
		nsVideo.pause(false);
		isPlaying = true;
		updateButtonStatus();
	}
	
	public function rewToStart():Void{
		nsVideo.seek(0);
		pauseMedia();
		playMedia();
	}
	
	public function scrub(perc:Number):Void{
		var seekTime:Number = nDuration / 100 * perc;
		nsVideo.seek(seekTime);
	}

	
	/////////////////////////////////////// end :: FLVPlayerLite Controlers ///////////////////////////////////////
	
	
	private function onNetStreamMetadata(oMetaData:Object):Void{
		nDuration = oMetaData.duration;
		var vidWidth:Number = oMetaData.width;
		var vidHeight:Number = oMetaData.height;
		videoObj_vid._width = vidWidth;
		videoObj_vid._height = vidHeight;
	}
	
	function onFLVLoadProgress():Void{
		var totalBytes:Number = nsVideo.bytesTotal;
		var loadedBytes:Number = nsVideo.bytesLoaded;
		if(totalBytes > 4){
			var pctLoaded:Number = Math.floor(loadedBytes / totalBytes * 100);
			onLoadProgress(pctLoaded);
			if(pctLoaded >= 100){
				stopLoadCheckingEngine();
			}
		}
	}
	
	private function startLoadCheckingEngine():Void{
		loadCheckingEngine = new Object();
		loadCheckingEngine.onEnterFrame = Delegate.create(this, onFLVLoadProgress);
		MovieClip.addListener(loadCheckingEngine);
	}
	
	private function stopLoadCheckingEngine():Void{
		MovieClip.removeListener(loadCheckingEngine);
	}
	
	private function startPlayheadTrackingEngine():Void{
		trackingEngine = new Object();
		trackingEngine.onEnterFrame = Delegate.create(this, onPlayheadProgress);
		MovieClip.addListener(trackingEngine);
	}
	
	private function stopPlayheadTrackingEngine():Void{
		MovieClip.removeListener(trackingEngine);
	}
	
	function onPlayheadProgress():Void{
		var nPercent:Number = 100 * nsVideo.time / nDuration;
		onPlayProgress(Math.floor(nPercent));
	}
	
	/**
	 * kill every thing!!!
	 */	
	public function destroy():Void{
		stopPlayheadTrackingEngine();
		stopLoadCheckingEngine();
		nsVideo.close();
		ncVideo.close();
		videoObj_vid.clear();
	}
	
}
