package moketao
{
    import flash.display.*;
    import flash.text.*;
    import flash.utils.*;

    public class Debuger extends MovieClip
    {
        private var _txt:TextField;
        private var _str:String;
        public static var clear_int:int;
        public static var txt_actioner_now:TxtActioner;
        public static var txt_killer_now:TxtKiller;

        public function Debuger()
        {
            this._txt = new TextField();
            addChild(this._txt);
            return;
        }// end function

        public function set txt(value:String) : void
        {
            if (txt_actioner_now)
            {
                txt_actioner_now.stop();
            }
            var _loc_2:* = new TextFormat();
            _loc_2.font = "Arial";
            _loc_2.size = 14;
            _loc_2.color = 30464;
            this._txt.defaultTextFormat = _loc_2;
            this._txt.autoSize = TextFieldAutoSize.LEFT;
            txt_actioner_now = new TxtActioner(this._txt, value);
            clear_int = setTimeout(this.kill, 4000);
            return;
        }// end function

        private function kill() : void
        {
            if (txt_killer_now)
            {
                txt_killer_now.stop();
            }
            txt_killer_now = new TxtKiller(this._txt);
            return;
        }// end function

    }
}
