package moketao
{
    import flash.events.*;

    public class State_Wind extends State
    {

        public function State_Wind(_bt:Bt)
        {
            addEventListener(MouseEvent.ROLL_OVER, this.on_over);
            return;
        }// end function

        private function on_over(event:MouseEvent) : void
        {
            return;
        }// end function

    }
}
