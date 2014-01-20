package moketao
{
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class TxtActioner extends Object
    {
        private var txt:TextField;
        private var str:String;
        private var str_num:int;
        private var time:Timer;

        public function TxtActioner(txt:TextField, str:String, delay:Number = 500, d_time:Number = 0.05)
        {
            this.str = str;
            this.txt = txt;
            this.str_num = str.length;
            var _loc_5:* = d_time / this.str_num * 1000;
            if (this.str_num != 0)
            {
                this.time = new Timer(_loc_5, this.str_num);
                this.time.addEventListener(TimerEvent.TIMER, this.action);
                this.time.addEventListener(TimerEvent.TIMER_COMPLETE, this.over);
                this.setDelay();
            }
            return;
        }// end function

        public function stop() : void
        {
            if (this.time)
            {
                this.time.stop();
                this.time.removeEventListener(TimerEvent.TIMER, this.action);
                this.time.removeEventListener(TimerEvent.TIMER_COMPLETE, this.over);
                this.txt.text = this.str;
                this.time = null;
            }
            return;
        }// end function

        private function setDelay() : void
        {
            if (this.time)
            {
                this.time.start();
            }
            return;
        }// end function

        private function action(event:TimerEvent) : void
        {
            this.txt.htmlText = this.str.slice(0, this.time.currentCount);
            return;
        }// end function

        private function over(event:TimerEvent) : void
        {
            this.txt.htmlText = this.str;
            Debuger.txt_actioner_now = null;
            return;
        }// end function

    }
}
