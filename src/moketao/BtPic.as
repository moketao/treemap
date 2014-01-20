package moketao
{
    import flash.display.*;
    import flash.events.*;

    public class BtPic extends Sprite
    {
        private var padx:Number;
        private var pady:Number;
        private var fontSize:int;
        private var color:uint;
        private var overColor:uint;
        private var mc:MovieClip;

        public function BtPic(mc:MovieClip)
        {
            this.mc = mc;
            addEventListener(Event.ADDED_TO_STAGE, this.addMC);
            addEventListener(MouseEvent.ROLL_OVER, this.on_over);
            addEventListener(MouseEvent.ROLL_OUT, this.on_out);
            this.buttonMode = true;
            return;
        }// end function

        private function on_out(event:MouseEvent) : void
        {
            this.mc.gotoAndPlay("off");
            return;
        }// end function

        private function on_over(event:MouseEvent) : void
        {
            this.mc.gotoAndPlay("over");
            return;
        }// end function

        private function addMC(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.addMC);
            addChild(this.mc);
            return;
        }// end function

    }
}
