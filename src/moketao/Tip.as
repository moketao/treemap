package moketao
{
    import flash.events.*;
    import flash.text.*;

    public class Tip extends BgBase
    {
        private var txt:TextField;
        public var f:TextFormat;
        public var PAD:Number = 3;

        public function Tip()
        {
            addEventListener(Event.ADDED_TO_STAGE, this.init);
            setBgSkin(new Win03());
            return;
        }// end function

        private function init(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.init);
            this.txt = new TextField();
            this.txt.x = this.PAD;
            this.txt.y = this.PAD;
            addChild(this.txt);
            return;
        }// end function

        public function setTXT(str:String, w:Number = 200) : void
        {
            this.f = new TextFormat();
            this.f.font = "Arial";
            this.f.size = 12;
            this.f.color = 6710886;
            this.txt.defaultTextFormat = this.f;
            this.txt.width = w;
            this.txt.autoSize = TextFieldAutoSize.LEFT;
            this.txt.wordWrap = true;
            this.txt.multiline = true;
            if (str == "")
            {
                this.txt.htmlText = "暂无详细内容";
            }
            else
            {
                this.txt.htmlText = str;
            }
            setBgSize(this.txt.width + this.PAD * 2, this.txt.height + this.PAD * 2);
            return;
        }// end function

    }
}
