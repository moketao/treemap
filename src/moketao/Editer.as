package moketao
{
    import fl.managers.*;
    import flash.display.*;
    import flash.events.*;

    public class Editer extends Sprite
    {
        public var txt1:TxtResize;
        public var txt2:TxtResize;
        public var outFocus:Sprite;
        private var fm:FocusManager;
        public static var editer_for_nodes:Editer;

        public function Editer()
        {
            addEventListener(Event.ADDED_TO_STAGE, this.init);
            return;
        }// end function

        private function init(event:Event) : void
        {
            this.fm = new FocusManager(this);
            removeEventListener(Event.ADDED_TO_STAGE, this.init);
            addEventListener(MouseEvent.ROLL_OUT, this.on_input);
            this.txt1 = new TxtResize();
            addChild(this.txt1);
            this.txt1.y = 8;
            this.txt1.setSize(600, 100);
            this.txt1.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, this.on_focus);
            this.txt1.txt.addEventListener(TextEvent.TEXT_INPUT, this.on_input);
            this.txt1.txt.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, this.on_input);
            this.txt1.txt.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, this.on_input);
            this.txt1.txt.addEventListener(KeyboardEvent.KEY_DOWN, this.on_key_down);
            this.txt2 = new TxtResize();
            this.txt2.y = 120;
            addChild(this.txt2);
            this.txt2.setSize(600, 500);
            this.txt2.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, this.on_focus);
            this.txt2.txt.addEventListener(TextEvent.TEXT_INPUT, this.on_input);
            this.txt2.txt.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, this.on_input);
            this.txt2.txt.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, this.on_input);
            this.txt2.txt.addEventListener(KeyboardEvent.KEY_DOWN, this.on_key_down);
            this.outFocus = new Sprite();
            addChild(this.outFocus);
            return;
        }// end function

        private function on_key_down(event:KeyboardEvent) : void
        {
            if (event.keyCode == 83&&event.ctrlKey)
            {
                trace("ctrl + s");
                event.preventDefault();
            }
            return;
        }// end function

        private function on_focus(event:FocusEvent) : void
        {
            this.fm.setFocus(this.outFocus);
            return;
        }// end function

        private function on_input(event:Event) : void
        {
            this.update_to_node();
            return;
        }// end function

        public function update_to_node() : void
        {
			trace("更新----",Main.MOD,Math.random().toFixed(2),"Item.last",Item.last,"Item_for_tools.last",ItemForTools.last)
            if (Main.MOD == "read")
            {
                if (Item.last)
                {
					if (this.txt1.txt.text!="")
					{
						Item.last.bt.data.title = this.txt1.txt.text;
						Item.last.bt.data.txt = this.txt2.txt.text;
						Item.last.bt.updata();
						Item.last.bt.reDraw();
						Item.last.reDraw();
						if (ItemForTools.last && ItemForTools.last.bt == Item.last.bt ) 
						{
							ItemForTools.last.reDraw();
						}
					}else {
						Main.themain.debuger.txt = "★标题为空，不进行写入。"
					}
                }else {
					trace("★","ItemForTools.last:",ItemForTools.last)
					if (ItemForTools.last) {
						if (this.txt1.txt.text!="")
						{
							ItemForTools.last.bt.data.title = this.txt1.txt.text;
							ItemForTools.last.bt.data.txt = this.txt2.txt.text;
							ItemForTools.last.bt.updata();
							ItemForTools.last.bt.reDraw();
							ItemForTools.last.reDraw();
							if (Main.where_end) 
							{
								Main.where_end.reset(txt1.txt.text);
							}
						}
					}else {
						if (this.txt1.txt.text!="")
						{						
							var bt:Bt = Item.read_deep_array[Item.read_deep_array.length - 1] as Bt;
							bt.data.title = this.txt1.txt.text;
							bt.data.txt = this.txt2.txt.text;
							bt.updata();
							bt.reDraw();
							if (Main.where_end) 
							{
								Main.where_end.reset(txt1.txt.text);
							}	
						}
					}
				}
            }
            else if (Main.MOD == "edit")
            {
                if (Bt.last)
                {
					if (this.txt1.txt.text!="") 
					{					
						Bt.last.data.title = this.txt1.txt.text;
						Bt.last.data.txt = this.txt2.txt.text;
						Bt.last.updata();
						Bt.last.reDraw();
						Bt.last.on();
					}else {
						Main.themain.debuger.txt = "★标题为空，不进行写入。"
					}
                }
            }
            return;
        }// end function

        public function clear() : void
        {
            this.txt1.txt.text = "";
            this.txt2.txt.text = "";
            return;
        }// end function

    }
}
