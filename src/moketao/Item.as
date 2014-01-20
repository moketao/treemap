package moketao
{
	import flash.display.Sprite;
    import flash.events.*;
	import moketao.Bt;

    public class Item extends BgBase
    {
        public var txt:MySuperText;
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
        public var tip:Tip;
        public static var read_deep_array:Array = new Array();
        public static var last:Item;

        public function Item(btid:String, padx:Number = 12, pady:Number = 2, fontSize:int = 14, color:uint = 0x666666, overColor:uint = 0xaa0000)
        {
            this.tip = new Tip();
            this.overColor = overColor;
            this.color = color;
            this.fontSize = fontSize;
            this.pady = pady;
            this.padx = padx;
            this.buttonMode = true;
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
            addEventListener(MouseEvent.DOUBLE_CLICK, this.on_db_click);
            addEventListener(MouseEvent.ROLL_OVER, this.on_over);
            addEventListener(MouseEvent.ROLL_OUT, this.on_out);
            addEventListener(MouseEvent.MOUSE_DOWN, this.on_down);
            addEventListener(MouseEvent.MOUSE_UP, this.on_up);
            addEventListener(MouseEvent.RIGHT_CLICK, this.on_right_click);
			setHasChildShow();
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
            this.menu.add(new MenuItem("添加到【工具栏】", this.add2tools));
            this.parent.setChildIndex(this, (this.parent.numChildren - 1));
            this.menu.x = 0;
            this.menu.y = 25;
            addChild(this.menu);
            return;
        }// end function

        public function add2tools() : void
        {
            Main.tools.add(this.bt.data.id);
            return;
        }// end function

        public function getWin() : WinResize
        {
            return this.parent.parent as WinResize;
        }// end function

        private function on_up(event:MouseEvent) : void
        {
            stopDrag();
            this.bt.data.read_pos_x = this.x;
            this.bt.data.read_pos_y = this.y;
            this.setOn();
			
			Bt.last = bt;
			
            this.update_to_editer();
			
			if (!event.ctrlKey && !event.altKey && !event.shiftKey) 
			{
				Item.read_deep_array = getDeepArray(this.bt);
				Main.update_cont2();//★			
			}
            return;
        }// end function
		
		public static function getDeepArray(bb:Bt):Array 
		{
			Item.read_deep_array = [];
			Item.read_deep_array.push(bb);
			var fbb:Bt = Main.getBt(bb.data.fid);
			while (fbb) 
			{
				Item.read_deep_array.push(fbb);
				var abt:Bt = Main.getBt(fbb.data.fid);
				fbb = abt;
			}
			return Item.read_deep_array.reverse();
		}

        public function update_to_editer() : void
        {
            Editer.editer_for_nodes.txt1.txt.text = this.bt.data.title;
            Editer.editer_for_nodes.txt2.txt.text = this.bt.data.txt;
            return;
        }// end function

        public function setOn() : void
        {
            if (last && last != this )
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

        private function on() : void
        {
            this.txt.over();
            return;
        }// end function

        private function on_down(event:MouseEvent) : void
        {
            this.startDrag();
			setOn();
            return;
        }// end function

        private function on_out(event:MouseEvent) : void
        {
            this.tip.visible = false;
            return;
        }// end function

        private function on_over(event:MouseEvent) : void
        {
            return;
        }// end function

        private function on_db_click(event:MouseEvent) : void
        {
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
			if(this==last)on();
            this.resetSkin();
			//trace(this.bt.data.title)
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
