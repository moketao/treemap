package moketao
{
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;

    public class MySuperText extends Sprite
    {
        public var f:TextFormat;
        public var txt:TextField;
        private var _text:String;
        private var color:uint;
        private var bitmap:Bitmap;
        private var overColor:uint;
        private var centerTxtWidth:Number;
        private var isCenter:Boolean;
        private var fontSize:int;
        private var _txtWidth:Number;
        private var _txtHeight:Number;
        public var data:Object;

        public function MySuperText(str:String, fontSize:int = 12, color:uint = 3355443, overColor:uint = 6710886, isCenter:Boolean = false, centerTxtWidth:Number = 0)
        {
            this.centerTxtWidth = centerTxtWidth;
            this.fontSize = fontSize;
            this.isCenter = isCenter;
            this.overColor = overColor;
            this.color = color;
            this._text = str;
            this.create();
            return;
        }// end function

        private function create() : void
        {
            this.bitmap = new Bitmap();
            addChild(this.bitmap);
            this.txt = new TextField();
            this.txt.selectable = false;
            this.txt.htmlText = this._text;
            this.f = new TextFormat();
            this.f.font = "Arial";
            this.f.size = this.fontSize;
            this.f.color = this.color;
            if (this.centerTxtWidth)
            {
                this.txt.width = this.centerTxtWidth;
            }
            if (this.isCenter)
            {
                this.f.align = TextFormatAlign.CENTER;
                this.txt.autoSize = TextFieldAutoSize.CENTER;
            }
            else
            {
                this.txt.autoSize = TextFieldAutoSize.LEFT;
            }
            this.txt.defaultTextFormat = this.f;
            addChild(this.txt);
            this.reset(this._text);
            return;
        }// end function

        public function reset(string:String = null) : void
        {
            var _loc_2:BitmapData = null;
            this.txt.defaultTextFormat = this.f;
            if (string != null)
            {
                this.txt.htmlText = string;
            }
            else
            {
                this.txt.htmlText = this._text;
            }
            this._txtWidth = this.txt.width;
            this._txtHeight = this.txt.height;
            if (this.centerTxtWidth)
            {
                _loc_2 = new BitmapData(this.centerTxtWidth, this._txtHeight, true, 0);
            }
            else
            {
                _loc_2 = new BitmapData(this._txtWidth, this._txtHeight, true, 0);
            }
            _loc_2.draw(this.txt);
            this.bitmap.bitmapData = _loc_2;
            this.bitmap.smoothing = true;
            this.txt.htmlText = "";
            return;
        }// end function

        public function over() : void
        {
            this.f.color = this.overColor;
            this.reset();
            return;
        }// end function

        public function off() : void
        {
            this.f.color = this.color;
            this.reset();
            return;
        }// end function

        public function get text() : String
        {
            return this._text;
        }// end function

        public function set text(value:String) : void
        {
            this._text = value;
            this.reset();
            return;
        }// end function

        public function get txtWidth() : Number
        {
            return this._txtWidth;
        }// end function

        public function get txtHeight() : Number
        {
            return this._txtHeight;
        }// end function

        public function getW() : Rectangle
        {
            return this.txt.getBounds(this);
        }// end function

    }
}
