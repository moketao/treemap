package moketao
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class Box extends Sprite
    {
        private var _xx:Number;
        private var _yy:Number;
        private var _ww:Number;
        private var _hh:Number;
        private var _color:uint;
        private var _theAlpha:Number;

        public function Box(xx:Number = 20, yy:Number = 20, ww:Number = 20, hh:Number = 20, color:uint = 6710886, theAlpha:Number = 1)
        {
            this._theAlpha = theAlpha;
            this._color = color;
            this._hh = hh;
            this._ww = ww;
            this._yy = yy;
            this._xx = xx;
            addEventListener(Event.ADDED_TO_STAGE, this.init);
            return;
        }// end function

        private function init(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.reDraw);
            this.reDraw();
            return;
        }// end function

        private function reDraw(rect:Rectangle = null) : void
        {
            if (rect)
            {
                this._xx = rect.x;
                this._yy = rect.y;
                this._ww = rect.width;
                this._hh = rect.height;
            }
            graphics.clear();
            graphics.beginFill(this.color, this.theAlpha);
            graphics.drawRect(0, 0, this.ww, this.hh);
            graphics.endFill();
            this.x = this.xx;
            this.y = this.yy;
            return;
        }// end function

        public function get xx() : Number
        {
            return this._xx;
        }// end function

        public function set xx(value:Number) : void
        {
            this._xx = value;
            this.reDraw();
            return;
        }// end function

        public function get yy() : Number
        {
            return this._yy;
        }// end function

        public function set yy(value:Number) : void
        {
            this._yy = value;
            this.reDraw();
            return;
        }// end function

        public function get ww() : Number
        {
            return this._ww;
        }// end function

        public function set ww(value:Number) : void
        {
            this._ww = value;
            this.reDraw();
            return;
        }// end function

        public function get hh() : Number
        {
            return this._hh;
        }// end function

        public function set hh(value:Number) : void
        {
            this._hh = value;
            this.reDraw();
            return;
        }// end function

        public function get color() : uint
        {
            return this._color;
        }// end function

        public function set color(value:uint) : void
        {
            this._color = value;
            this.reDraw();
            return;
        }// end function

        public function get theAlpha() : Number
        {
            return this._theAlpha;
        }// end function

        public function set theAlpha(value:Number) : void
        {
            this._theAlpha = value;
            this.reDraw();
            return;
        }// end function

    }
}
