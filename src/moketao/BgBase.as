package moketao
{
    import flash.display.*;
    import flash.geom.*;

    public class BgBase extends Sprite
    {
        private var ww:Number;
        private var hh:Number;
        public var bgSkin:*;
        private var xx:Number;
        private var yy:Number;
        public var mc:MovieClip;
        private var r:Number;

        public function BgBase(mc:MovieClip = null, r:Number = 10)
        {
            var _loc_3:MovieClip = null;
            this.r = r;
            this.mc = mc;
            this.yy = 0;
            this.xx = 0;
            this.hh = 50;
            this.ww = 50;
            if (!mc)
            {
                _loc_3 = new Win01();
                mc = _loc_3;
                this.setBgSkin(_loc_3);
            }
            else
            {
                this.setBgSkin(mc);
            }
            return;
        }// end function

        public function setBgSkin(skin:MovieClip) : void
        {
            if (this.bgSkin)
            {
                removeChild(this.bgSkin);
            }
            this.bgSkin = skin;
            this.bgSkin.scale9Grid = new Rectangle(this.r, this.r, skin.width - this.r * 2, skin.height - this.r * 2);
            this.setBgSize(this.ww, this.hh);
            this.setBgPos(this.xx, this.yy);
            addChild(this.bgSkin);
            return;
        }// end function

        public function setBgPos(px:Number, py:Number) : void
        {
            this.bgSkin.x = px;
            this.bgSkin.y = py;
            return;
        }// end function

        public function setBgSize(pw:Number, ph:Number) : void
        {
            this.bgSkin.width = pw;
            this.bgSkin.height = ph;
            return;
        }// end function

    }
}
