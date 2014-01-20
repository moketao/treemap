package moketao
{
    import flash.events.*;
    import flash.utils.*;

    public class Menu extends BgBase
    {
        private var settime:uint;
        public var isIn:Boolean = false;
        public var isOut:Boolean = false;
        public var items:Array;

        public function Menu()
        {
            this.items = new Array();
            addEventListener(MouseEvent.ROLL_OUT, this.on_rollout);
            addEventListener(MouseEvent.ROLL_OVER, this.on_rollover);
            setBgSkin(new Win03());
            this.settime = setTimeout(this.delayKill, 2500);
            return;
        }// end function

        public function add(item:MenuItem) : void
        {
            this.items.push(item);
            this.reDraw();
            return;
        }// end function

        public function reDraw() : void
        {
            var _loc_5:MenuItem = null;
            var _loc_1:* = this.items.length;
            var _loc_2:Number = 0;
            var _loc_3:Number = 0;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_1)
            {
                
                _loc_5 = this.items[_loc_4] as MenuItem;
                addChild(_loc_5);
                _loc_5.x = 5;
                _loc_5.y = 5 + 20 * _loc_4;
                _loc_3 = _loc_5.y + 5 + 18 + 5;
                if (_loc_5.getWidth() > _loc_2)
                {
                    _loc_2 = _loc_5.getWidth();
                }
                _loc_4 = _loc_4 + 1;
            }
            setBgSize(_loc_2 + 10, _loc_3);
            return;
        }// end function

        private function delayKill() : void
        {
            if (!this.isIn)
            {
                this.killMe();
            }
            return;
        }// end function

        public function killMe() : void
        {
            clearTimeout(this.settime);
            if (hasEventListener(MouseEvent.ROLL_OUT))
            {
                removeEventListener(MouseEvent.ROLL_OUT, this.on_rollout);
            }
            if (hasEventListener(MouseEvent.ROLL_OVER))
            {
                removeEventListener(MouseEvent.ROLL_OVER, this.on_rollover);
            }
            if (parent)
            {
                parent.removeChild(this);
            }
            return;
        }// end function

        private function on_rollover(event:MouseEvent) : void
        {
            this.isIn = true;
            return;
        }// end function

        private function on_rollout(event:MouseEvent) : void
        {
            this.killMe();
            return;
        }// end function

    }
}
