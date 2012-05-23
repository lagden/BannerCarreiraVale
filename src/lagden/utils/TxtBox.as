package lagden.utils
{
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.StyleSheet;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import org.casalib.display.CasaTextField;
	
	public class TxtBox extends CasaTextField{
		
		public var nome:String         = "TxtBox";
		
		public function TxtBox(s:*="",asize:String="none",cor:uint=0x000000,t:uint=10,fonte:*="_sans",css:StyleSheet=null,a:String="left",anti:Boolean=true,letterSpacing:Number=0):void{
			
			// Trace nas fonts embedadas
			// var fonts:Array         = Font.enumerateFonts();
			// for (var i:int          = 0; i < fonts.length; i++) trace(fonts[i].fontName + " - " + fonts[i].fontStyle);
			
			var fmt:TextFormat         = new TextFormat();
			fmt.font                   = (typeof(fonte)=='string')?fonte:fonte.fontName;
			fmt.size                   = t;
			fmt.color                  = cor;
			//fmt.leading              = 1;
			fmt.align                  = a;
			fmt.letterSpacing          = letterSpacing;
			//
			this.defaultTextFormat     = fmt;
			this.embedFonts            = (typeof(fonte)!='string');
			//
			this.autoSize              = asize;
			this.mouseWheelEnabled     = false;
			this.selectable            = false;
			this.multiline             = true;
			this.wordWrap              = false;
			this.tabEnabled            = false;
			
			if(css!=null)this.styleSheet=css;
			
			if(anti)this.antiAliasType = AntiAliasType.ADVANCED;
			else this.antiAliasType    = AntiAliasType.NORMAL;
			
			// this.text                  = s;
			this.htmlText              = s;
		}
	}
}
