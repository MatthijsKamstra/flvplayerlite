/**
* FLVPlayerLiteControlerButton (AS3), version 1.0
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
* @class  	: 	FLVPlayerLiteControlerButton
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

	public class FLVPlayerLiteControlerButton {
		
		// Constants:
		public static var CLASS_REF = nl.matthijskamstra.media.FLVPlayerLiteControlerButton;
		public static var CLASS_NAME : String = "FLVPlayerLiteControlerButton";
		public static var LINKAGE_ID : String = "nl.matthijskamstra.media.FLVPlayerLiteControlerButton";
		// vars
		private var func:Function;
		private var vars:Array = [];
		
		/**
		 * Constructor
		 * 
		 * @param	$target
		 * @param	$func
		 * @param	$vars
		 */
		public function FLVPlayerLiteControlerButton( $target:Object , $func:Function , $vars:*=null ) {
			if ($target == null) { return; }
			//trace ( '+ ' + LINKAGE_ID + ' class instantiated');	
			
			this.func = $func;
			if (typeof ($vars) == 'object') {
				this.vars = $vars || [];
			} else {
				this.vars.push ($vars)
			}
			
			var ___debug_mc = $target;
			___debug_mc.buttonMode = true;
			___debug_mc.addEventListener (MouseEvent.CLICK, FLVPlayerLiteControlerButtonListener);
		}
		
		/////////////////////////////////////// Static ///////////////////////////////////////
		
		/**
		 * 
		 * @param	$target
		 * @param	$func
		 * @param	$vars
		 */
		static public function create ($target:Object , $func:Function , $vars:*=null ):FLVPlayerLiteControlerButton {
			return new FLVPlayerLiteControlerButton($target, $func, $vars);
		}
		
		/////////////////////////////////////// Listener ///////////////////////////////////////
		
		private function FLVPlayerLiteControlerButtonListener(e:MouseEvent):void {
			this.func.apply(null, vars);
		}

		
	} // end class
	
} // end package
