package moketao
{
    import com.adobe.crypto.*;
	import com.adobe.utils.ArrayUtil;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class Bt extends BgBase implements ISave
    {
        public var txt:MySuperText;
        private var padx:Number;
        private var pady:Number;
        private var fontSize:int;
        private var color:uint;
        private var overColor:uint;
        private var newWidth:Number;
        private var newHeight:Number;
        private var selectMc:Sprite;
        public var LineMc:Sprite;
        public var data:INode;
        public var canMove:Boolean;
        private var _isSelect:Boolean;
        public var centerX:Number;
        public var centerY:Number;
        public var init_class:State_Sys;
        public var init_class0:State_Tree;
        public var init_class1:State_Menu;
        public var init_class2:State_Wind;
        public var state_name:String;
        public var state:State;
        private var menu:Menu;
        public static var classtype:int;
        public static var last:Bt;
        public static var state_mod_sys:String = "moketao.State_Sys";
        public static var state_mod_menu:String = "moketao.State_Menu";
        public static var state_mod_wind:String = "moketao.State_Wind";
        public static var state_mod_tree:String = "moketao.State_Tree";
        public static var DRAW_LINE:String = "draw_line";
        public static var drag_start:Point;

        public function Bt(title:String, isMove:Boolean = true, mod:String = "", saveID:String = "", saveFID:String = "", saveSUB:Array = null, padx:Number = 12, pady:Number = 2, fontSize:int = 14, color:uint = 10066329, overColor:uint = 12255232)
        {
            var _loc_12:Date = null;
            var _loc_13:Class = null;
            var _loc_14:Class = null;
            var _loc_15:Class = null;
            this.data = new INode();
            this.selectMc = new SelectMc();
            this.LineMc = new Sprite();
            addChildAt(this.LineMc, 0);
            addChild(this.selectMc);
            this.selectMc.visible = false;
            this.overColor = overColor;
            this.color = color;
            this.fontSize = fontSize;
            this.pady = pady;
            this.padx = padx;
            if (saveID == "")
            {
                _loc_12 = new Date();
                this.data.id = MD5.hash(_loc_12.getTime().toString() + title);
            }
            else
            {
                this.data.id = saveID;
            }
            this.data.title = title;
            this.data.txt = "";
            this.data.classtype = Bt.classtype;
            if (saveFID == "")
            {
                this.data.fid = "";
            }
            else
            {
                this.data.fid = saveFID;
            }
            if (saveSUB)
            {
                this.data.subs = saveSUB;
            }
            else
            {
                this.data.subs = new Array();
            }
            addEventListener(Event.ADDED_TO_STAGE, this.init);
            addEventListener(MouseEvent.ROLL_OVER, this.on_over);
            addEventListener(MouseEvent.ROLL_OUT, this.on_out);
            addEventListener(MouseEvent.MOUSE_DOWN, this.on_down);
            addEventListener(MouseEvent.MOUSE_MOVE, this.on_move);
            addEventListener(MouseEvent.MOUSE_UP, this.on_up);
            addEventListener(MouseEvent.RIGHT_CLICK, this.on_right_click);
            this.buttonMode = true;
            this.canMove = isMove;
            if (this.canMove)
            {
                Main.obArr.push(this);
                Main.update_objects_cache();
            }
            if (mod != "")
            {
                this.state_name = mod;
                _loc_13 = getDefinitionByName(this.state_name) as Class;
                this.state = new _loc_13(this);
            }
            else if (this.canMove)
            {
                _loc_14 = getDefinitionByName("moketao.State_Tree") as Class;
                this.state = new _loc_14(this);
            }
            else
            {
                _loc_15 = getDefinitionByName("moketao.State_Sys") as Class;
                this.state = new _loc_15(this);
            }
            return;
        }// end function

        private function on_right_click(event:MouseEvent) : void
        {
            this.menu = new Menu();
            this.menu.add(new MenuItem("添加到【工具栏】", this.add2tools));
            this.menu.x = 0;
            this.menu.y = 25;
            addChild(this.menu);
            return;
        }// end function

        public function add2tools() : void
        {
            Main.tools.add(this.data.id);
            return;
        }// end function

        public function del() : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:String = null;
            var _loc_6:Bt = null;
            var _loc_7:Bt = null;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:String = null;
            WinResize.removeBt(this.data.id);
            var _loc_1:* = Main.obArr.length;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                if (Main.obArr[_loc_2] === this)
                {
                    _loc_3 = this.data.subs.length;
                    if (_loc_3 > 0)
                    {
                        _loc_4 = 0;
                        while (_loc_4 < _loc_3)
                        {
                            
                            _loc_5 = this.data.subs[_loc_4];
                            _loc_6 = Main.objects[_loc_5] as Bt;
                            if (_loc_6)
                            {
                                _loc_6.data.fid = "";
                                _loc_6.LineMc.graphics.clear();
                            }
                            _loc_4 = _loc_4 + 1;
                        }
                    }
                    if (this.data.fid)
                    {
                        _loc_7 = Main.objects[this.data.fid] as Bt;
                        _loc_8 = _loc_7.data.subs.length;
                        _loc_9 = 0;
                        while (_loc_9 < _loc_8)
                        {
                            
                            _loc_10 = _loc_7.data.subs[_loc_9];
                            if (_loc_10 == this.data.id)
                            {
                                _loc_7.data.subs.splice(_loc_9, 1);
                                break;
                            }
                            _loc_9 = _loc_9 + 1;
                        }
                    }
                    Main.obArr.splice(_loc_2, 1);
                    Editer.editer_for_nodes.clear();
                    this.parent.removeChild(this);
                    removeEventListener(MouseEvent.ROLL_OVER, this.on_over);
                    removeEventListener(MouseEvent.ROLL_OUT, this.on_out);
                    removeEventListener(MouseEvent.MOUSE_DOWN, this.on_down);
                    removeEventListener(MouseEvent.MOUSE_UP, this.on_up);
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function reDrawSon(id:String, index:int) : void
        {
            this.data.subs.splice(index, 1);
            var _loc_3:* = Main.getBt(id);
            _loc_3.data.fid = Main.root_bt.data.id;
            Main.root_bt.data.subs.push(_loc_3.data.id);
            _loc_3.state.dispatchEvent(new Event(Bt.DRAW_LINE));
            return;
        }// end function

        public function get_save_ob() : INode
        {
            this.updata();
            return this.data;
        }// end function

        public function saveWinSize(w:Number, h:Number) : void
        {
            var _loc_3:* = this.data.win;
            _loc_3.w = w;
            _loc_3.h = h;
            return;
        }// end function

        public function getWinSize() : Point
        {
            var _loc_1:* = new Point();
            _loc_1.x = this.data.win.w;
            _loc_1.y = this.data.win.h;
            return _loc_1;
        }// end function

        public function saveWinPosition(xx:Number, yy:Number) : void
        {
            var _loc_3:* = this.data.win;
            _loc_3.x = xx;
            _loc_3.y = yy;
            return;
        }// end function

        public function getWinPosition() : Point
        {
            var _loc_1:* = new Point();
            _loc_1.x = this.data.win.x;
            _loc_1.y = this.data.win.y;
            return _loc_1;
        }// end function

        public function updata() : void
        {
            this.data.x = this.x;
            this.data.y = this.y;
            this.data.mod = this.state_name;
            this.fixDeep();
            return;
        }// end function

		public function fixDeep():void 
		{
			//调整父子叠加深度，父在上。
			var the_cont:DisplayObjectContainer = parent as DisplayObjectContainer;
			var the_f:Bt = Main.objects[data.fid] as Bt;
			if (the_cont && the_f)
			{
				var f_index:int = the_cont.getChildIndex(the_f);
				var sub_index:int = the_cont.getChildIndex(this);
				if (sub_index>f_index) 
				{
					the_cont.addChildAt(this, f_index);
				}
				state.dispatchEvent(new Event(Bt.DRAW_LINE));//画线			
			}
		}

        private function on_move(event:MouseEvent) : void
        {
            return;
        }// end function

        private function on_up(event:MouseEvent) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:Bt = null;
            this.on();
            this.alpha = 1;
            if (this.canMove)
            {
                stopDrag();
				if (ArrayUtil.arrayContainsValue(Main.edit_mod_select_bts_arr,this) ) callAllSelectBtToMove();
				if (last && last!=this)
				{
					last.off();
				}
                last = this;
                this.update_to_editer();
                this.state.dispatchEvent(new Event(DRAW_LINE));
                _loc_2 = this.data.subs.length;
                if (_loc_2 > 0)
                {
                    _loc_3 = 0;
                    while (_loc_3 < _loc_2)
                    {
                        
                        _loc_4 = Main.objects[this.data.subs[_loc_3]] as Bt;
                        _loc_4.state.dispatchEvent(new Event(DRAW_LINE));
                        _loc_3 = _loc_3 + 1;
                    }
                }
            }
            return;
        }// end function
		public function callAllSelectBtToMove():void 
		{
			if (drag_start) 
			{
				var dragEnd:Point = new Point(parent.mouseX, parent.mouseY);
				var d:Point = new Point(dragEnd.x-drag_start.x,dragEnd.y-drag_start.y);
				var len:int = Main.edit_mod_select_bts_arr.length;
				for (var i:int = 0; i < len; i++) 
				{
					var bbb:Bt = Main.edit_mod_select_bts_arr[i] as Bt;
					if (bbb&&bbb!=this)
					{
						bbb.x += d.x;
						bbb.y += d.y;
						bbb.reDrawAllLine();
					}
				}				
			}

		}		
		public function reDrawAllLine():void 
		{
            var len:int = 0;
            var i:int = 0;
            var bbbb:Bt = null;
			this.state.dispatchEvent(new Event(DRAW_LINE));
			len = this.data.subs.length;
			if (len > 0)
			{
				i = 0;
				while (i < len)
				{
					
					bbbb = Main.objects[this.data.subs[i]] as Bt;
					bbbb.state.dispatchEvent(new Event(DRAW_LINE));
					i = i + 1;
				}
			}
		}

        public function f_fix(fix_id:String) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.data.subs.length)
            {
                
                if (this.data.subs[_loc_2] == fix_id)
                {
                    this.data.subs.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function update_to_editer() : void
        {
            Editer.editer_for_nodes.txt1.txt.text = this.data.title;
            Editer.editer_for_nodes.txt2.txt.text = this.data.txt;
            return;
        }// end function

        private function on_down(event:MouseEvent) : void
        {
            this.off();
            this.alpha = 0.6;
            if (this.canMove)
            {
                startDrag();
				drag_start = new Point(this.parent.mouseX, this.parent.mouseY);
            }
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

        private function on_out(event:MouseEvent) : void
        {
            if (this.canMove)
            {
                if (last != this)
                {
                    this.off();
                }
            }
            else
            {
                this.off();
            }
            return;
        }// end function

        private function on_over(event:MouseEvent) : void
        {
            this.on();
            this.state.dispatchEvent(event);
            return;
        }// end function

        private function init(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.init);
            this.reDraw();
            return;
        }// end function

        public function reDraw() : void
        {
            this.updata();
            if (this.txt)
            {
                removeChild(this.txt);
            }
            this.txt = new MySuperText(this.data.title, this.fontSize, this.color, this.overColor);
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
            this.reSelectMc();
            this.centerX = this.newWidth / 2;
            this.centerY = this.newHeight / 2;
            return;
        }// end function

        public function select(mod:String = "") : void
        {
            if (mod == "")
            {
                if (this.selectMc.visible)
                {
                    this.selectMc.visible = false;
					ArrayUtil.removeValueFromArray(Main.edit_mod_select_bts_arr,this);
                }
                else
                {
                    this.selectMc.visible = true;
					if (!ArrayUtil.arrayContainsValue(Main.edit_mod_select_bts_arr,this)) Main.edit_mod_select_bts_arr.push(this);
                }
            }
            else if (mod == "on")
            {
                this.selectMc.visible = true;
				if (!ArrayUtil.arrayContainsValue(Main.edit_mod_select_bts_arr,this)) Main.edit_mod_select_bts_arr.push(this);
            }
            else
            {
                this.selectMc.visible = false;
				ArrayUtil.removeValueFromArray(Main.edit_mod_select_bts_arr,this);
            }
            return;
        }// end function

        private function reSelectMc() : void
        {
            this.selectMc.x = this.newWidth / 2;
            return;
        }// end function
        public function delayUnSelect() : void
        {
            setTimeout(select,50);
            return;
        }// end function
        public function get isSelect() : Boolean
        {
            return this.selectMc.visible;
        }// end function

        public function set isSelect(value:Boolean) : void
        {
            this.selectMc.visible = value;
            return;
        }// end function

    }
}
