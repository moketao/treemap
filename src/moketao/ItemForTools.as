package moketao
{
	import flash.display.Sprite;
    import flash.events.*;

    public class ItemForTools extends BgBase
    {
        private var txt:MySuperText;
        private var padx:Number;
        private var pady:Number;
        private var fontSize:int;
        private var color:uint;
        private var overColor:uint;
        public var bt:Bt;
        private var newWidth:Number;
        private var newHeight:Number;
        private var menu:Menu;
        public var centerX:Number;
        public var centerY:Number;
        public static var last:ItemForTools;

        public function ItemForTools(btid:String, padx:Number = 12, pady:Number = 2, fontSize:int = 14, color:uint = 5592405, overColor:uint = 12255232)
        {
            this.overColor = overColor;
            this.color = color;
            this.fontSize = fontSize;
            this.pady = pady;
            this.padx = padx;
            this.bt = Main.getBt(btid);
            addEventListener(Event.ADDED_TO_STAGE, this.init);
            return;
        }// end function

        private function init(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.init);
            this.reDraw();
            this.txt.doubleClickEnabled = true;
            bgSkin.doubleClickEnabled = true;
            addEventListener(MouseEvent.MOUSE_DOWN, this.on_down);
            addEventListener(MouseEvent.MOUSE_UP, this.on_up);
            addEventListener(MouseEvent.RIGHT_CLICK, this.on_right_click);
			setHasChildShow()
            return;
        }// end function
		private function setHasChildShow():void 
		{
			if (bt.data.subs.length > 0 ) 
			{
				var hasSubSprite:Sprite = new Sprite();
				addChild(hasSubSprite);
				hasSubSprite.x = 7;
				hasSubSprite.y = 8;
				var d:Number = 3;
				var dd:Number = d * 2;
				hasSubSprite.graphics.beginFill(0x00cc00, 1);
				hasSubSprite.graphics.drawRect(0, 0, d, dd);
				hasSubSprite.graphics.endFill();
				hasSubSprite.graphics.beginFill(0x00cc00, 1);
				hasSubSprite.graphics.drawRect(-d, d,dd,d);
				hasSubSprite.graphics.endFill();
			}
		}
        private function on_right_click(event:MouseEvent) : void
        {
            this.menu = new Menu();
            this.menu.add(new MenuItem("从【工具栏】移除", this.remove));
            this.parent.setChildIndex(this, (this.parent.numChildren - 1));
            this.menu.x = 0;
            this.menu.y = 25;
            addChild(this.menu);
            this.buttonMode = true;
            return;
        }// end function

        private function remove() : void
        {
            (this.parent.parent as ToolsMC).remove(this);
            return;
        }// end function

        private function on_up(event:MouseEvent) : void
        {
			setOn();
            stopDrag();
            this.bt.data.tool_pos_x = x;
            this.bt.data.tool_pos_y = y;
			
			Item.read_deep_array = Item.getDeepArray(bt);
			Bt.last = bt;
			Main.update_cont2();//★
            return;
        }// end function

        public function update_to_editer() : void
        {
            Editer.editer_for_nodes.txt1.txt.text = this.bt.data.title;
            Editer.editer_for_nodes.txt2.txt.text = this.bt.data.txt;
            return;
        }// end function

        public function setOn() : void
        {
            if (last)
            {
                last.off();
            }
            last = this;
            this.on();
            return;
        }// end function
		
        public function off() : void
        {
            this.txt.off();
            return;
        }// end function

        public function on() : void
        {
            this.txt.over();
            return;
        }// end function

        private function on_down(event:MouseEvent) : void
        {
            this.startDrag();
            return;
        }// end function

        public function reDraw() : void
        {
            if (this.txt)
            {
                removeChild(this.txt);
            }
            this.txt = new MySuperText(this.bt.data.title, this.fontSize, this.color, this.overColor);
            addChild(this.txt);
            this.resetSkin();
            return;
        }// end function

        public function resetSkin() : void
        {
            this.newWidth = this.txt.txtWidth + this.padx * 2;
            this.newHeight = this.txt.txtHeight + this.pady * 2;
            super.setBgSize(this.newWidth, this.newHeight);
            this.txt.x = this.newWidth / 2 - this.txt.txtWidth / 2;
            this.txt.y = this.newHeight / 2 - this.txt.txtHeight / 2 - 1;
            this.centerX = this.newWidth / 2;
            this.centerY = this.newHeight / 2;
            return;
        }// end function

    }
}
