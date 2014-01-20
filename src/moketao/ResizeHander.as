package moketao
{
    import flash.display.*;

    public class ResizeHander extends Sprite
    {
        private var w:Number;
        private var lineColor:uint;

        public function ResizeHander()
        {
            this.w = 20;
            this.lineColor = 10066329;
            this.draw();
            return;
        }// end function

        private function draw() : void
        {
            graphics.beginFill(0, 0.01);
            graphics.drawRect(0, 0, this.w, this.w);
            graphics.endFill();
            graphics.lineStyle(1, this.lineColor, 1);
            graphics.moveTo(this.w, 0);
            graphics.lineTo(0, this.w);
            graphics.lineStyle(1, this.lineColor, 1);
            graphics.moveTo(this.w, 0 + 4);
            graphics.lineTo(0 + 4, this.w);
            graphics.lineStyle(1, this.lineColor, 1);
            graphics.moveTo(this.w, 0 + 8);
            graphics.lineTo(0 + 8, this.w);
            graphics.lineStyle(1, this.lineColor, 0.8);
            graphics.moveTo(this.w, 0 + 12);
            graphics.lineTo(0 + 12, this.w);
            graphics.lineStyle(1, this.lineColor, 0.8);
            graphics.moveTo(this.w, 0 + 16);
            graphics.lineTo(0 + 16, this.w);
            return;
        }// end function

    }
}
