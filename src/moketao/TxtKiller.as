package moketao
{
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class TxtKiller extends Object
    {
        private var txt:TextField;
        private var str:String;
        private var str_num:int;
        private var time:Timer;

        public function TxtKiller(txt:TextField, d_time:Number = 0.5)
        {
            this.str = txt.htmlText;
            this.txt = txt;
            this.str_num = this.str.length;
            var _loc_3:* = d_time / this.str_num * 1000;
            if (this.str_num != 0)
            {
                this.time = new Timer(_loc_3, this.str_num);
                this.time.addEventListener(TimerEvent.TIMER, this.action);
                this.time.addEventListener(TimerEvent.TIMER_COMPLETE, this.over);
                this.time.start();
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
                this.txt.text = "";
                this.time = null;
            }
            return;
        }// end function

        private function action(event:TimerEvent) : void
        {
            this.txt.htmlText = this.str.slice(0, this.str_num - this.time.currentCount);
            return;
        }// end function

        private function over(event:TimerEvent) : void
        {
            this.txt.htmlText = "";
            Debuger.txt_killer_now = null;
            return;
        }// end function

    }
}
