package moketao
{
    import fl.controls.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class TxtResize extends BgBase
    {
        private var padx:Number;
        private var pady:Number;
        private var hander:ResizeHander;
        private var isDrag:Boolean = false;
        private var wuCha:Number;
        private var mover:MoveHander;
        public var items:Array;
        private var bt:Bt;
        public var txt:TextArea;

        public function TxtResize(padx:Number = 12, pady:Number = 2)
        {
            this.items = new Array();
            this.pady = pady;
            this.padx = padx;
            this.wuCha = 6 / 500;
            addEventListener(Event.ADDED_TO_STAGE, this.init);
            return;
        }// end function

        private function init(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.init);
            this.hander = new ResizeHander();
            addChild(this.hander);
            this.mover = new MoveHander();
            addChild(this.mover);
            this.mover.addEventListener(MouseEvent.MOUSE_DOWN, this.on_mover_down);
            this.mover.addEventListener(MouseEvent.MOUSE_UP, this.on_mover_up);
            this.hander.addEventListener(MouseEvent.MOUSE_DOWN, this.on_down);
            this.hander.addEventListener(MouseEvent.MOUSE_MOVE, this.on_move);
            this.hander.addEventListener(MouseEvent.MOUSE_UP, this.on_up);
            (bgSkin as MovieClip).alpha = 0.5;
            var _loc_2:* = new TextFormat();
            _loc_2.size = 14;
            this.txt = new TextArea();
            this.txt.x = 12;
            this.txt.y = 12;
            this.txt.setStyle("textFormat", _loc_2);
            this.txt.drawFocus(false);
            addChild(this.txt);
            this.setSize(300, 100);
            this.rePosHander();
            return;
        }// end function

        public function save() : void
        {
            return;
        }// end function

        public function getBtNow() : Bt
        {
            return Item.read_deep_array[(Item.read_deep_array.length - 1)] as Bt;
        }// end function

        private function on_mover_up(event:MouseEvent) : void
        {
            stopDrag();
            return;
        }// end function

        private function on_mover_down(event:MouseEvent) : void
        {
            this.startDrag();
            return;
        }// end function

        public function rePosHander() : void
        {
            this.hander.x = 0;
            this.hander.y = 0;
            this.hander.visible = false;
            this.hander.x = this.bgSkin.width - this.hander.width - width * this.wuCha;
            this.hander.y = this.bgSkin.height - this.hander.height - height * this.wuCha;
            this.hander.visible = true;
            return;
        }// end function

        private function on_up(event:MouseEvent) : void
        {
            this.isDrag = false;
            this.hander.stopDrag();
            this.resize();
            this.rePosHander();
            this.txt.visible = true;
            return;
        }// end function

        public function setSize(ww:Number, hh:Number) : void
        {
            setBgSize(ww, hh);
            this.rePosHander();
            this.reSizeTxt();
            return;
        }// end function

        public function reSizeTxt() : void
        {
            this.txt.width = bgSkin.width - 25 - height * this.wuCha * 1.8;
            this.txt.height = bgSkin.height - 32;
            this.mover.bg.width = this.txt.width;
            return;
        }// end function

        private function on_move(event:MouseEvent) : void
        {
            if (this.isDrag)
            {
                this.hander.startDrag();
                this.resize();
                this.txt.visible = false;
            }
            return;
        }// end function

        private function resize() : void
        {
            setBgSize(this.hander.x + this.hander.width + width * this.wuCha, this.hander.y + this.hander.height + height * this.wuCha);
            this.reSizeTxt();
            return;
        }// end function

        private function on_down(event:MouseEvent) : void
        {
            this.isDrag = true;
            return;
        }// end function

    }
}
