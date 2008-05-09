/**
* FLVPlayerLiteControllerButton (AS3), version 1.0
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
* @class  	: 	FLVPlayerLiteControllerButton
* @author 	:  	Matthijs C. Kamstra [mck]
* @version 	:	1.0 - class creation (AS3)
* @since 	:	23-4-2008 10:51 
* 
* Changelog:
*
* 		v1.0 [23-4-2008 10:51] - Initial release
*
*/
package nl.matthijskamstra.media {
	
	import flash.display.*;
	import flash.events.*;

	public class FLVPlayerLiteControllerButton {
		
		// Constants:
		public static var CLASS_REF = nl.matthijskamstra.media.FLVPlayerLiteControllerButton;
		public static var CLASS_NAME : String = "FLVPlayerLiteControllerButton";
		public static var LINKAGE_ID : String = "nl.matthijskamstra.media.FLVPlayerLiteControllerButton";
		// vars
		private var func:Function;
		private var vars:Array = [];
		
		/**
		 * Constructor
		 * 
		 * @param	$target
		 * @param	$func
		 * @param	$vars
		 * @param	$mouseEvent
		 */
		public function FLVPlayerLiteControllerButton( $target:Object , $func:Function , $vars:* = null , $mouseEvent:String = '' ) {
			if ($target == null) { return; }
			//trace ( '+ ' + LINKAGE_ID + ' class instantiated');	
			
			this.func = $func;
			if (typeof ($vars) == 'object') {
				this.vars = $vars || [];
			} else {
				this.vars.push ($vars)
			}
			
			var _btn_mc = $target;
			_btn_mc.buttonMode = true;	
			if ($mouseEvent == '') {
				_btn_mc.addEventListener (MouseEvent.CLICK, FLVPlayerLiteControllerButtonListener);
				//_btn_mc.addEventListener (MouseEvent.ROLL_OUT, FLVPlayerLiteControllerButtonListener);
			} else {
				_btn_mc.addEventListener (MouseEvent[$mouseEvent], FLVPlayerLiteControllerButtonListener);
			}
			
		}
		
		/////////////////////////////////////// Static ///////////////////////////////////////
		
		/**
		 * 
		 * @param	$target
		 * @param	$func
		 * @param	$vars
		 */
		static public function create ($target:Object , $func:Function , $vars:* = null , $mouseEvent:String = '' ):FLVPlayerLiteControllerButton {
			return new FLVPlayerLiteControllerButton($target, $func, $vars , $mouseEvent);
		}
		static public function onRelease ($target:Object , $func:Function , $vars:*=null ):FLVPlayerLiteControllerButton {
			return new FLVPlayerLiteControllerButton($target, $func, $vars , 'CLICK');
		}
		static public function onRollover ($target:Object , $func:Function , $vars:*= null ):FLVPlayerLiteControllerButton {
			return new FLVPlayerLiteControllerButton($target, $func, $vars , 'ROLL_OVER');
		}
		static public function onRollout ($target:Object , $func:Function , $vars:*= null ):FLVPlayerLiteControllerButton {
			return new FLVPlayerLiteControllerButton($target, $func, $vars , 'ROLL_OUT');
		}
		
		/////////////////////////////////////// Listener ///////////////////////////////////////
		
		private function FLVPlayerLiteControllerButtonListener(e:MouseEvent):void {
			this.func.apply(null, vars);
		}

		
	} // end class
	
} // end package
