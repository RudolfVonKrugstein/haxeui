package haxe.ui.toolkit.resources;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.utils.ByteArray;
import haxe.Resource;
import haxe.ui.toolkit.util.ByteConverter;
import openfl.Assets;
import format.SVG;

class ResourceManager {
	private static var _instance:ResourceManager;
	public static var instance(get, null):ResourceManager;
	private static function get_instance():ResourceManager {
		if (_instance == null) {
			_instance = new ResourceManager();
		}
		return _instance;
	}
	
	//******************************************************************************************
	// Instance methods/props
	//******************************************************************************************
	public function new() {
		
	}
	
	public function getXML(resourceId:String, locale:String = null):Xml {
		var text:String = getText(resourceId, locale);
		var xml:Xml = null;
		if (text != null) {
			xml = Xml.parse(text);
		}
		return xml;
	}
	
	public function getText(resourceId:String, locale:String = null):String {
		var str:String = Resource.getString(resourceId);
		if (str == null) {
			str = Assets.getText(resourceId);
		}
		return str;
	}

    public function getSVG(resourceId:String, locale:String = null) : SVG {
      var text:String = getText(resourceId, locale);
      var svg : SVG = null;
      if (text != null) {
        svg = new SVG(text);
      }
      return svg;
    }
	
	public function getBitmapData(resourceId:String, locale:String = null):BitmapData {
		if (resourceId == null || resourceId.length == 0) {
			return null;
		}
		
		var bmp:BitmapData = null;
		#if !(flash)
			var bytes:haxe.io.Bytes = Resource.getBytes(resourceId);
			if (bytes != null) {
				var ba:ByteArray = ByteConverter.fromHaxeBytes(bytes);
				var loader:Loader = new Loader();
				loader.loadBytes(ba);
				if (loader.content != null) {
					bmp = cast(loader.content, Bitmap).bitmapData;
				}
			} else {
				bmp = Assets.getBitmapData(resourceId, true);
			}
		#else
			bmp = Assets.getBitmapData(resourceId, true);
		#end
		return bmp;
	}
	
	public function reset():Void {
	}
}
