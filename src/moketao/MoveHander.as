package moketao
{
    import flash.display.*;

    public class MoveHander extends Sprite
    {
        private var w:Number;
        private var lineColor:uint;
        public var bg:Sprite;

        public function MoveHander()
        {
            this.w = 20;
            this.lineColor = 10066329;
            this.bg = new Sprite();
            addChild(this.bg);
            this.draw();
            return;
        }// end function

        private function draw() : void
        {
            this.bg.graphics.beginFill(0, 0.01);
            this.bg.graphics.drawRect(0, 0, this.w, this.w);
            this.bg.graphics.endFill();
            graphics.beginFill(16777215, 1);
            graphics.drawCircle(8, 8, 4);
            graphics.endFill();
            graphics.beginFill(14540253, 1);
            graphics.drawCircle(6, 6, 4);
            graphics.endFill();
            return;
        }// end function

    }
}
