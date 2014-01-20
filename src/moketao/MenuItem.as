package moketao
{
    import flash.display.*;
    import flash.events.*;

    public class MenuItem extends Sprite
    {
        private var fun:Function;
        private var bt:MySuperText;
        public var title:String;

        public function MenuItem(title:String, fun:Function)
        {
            this.title = title;
            this.fun = fun;
            this.bt = new MySuperText(title);
            addChild(this.bt);
            this.addEventListener(MouseEvent.CLICK, this.on_click);
            this.addEventListener(MouseEvent.ROLL_OVER, this.on_over);
            this.addEventListener(MouseEvent.ROLL_OUT, this.on_out);
            return;
        }// end function

        private function on_out(event:MouseEvent) : void
        {
            this.bt.off();
            return;
        }// end function

        private function on_over(event:MouseEvent) : void
        {
            this.bt.over();
            return;
        }// end function

        private function on_click(event:MouseEvent) : void
        {
            this.fun();
            (this.parent as Menu).killMe();
            return;
        }// end function

        public function getWidth() : Number
        {
            return this.bt.txtWidth;
        }// end function

    }
}
