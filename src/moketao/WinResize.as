package moketao
{
    import flash.display.*;
    import flash.events.*;

    public class WinResize extends BgBase
    {
        private var padx:Number;
        private var pady:Number;
        private var hander:ResizeHander;
        private var isDrag:Boolean = false;
        private var wuCha:Number;
        private var mover:MoveHander;
        public var bt:Bt;
        public var item_container:Sprite;
        private var winPrev:WinResize;
        private var winNext:WinResize;

        public function WinResize(bt_id:String, win_uper:WinResize, padx:Number = 12, pady:Number = 2)
        {
            this.item_container = new Sprite();
            this.bt = Main.getBt(bt_id);
            if (win_uper)
            {
                this.WinPrev = win_uper;
            }
            else
            {
                //trace("根节点win产生");
            }
            this.initUI();
            if (this.bt.getWinSize().x == 0)
            {
                this.setSize(300, 100);
            }
            else
            {
                this.setSize(this.bt.getWinSize().x, this.bt.getWinSize().y);
            }
			
			this.x = 18;
			this.y = Main.the_where_y+8;
			this.save();
			
            //if (this.bt.getWinPosition().x < 18 || this.bt.getWinPosition().y < 20 )
            //{
                //if (this.bt == Main.root_bt)
                //{
                    //this.x = 18;
                    //this.y = 82;
                    //this.save();
                //}
                //else
                //{
					//if (this.WinPrev) 
					//{
						//this.x = this.WinPrev.x;
						//this.y = this.WinPrev.y + this.WinPrev.bgSkin.height;						
					//}else {
						//this.x = 18;
						//this.y = 82;
						//this.save();
					//}
                //}
            //}else{
                //this.x = this.bt.getWinPosition().x;
                //this.y = this.bt.getWinPosition().y;
            //}
            this.addItemsFromBt(this.bt);
            addEventListener(Event.ADDED_TO_STAGE, this.init);
            return;
        }// end function

        private function initUI() : void
        {
            addChild(this.item_container);
            this.pady = this.pady;
            this.padx = this.padx;
            this.wuCha = 6 / 500;
            this.hander = new ResizeHander();
            addChild(this.hander);
            this.mover = new MoveHander();
            addChild(this.mover);
            this.mover.addEventListener(MouseEvent.MOUSE_DOWN, this.on_mover_down);
            this.mover.addEventListener(MouseEvent.MOUSE_UP, this.on_mover_up);
            this.hander.addEventListener(MouseEvent.MOUSE_DOWN, this.on_down);
            this.hander.addEventListener(MouseEvent.MOUSE_MOVE, this.on_move);
            this.hander.addEventListener(MouseEvent.MOUSE_UP, this.on_up);
            (bgSkin as MovieClip).alpha = 0.5;
            this.rePosHander();
            return;
        }// end function

        public function add(item:Item) : void
        {
            this.item_container.addChild(item);
            if (item.bt.data.read_pos_x > 0)
            {
                item.x = item.bt.data.read_pos_x;
                item.y = item.bt.data.read_pos_y;
            }
            else
            {
                item.x = 20 + 45 * Math.random();
                item.y = 30 + 25 * Math.random();
                item.bt.data.read_pos_x = item.x;
                item.bt.data.read_pos_y = item.y;
            }
            return;
        }// end function

        public function addItemsFromBt(abt:Bt) : void
        {
            var _loc_5:Item = null;
            var _loc_2:* = abt.data.subs;
            var _loc_3:* = _loc_2.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new Item(_loc_2[_loc_4]);
                this.add(_loc_5);
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        public function addItemsFromBtID(abtid:String) : void
        {
            this.addItemsFromBt(Main.getBt(abtid));
            return;
        }// end function

        public function getWinDataOb() : Object
        {
            return new Object();
        }// end function

        public function clearAllBt() : void
        {
            var _loc_1:* = this.getWinDataOb().bts;
            if (_loc_1)
            {
                _loc_1 = [];
            }
            while (this.item_container.numChildren)
            {
                
                this.item_container.removeChildAt(0);
            }
            return;
        }// end function

        public function reLayout() : void
        {
            return;
        }// end function

        private function init(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.init);
            return;
        }// end function

        public function save() : void
        {
            if (this.bt)
            {
                this.bt.saveWinPosition(this.x, this.y);
                this.bt.saveWinSize(bgSkin.width, bgSkin.height);
            }
            else
            {
                trace("★bt不存在.");
            }
            return;
        }// end function

        public function getBtNow() : Bt
        {
            return Item.read_deep_array[(Item.read_deep_array.length - 1)] as Bt;
        }// end function

        private function on_mover_up(event:MouseEvent) : void
        {
            stopDrag();
            this.save();
            return;
        }// end function

        private function on_up(event:MouseEvent) : void
        {
            this.isDrag = false;
            this.hander.stopDrag();
            this.resize();
            this.rePosHander();
            this.save();
            return;
        }// end function

        private function on_mover_down(event:MouseEvent) : void
        {
            this.startDrag();
            return;
        }// end function

        public function rePosHander() : void
        {
            this.hander.x = 0;
            this.hander.y = 0;
            this.hander.visible = false;
            this.hander.x = this.bgSkin.width - this.hander.width - width * this.wuCha;
            this.hander.y = this.bgSkin.height - this.hander.height - height * this.wuCha;
            this.hander.visible = true;
            this.mover.bg.width = bgSkin.width - 10;
            return;
        }// end function

        public function setSize(ww:Number, hh:Number) : void
        {
            setBgSize(ww, hh);
            this.rePosHander();
            return;
        }// end function

        private function on_move(event:MouseEvent) : void
        {
            if (this.isDrag)
            {
                this.hander.startDrag();
                this.resize();
            }
            return;
        }// end function

        private function resize() : void
        {
            setBgSize(this.hander.x + this.hander.width + width * this.wuCha, this.hander.y + this.hander.height + height * this.wuCha);
            return;
        }// end function

        private function on_down(event:MouseEvent) : void
        {
            this.isDrag = true;
            return;
        }// end function

        public function get WinPrev() : WinResize
        {
            return this.winPrev;
        }// end function

        public function get WinNext() : WinResize
        {
            return this.winNext;
        }// end function

        public function set WinNext(value:WinResize) : void
        {
            this.winNext = value;
            return;
        }// end function

        public function set WinPrev(value:WinResize) : void
        {
            if (value)
            {
                this.winPrev = value;
                this.winPrev.WinNext = this;
            }
            return;
        }// end function

        public function kill_and_NextWin() : void
        {
            if (this.WinNext)
            {
                this.WinNext.kill_and_NextWin();
                this.winPrev.WinNext = null;
            }
            if (parent)
            {
                parent.removeChild(this);
            }
            return;
        }// end function

        public function showNextWin(btid:String) : void
        {
            var _loc_3:WinResize = null;
            var _loc_4:Number = NaN;
            var _loc_5:Bt = null;
            var _loc_6:int = 0;
            var _loc_7:Bt = null;
            var _loc_8:Number = NaN;
            var _loc_2:* = Main.getBt(btid);
            if (_loc_2.data.subs.length > 0)
            {
                _loc_3 = new WinResize(btid, this);
                Main.themain.cont2.add(_loc_3);
                _loc_4 = 1000000;
                _loc_5 = Main.getBt(_loc_2.data.subs[0]);
                _loc_6 = 0;
                while (_loc_6 < _loc_2.data.subs.length)
                {
                    
                    _loc_7 = Main.getBt(_loc_2.data.subs[_loc_6]);
                    _loc_8 = Math.pow(_loc_7.data.read_pos_x, 2) + Math.pow(_loc_7.data.read_pos_y, 2);
                    if (_loc_8 < _loc_4)
                    {
                        _loc_4 = _loc_8;
                        _loc_5 = _loc_7;
                    }
                    _loc_6 = _loc_6 + 1;
                }
                if (_loc_5.data.subs.length > 0)
                {
                    _loc_3.showNextWin(_loc_5.data.id);
                }
            }
            return;
        }// end function

        public static function addBt(bt_id:String) : void
        {
            return;
        }// end function

        public static function removeBt(bt_id:String) : void
        {
            return;
        }// end function

    }
}
