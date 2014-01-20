package moketao
{
    import flash.display.*;
    import flash.events.*;

    public class State_Tree extends State
    {
        private var Line:Graphics;
        public var bt:Bt;

        public function State_Tree(_bt:Bt)
        {
            this.bt = _bt;
            addEventListener(MouseEvent.ROLL_OVER, this.on_over);
            addEventListener(Bt.DRAW_LINE, this.on_up);
            return;
        }// end function

        private function on_up(event:Event) : void
        {
            this.drawLine();
            return;
        }// end function

        public function drawLine() : void
        {
            var _loc_1:Number = NaN;
            var _loc_2:Number = NaN;
            var _loc_3:Bt = null;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_9:Number = NaN;
            var _loc_10:Number = NaN;
            var _loc_11:Number = NaN;
            var _loc_12:Number = NaN;
            this.Line = (this.bt.LineMc as Sprite).graphics;
            this.Line.clear();
            if (this.bt.data.fid)
            {
            }
            if (this.bt.data.fid != Main.root_bt.data.id)
            {
                _loc_1 = this.bt.x + this.bt.centerX;
                _loc_2 = this.bt.y + this.bt.centerY;
                _loc_3 = Main.objects[this.bt.data.fid] as Bt;
                if (_loc_3)
                {
                    _loc_4 = _loc_3.x + _loc_3.centerX;
                    _loc_5 = _loc_3.y + _loc_3.centerY;
                    _loc_6 = _loc_4 - _loc_1;
                    _loc_7 = _loc_5 - _loc_2;
                    _loc_8 = Math.atan2(_loc_7, _loc_6);
                    _loc_9 = 10 * Math.cos(_loc_8 + 0.4);
                    _loc_10 = 10 * Math.sin(_loc_8 + 0.4);
                    _loc_11 = 10 * Math.cos(_loc_8 - 0.4);
                    _loc_12 = 10 * Math.sin(_loc_8 - 0.4);
                    this.Line.lineStyle(1, 0, 0.3);
                    this.Line.moveTo(this.bt.centerX, this.bt.centerY);
                    this.Line.lineTo(_loc_6 + this.bt.centerX, _loc_7 + this.bt.centerY);
                    this.Line.moveTo(this.bt.centerX + _loc_6 / 2, this.bt.centerY + _loc_7 / 2);
                    this.Line.lineTo(this.bt.centerX + _loc_6 / 2 + _loc_9, this.bt.centerY + _loc_7 / 2 + _loc_10);
                    this.Line.moveTo(this.bt.centerX + _loc_6 / 2, this.bt.centerY + _loc_7 / 2);
                    this.Line.lineTo(this.bt.centerX + _loc_6 / 2 + _loc_11, this.bt.centerY + _loc_7 / 2 + _loc_12);
                }
            }
            return;
        }// end function

        private function on_over(event:MouseEvent) : void
        {
            return;
        }// end function

    }
}
