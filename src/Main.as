package 
{
    import flash.desktop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.text.*;
	import flash.utils.setTimeout;
    import moketao.*;

    public class Main extends Sprite
    {
        private var saveFile:File;
        private var iniFile:File;
        private var shadowFilter:DropShadowFilter;
        public var classArr:Array;
        public var cont:Sprite;
        public var cont2:Cont2;
        public var cont_mask:Sprite;
        public var cont2_mask:Sprite;
        private var dragBox:Sprite;
        private var isDrag:Boolean = false;
        private var dragBoxRect:Rectangle;
        private var is_mid_down:Boolean = false;
        private var editer:Editer;
        public var debuger:Debuger;
        public static var iniPath:String;
        private static const BT_TOP_Y:Number = 10;
		public static var where_end:MySuperText;
		private var last_mouse_down_time:Number;
		private var fz2_bt:Bt;
		private var fz_bt:Bt;
		private var rd_bt:Bt;
		private var edt_bt:Bt;
		private var add_bt:Bt;
		private var del_bt:Bt;
		private var preSavePath:String;
		private var pre_bt:Bt;
		public static var the_where_y:Number;
        public static var data:Object;
        public static var obArr:Array = new Array();
        public static var objects:Object = new Object();
        public static var tools:ToolsMC;
        public static var root_bt:Bt;
        public static var themain:Main;
        public static var MOD:String = "read";
        public static var edit_mod_select_bts_arr:Array = new Array();

        public function Main() : void
        {
			this.setIniFile("ini");
			if (!iniFile.exists ) {
				saveINI( { path:"" ,p:"234"} );
				trace(iniFile.nativePath)
			}
			setTimeout(checkHasPreFile,800)
            this.classArr = new Array();
            this.init();
            NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, this.app_invokeHandler);
            return;
        }// end function

        private function app_invokeHandler(e:InvokeEvent) : void
        {
			if (e.arguments.length > 0) {
				var thepath:String = e.arguments.toString();
				var f:File = new File(thepath);
				open(f);
				debuger.txt = "打开文件完成："+f.nativePath;
			}
        }// end function

        private function init() : void
        {
            themain = this;
            this.initClass();
            this.initUI();
            this.initData();
            return;
        }// end function

        private function initClass() : void
        {
            this.addClass(Bt);
            return;
        }// end function

        private function addClass(the_class:Class) : void
        {
            this.classArr.push(the_class);
            the_class.classtype = this.classArr.length - 1;
            return;
        }// end function

        private function initUI() : void
        {
            stage.addEventListener(KeyboardEvent.KEY_DOWN, this.on_key);
            var _loc_1:* = new BigBigBG();
            _loc_1.doubleClickEnabled = true;
            addChild(_loc_1);
            this.addShadow(_loc_1);
            _loc_1.mover.addEventListener(MouseEvent.MOUSE_DOWN, this.on_mover_down);
            _loc_1.addEventListener(MouseEvent.DOUBLE_CLICK, this.on_bigbigbg_db_click);
			
			
            add_bt = new Bt("添加节点", false);
            addChild(add_bt);
            add_bt.x = 9;
            add_bt.y = BT_TOP_Y;
            add_bt.addEventListener(MouseEvent.CLICK, this.on_bt_addnode);
			
            del_bt = new Bt("删除节点", false);
            addChild(del_bt);
            del_bt.x = 100;
            del_bt.y = BT_TOP_Y;
            del_bt.addEventListener(MouseEvent.CLICK, this.on_bt_delNode);
			
            edt_bt = new Bt("编辑模式", false);
            addChild(edt_bt);
            edt_bt.x = 705;
            edt_bt.y = BT_TOP_Y;
            edt_bt.addEventListener(MouseEvent.CLICK, this.on_bt_edit);
			
            rd_bt = new Bt("阅读模式", false);
            addChild(rd_bt);
            rd_bt.x = 800;
            rd_bt.y = BT_TOP_Y;
            rd_bt.addEventListener(MouseEvent.CLICK, this.on_bt_read);
			
            var _loc_6:* = new Bt("打开", false);
            addChild(_loc_6);
            _loc_6.x = 900;
            _loc_6.y = BT_TOP_Y;
            _loc_6.addEventListener(MouseEvent.CLICK, this.on_bt_open);
			
            var _loc_7:* = new Bt("保存", false);
            addChild(_loc_7);
            _loc_7.x = 965;
            _loc_7.y = BT_TOP_Y;
            _loc_7.addEventListener(MouseEvent.CLICK, this.on_bt_save);
			
            fz_bt = new Bt("建立父子关系", false);
            addChild(fz_bt);
            fz_bt.x = 300;
            fz_bt.y = BT_TOP_Y;
            fz_bt.addEventListener(MouseEvent.CLICK, this.on_bt_fz);
			
            fz2_bt = new Bt("解除父子关系", false);
            addChild(fz2_bt);
            fz2_bt.x = 420;
            fz2_bt.y = BT_TOP_Y;
            fz2_bt.addEventListener(MouseEvent.CLICK, this.on_bt_fz2);
			
            var _loc_10:* = new Bt("强行关闭不保存", false);
            addChild(_loc_10);
            _loc_10.x = 1085;
            _loc_10.y = BT_TOP_Y;
            _loc_10.addEventListener(MouseEvent.CLICK, this.on_bt_close_no_save);
            var _loc_11:* = new Bt("缩", false, "", "", "", null, 5);
            addChild(_loc_11);
            _loc_11.x = 1249;
            _loc_11.y = BT_TOP_Y + 1;
            _loc_11.addEventListener(MouseEvent.CLICK, this.on_bt_mini);
            var _loc_12:* = new BtPic(new Close());
            addChild(_loc_12);
            _loc_12.x = stage.stageWidth - 52;
            _loc_12.y = BT_TOP_Y;
            _loc_12.addEventListener(MouseEvent.CLICK, this.on_close_click);
            this.cont = new Sprite();
            this.cont.x = 2;
            this.cont.y = 50;
            addChild(this.cont);
            this.cont2 = new Cont2();
            this.cont2.x = 0;
            this.cont2.y = 0;
            addChild(this.cont2);
            this.cont_mask = new Box(2, 50, stage.stageWidth - 22, stage.stageHeight - 75);
            addChild(this.cont_mask);
            this.cont2_mask = new Box(2, 50, stage.stageWidth - 22, stage.stageHeight - 75);
            addChild(this.cont2_mask);
            this.cont.mask = this.cont_mask;
            this.cont2.mask = this.cont2_mask;
            this.dragBox = new Sprite();
            this.cont.addChild(this.dragBox);
            stage.addEventListener(MouseEvent.MOUSE_DOWN, this.on_stage_down);
            stage.addEventListener(MouseEvent.MOUSE_UP, this.on_stage_up);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, this.on_stage_move);
            stage.addEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, this.mid_down);
            stage.addEventListener(MouseEvent.MIDDLE_MOUSE_UP, this.mid_up);
            this.editer = new Editer();
            this.editer.x = stage.stageWidth - 630;
            this.editer.y = 53;
            Editer.editer_for_nodes = this.editer;
            addChild(this.editer);
            this.debuger = new Debuger();
            this.debuger.x = 10;
            this.debuger.y = stage.stageHeight - 50;
            addChild(this.debuger);
            stage.addEventListener(MouseEvent.MOUSE_WHEEL, this.on_wheel);
			
            return;
        }// end function
		
		private function checkMod2SetBtHide():void 
		{
			if (MOD=="read") 
			{
				fz2_bt.visible =	false;
				fz_bt.visible =		false;
				rd_bt.visible =		false;
				edt_bt.visible =	true;
				add_bt.visible =	false;
				del_bt.visible =	false;
				if (pre_bt){
					if(pre_bt.x>0)pre_bt.visible = 	true;
				}
			}else {
				fz2_bt.visible =	true;
				fz_bt.visible =		true;
				rd_bt.visible =		true;
				edt_bt.visible =	false;
				add_bt.visible =	true;
				del_bt.visible =	true;
				if(pre_bt)pre_bt.visible = 	false;			
			}
		}

        private function on_bt_mini(event:MouseEvent) : void
        {
            stage.nativeWindow.minimize();
            return;
        }// end function

        private function on_wheel(event:MouseEvent) : void
        {
            var _loc_2:Number = NaN;
            if (!(event.target is TextField))
            {
                _loc_2 = (100 - event.delta * 3) / 100;
                if (Main.MOD == "edit")
                {
                    this.sss(this.cont, _loc_2);
                }
                if (Main.MOD == "read")
                {
                    this.sss(this.cont2, _loc_2);
                }
            }
            return;
        }// end function

        private function sss(con:DisplayObject, d:Number) : void
        {
            var _loc_3:Number = 0.08;
            var _loc_4:* = con.width;
            var _loc_5:* = (stage.mouseX - con.x) / _loc_4;
            var _loc_6:* = con.height;
            var _loc_7:* = (stage.mouseY - con.y) / _loc_6;
            con.scaleX = con.scaleX * d;
            con.scaleY = con.scaleY * d;
            if (Math.abs((con.scaleX - 1)) < _loc_3)
            {
                con.scaleX = 1;
                con.scaleY = 1;
                this.debuger.txt = "100%";
            }
            con.x = con.x - (con.width - _loc_4) * _loc_5;
            con.y = con.y - (con.height - _loc_6) * _loc_7;
            return;
        }// end function

        private function on_bigbigbg_db_click(event:MouseEvent) : void
        {
            if (MOD == "read")
            {
                if (Item.read_deep_array.length > 1)
                {
                    Item.read_deep_array.pop();
                    update_cont2();
                }
            }
            return;
        }// end function

        private function on_bt_edit(event:MouseEvent) : void
        {
			Main.MOD = "edit";
            Item.last = null;
			if (ItemForTools.last) ItemForTools.last.off();
            ItemForTools.last = null;
            this.editer.clear();
			
            if (Bt.last)
            {
                Bt.last.on();
            }
			
            this.cont.visible = true;
            this.cont2.visible = false;
            tools.visible = false;
			checkMod2SetBtHide()
            return;
        }// end function

        private function on_bt_read(event:MouseEvent) : void
        {
            Main.MOD = "read";
			Item.last = null;
			if (Bt.last) Bt.last.off();
			ItemForTools.last = null;
            this.editer.clear();
            this.cont.visible = false;
            this.cont2.visible = true;
			if(Bt.last)Item.read_deep_array = Item.getDeepArray(Bt.last);
            update_cont2();
            tools.visible = true;
			this.debuger.txt = "★Ctrl + 拖拽，可以修改节点的位置。★";
			checkMod2SetBtHide()
            return;
        }// end function

        private function on_bt_close_no_save(event:MouseEvent) : void
        {
            stage.nativeWindow.close();
            return;
        }// end function

        private function on_key(event:KeyboardEvent) : void
        {
            if (event.keyCode == 83)
            {
                if (event.ctrlKey)
                {
                    this.saveNow();
					
                }
                else if (event.altKey)
                {
                    this.toSave();
                }
            }
            return;
        }// end function

        private function on_bt_open(event:MouseEvent) : void
        {
            var _loc_2:* = new File();
            var _loc_3:* = new FileFilter("TreeMap文件格式", "*.tree");
            _loc_2.addEventListener(Event.SELECT, this.selectHandler);
            _loc_2.browseForOpen("选择你要打开的树状图(文件后缀必须是tree)", [_loc_3]);
            return;
        }// end function

        private function selectHandler(event:Event) : void
        {
            var _loc_2:* = event.target as File;
            this.open(_loc_2);
            return;
        }// end function
		
        private function mid_up(event:MouseEvent) : void
        {
            this.is_mid_down = false;
            stopDrag();
            return;
        }// end function

        private function mid_down(event:MouseEvent) : void
        {
            this.is_mid_down = true;
            return;
        }// end function

		private function on_stage_down(e:MouseEvent):void 
		{
			if (e.target is BigBigBG) 
			{
				isDrag = true;
				if (cont.numChildren>0) 
				{
					cont.addChildAt(dragBox, cont.numChildren - 1);
					dragBox.graphics.clear();
					dragBoxRect = new Rectangle(cont.mouseX,cont.mouseY);						
				}
				last_mouse_down_time = new Date().getTime();
			}
			
		}

		private function on_stage_move(e:MouseEvent):void 
		{
			if (isDrag && dragBoxRect ) 
			{
				dragBox.graphics.clear();
				dragBox.graphics.lineStyle(1, 0x006600, .6);
				dragBox.graphics.beginFill(0x009900, .1);
				dragBox.graphics.drawRect(dragBoxRect.x, dragBoxRect.y,cont.mouseX - dragBoxRect.x,cont.mouseY - dragBoxRect.y);
				dragBox.graphics.endFill();
			}
            if (this.is_mid_down)
            {
                if (Main.MOD == "edit")
                {
                    this.cont.startDrag();
                }
                if (Main.MOD == "read")
                {
                    this.cont2.startDrag();
                }
            }
		}

        private function on_stage_up(e:MouseEvent) : void
        {
			if (isDrag && dragBoxRect ) 
			{
				if ((e.target == dragBox || e.target is BigBigBG )&&(Math.abs(cont.mouseX - dragBoxRect.x)>10)) 
				{
					checkAllUnderDrag();
					isDrag = false;
					dragBox.graphics.clear();					
				}else {
					isDrag = false;
					dragBox.graphics.clear();	
				}				
			}
			if (e.target is BigBigBG && last_mouse_down_time) 
			{
				var d:Number = (new Date().getTime()) - last_mouse_down_time;
				if (d < 200) {
					unSelectAllBt()
				}
			}
        }// end function
        private function unSelectAllBt() : void
        {
			if (MOD=="edit") 
			{
				var len:int = Main.edit_mod_select_bts_arr.length;
				for (var i:int = 0; i < len; i++) 
				{
					var bbb:Bt = Main.edit_mod_select_bts_arr[i] as Bt;
					if (bbb)
					{
						bbb.delayUnSelect();
					}
				}				
			}
        }// end function		
		
        private function checkAllUnderDrag() : void
        {
            var _loc_2:DisplayObject = null;
            var _loc_1:int = 0;
            while (_loc_1 < this.cont.numChildren)
            {
                
                _loc_2 = this.cont.getChildAt(_loc_1);
                if (_loc_2 is Bt)
                {
                    if (this.dragBox.hitTestObject((_loc_2 as BgBase).bgSkin))
                    {
                        (_loc_2 as Bt).select();
                    }
                }
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function on_bt_fz(event:MouseEvent) : void
        {
            var _loc_5:Bt = null;
            var _loc_6:Bt = null;
            var _loc_7:int = 0;
            var _loc_8:Bt = null;
            var _loc_9:Bt = null;
            var _loc_10:int = 0;
            var _loc_11:Boolean = false;
            var _loc_12:int = 0;
            var _loc_13:int = 0;
            var _loc_14:int = 0;
            var _loc_2:* = new Array();
            var _loc_3:* = obArr.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = obArr[_loc_4] as Bt;
                if (_loc_5.isSelect)
                {
                    _loc_2.push(_loc_5);
                }
                _loc_4 = _loc_4 + 1;
            }
            _loc_2.sortOn("y", Array.NUMERIC);
            if (_loc_2.length >= 2)
            {
                _loc_6 = _loc_2[0] as Bt;
                _loc_6.select("off");
                _loc_7 = 1;
                while (_loc_7 < _loc_2.length)
                {
                    
                    _loc_8 = _loc_2[_loc_7] as Bt;
                    _loc_9 = getBt(_loc_8.data.fid);
                    if (_loc_9)
                    {
                        _loc_13 = _loc_9.data.subs.length;
                        _loc_14 = 0;
                        while (_loc_14 < _loc_13)
                        {
                            
                            if (_loc_9.data.subs[_loc_14] == _loc_8.data.id)
                            {
                                _loc_9.data.subs.splice(_loc_14, 1);
                                break;
                            }
                            _loc_14 = _loc_14 + 1;
                        }
                    }
                    _loc_8.data.fid = _loc_6.data.id;
                    _loc_8.select("off");
                    _loc_10 = _loc_6.data.subs.length;
                    _loc_11 = false;
                    _loc_12 = 0;
                    while (_loc_12 < _loc_10)
                    {
                        
                        if (_loc_6.data.subs[_loc_12] == _loc_8.data.id)
                        {
                            _loc_11 = true;
                            break;
                        }
                        _loc_12 = _loc_12 + 1;
                    }
                    if (!_loc_11)
                    {
                        _loc_6.data.subs.push(_loc_8.data.id);
                    }
                    WinResize.removeBt(_loc_8.data.id);
                    _loc_8.f_fix(_loc_6.data.id);
                    _loc_8.fixDeep();
                    _loc_7 = _loc_7 + 1;
                }
            }
            else
            {
                trace("请选择两个以上的节点");
            }
            return;
        }// end function

        private function on_bt_fz2(event:MouseEvent) : void
        {
            var _loc_5:Bt = null;
            var _loc_6:Bt = null;
            var _loc_7:int = 0;
            var _loc_8:Bt = null;
            var _loc_9:Array = null;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            var _loc_2:* = new Array();
            var _loc_3:* = obArr.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = obArr[_loc_4] as Bt;
                if (_loc_5.isSelect)
                {
                    _loc_2.push(_loc_5);
                }
                _loc_4 = _loc_4 + 1;
            }
            _loc_2.sortOn("y", Array.NUMERIC);
            if (_loc_2.length >= 2)
            {
                _loc_6 = _loc_2[0] as Bt;
                _loc_6.select("off");
                _loc_7 = 1;
                while (_loc_7 < _loc_2.length)
                {
                    
                    _loc_8 = _loc_2[_loc_7] as Bt;
                    _loc_8.select("off");
                    _loc_9 = new Array();
                    if (_loc_8.data.fid == _loc_6.data.id)
                    {
                        _loc_10 = _loc_6.data.subs.length;
                        _loc_11 = 0;
                        while (_loc_11 < _loc_10)
                        {
                            
                            if (_loc_6.data.subs[_loc_11] == _loc_8.data.id)
                            {
                                _loc_6.reDrawSon(_loc_8.data.id, _loc_11);
                                break;
                            }
                            _loc_11 = _loc_11 + 1;
                        }
                    }
                    _loc_7 = _loc_7 + 1;
                }
            }
            else
            {
                trace("请选择两个以上的节点");
            }
            return;
        }// end function

        private function on_bt_delNode(event:MouseEvent) : void
        {
            if (Bt.last)
            {
                Bt.last.del();
                Bt.last = null;
            }
            return;
        }// end function

        private function on_bt_save(event:MouseEvent) : void
        {
            this.toSave();
            return;
        }// end function

        private function saveNow() : void
        {
            if (this.saveFile)
            {
                this.save(this.saveFile);
            }
            else if (obArr.length > 0)
            {
                this.toSave();
            }
            return;
        }// end function

        private function toSave() : void
        {
            var _loc_1:* = new File();
            _loc_1.addEventListener(Event.SELECT, this.on_save_file_select);
            _loc_1.browseForSave("请填写要保存的文件名(不需要添加后缀)");
            return;
        }// end function

        private function on_save_file_select(event:Event) : void
        {
            var _loc_2:* = (event.target as File).nativePath;
            if (_loc_2.split(".tree").length == 1)
            {
                _loc_2 = _loc_2 + ".tree";
            }
            var _loc_3:* = new File(_loc_2);
            this.save(_loc_3);
            return;
        }// end function

        public function on_bt_addnode(event:MouseEvent) : void
        {
            if (Bt.last)
            {
                Editer.editer_for_nodes.update_to_node();
            }
            var _loc_2:* = "随机节点" + Math.random().toString().slice(3, 6);
            var _loc_3:* = new Bt(_loc_2, true);
            _loc_3.data.fid = root_bt.data.id;
            root_bt.data.subs.push(_loc_3.data.id);
            WinResize.addBt(_loc_3.data.id);
            _loc_3.x = stage.stageWidth / 2 - Math.ceil(Math.random() * 160) - 390;
            _loc_3.y = stage.stageHeight / 2 - Math.ceil(Math.random() * 155) - 100;
            this.cont.addChild(_loc_3);
            Bt.last = _loc_3;
            _loc_3.update_to_editer();
            return;
        }// end function

        public function addShadow(comp:DisplayObject) : void
        {
            this.shadowFilter = new DropShadowFilter();
            this.shadowFilter.color = 0;
            this.shadowFilter.alpha = 0.3;
            this.shadowFilter.blurX = 8;
            this.shadowFilter.blurY = 8;
            this.shadowFilter.distance = 8;
            comp.filters = [this.shadowFilter];
            return;
        }// end function

        private function on_close_click(event:MouseEvent) : void
        {
            if (this.saveFile)
            {
                this.save(this.saveFile);
                stage.nativeWindow.close();
            }
            else
            {
                stage.nativeWindow.close();
            }
            return;
        }// end function

        private function on_mover_down(event:MouseEvent) : void
        {
            stage.nativeWindow.startMove();
            return;
        }// end function

        private function initData() : void
        {
            this.clearAll();
            this.creatRootNode();
            tools = new ToolsMC();
            tools.x = this.editer.x - tools.width - 15;
            tools.y = this.editer.y + 8;
            addChild(tools);
			checkMod2SetBtHide();
            return;
        }// end function

        public function setIniFile(string:String) : void
        {
            this.iniFile = File.applicationStorageDirectory.resolvePath(string);
            iniPath = this.iniFile.nativePath;
            return;
        }// end function

        public function open(f:File) : void
        {
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:INode = null;
            var _loc_7:Class = null;
            var _loc_8:Bt = null;
            this.saveFile = f;
            this.clearAll();
            registerClassAlias("inode_class", INode);
            var _loc_2:* = new FileStream();
            _loc_2.open(f, FileMode.READ);
            data = _loc_2.readObject();
            if (data.obArr)
            {
                _loc_3 = data.obArr;
            }
            else
            {
                trace("错误的文件格式");
                return;
            }
            if (_loc_3.length > 0)
            {
                _loc_4 = 0;
                while (_loc_4 < _loc_3.length)
                {
                    
                    _loc_6 = INode(_loc_3[_loc_4]);
                    _loc_7 = this.classArr[_loc_6.classtype];
                    if (_loc_6.classtype == 0)
                    {
                        _loc_8 = new Bt(_loc_6.title, true, _loc_6.mod ? (_loc_6.mod) : (Bt.state_mod_tree), _loc_6.id, _loc_6.fid, _loc_6.subs);
                        _loc_8.data = _loc_6;
                        _loc_8.x = _loc_6.x;
                        _loc_8.y = _loc_6.y;
                        _loc_8.data.id = _loc_6.id;
                        if (_loc_6.title == "根节点")
                        {
                            root_bt = _loc_8;
                            _loc_8.visible = false;
                            Item.read_deep_array = new Array();
                            Item.read_deep_array.push(root_bt);
                        }
                        this.cont.addChild(_loc_8);
                    }
                    _loc_4 = _loc_4 + 1;
                }
                _loc_5 = 0;
                while (_loc_5 < obArr.length)
                {
                    
                    (obArr[_loc_5] as Bt).fixDeep();
                    _loc_5 = _loc_5 + 1;
                }
            }
            tools.add_all_tools_from_root_bt_data();
			tools.x = this.editer.x - tools.width - 15;
            this.debuger.txt = "★已打开★";
			update_cont2();
			MOD = "read";
			checkMod2SetBtHide();
			cont.visible = false;
			cont2.visible = true;
			tools.visible = true;
			setContSize();
            return;
        }// end function
		
		private function setContSize():void 
		{
			var b:Rectangle = cont.getBounds(this);
			var d:Number = 500;
			var bfb:Number = d / b.width;
			cont.scaleX = bfb;
			cont.scaleY = bfb;
			cont.x -= b.x*bfb-20;
			cont.y -= b.y*bfb-20;
		}

        public function save(f:File) : void
        {
            this.saveFile = f;
            registerClassAlias("inode_class", INode);
            var _loc_2:* = new Array();
            var _loc_3:int = 0;
            while (_loc_3 < obArr.length)
            {
                
                _loc_2.push((obArr[_loc_3] as ISave).get_save_ob());
                _loc_3 = _loc_3 + 1;
            }
            data.obArr = _loc_2;
            var _loc_4:* = new FileStream();
            _loc_4.open(f, FileMode.WRITE);
            _loc_4.writeObject(data);
            _loc_4.close();
			saveINI({path:f.nativePath});
            this.debuger.txt = "★已保存★";
            return;
        }// end function
        public function saveINI(ob:Object) : void
        {
			trace(ob)
			trace("保存路径为：",ob.path,ob.p)
            var _loc_4:FileStream = new FileStream();
			try 
			{
				_loc_4.open(iniFile, FileMode.WRITE);
				_loc_4.writeObject(ob);
				_loc_4.close();				
			}catch (err:Error)
			{
				trace("::",err.message)
			}

			trace(111)
            return;
        }// end function
        public function readINI() : Object
        {
			var _loc_2:FileStream;
			var ob:Object = new Object();
				_loc_2 = new FileStream();
				_loc_2.open(iniFile, FileMode.READ);
				ob = _loc_2.readObject();
				_loc_2.close();

			return ob;
        }// end function
		private function checkHasPreFile():void 
		{
			var p:String = readINI().path;
			if (p) {
				trace("checkHasPreFile路径为", p, "。")
				preSavePath = p;
				pre_bt = new Bt("打开最近保存过的文件", false);
				addChild(pre_bt);
				pre_bt.x = 9;
				pre_bt.y = BT_TOP_Y;
				pre_bt.addEventListener(MouseEvent.CLICK, on_bt_open_pre);				
			}else {
				trace("路径为空",p,"。")
			}
		}
		
		private function on_bt_open_pre(e:MouseEvent):void 
		{
			pre_bt.visible = false;
			pre_bt.x = -200;
			var f:File = new File();
			f.nativePath = preSavePath;
			open(f);
			
		}
        public function clearAll() : void
        {
            if (Bt.last)
            {
                Bt.last.del();
                Bt.last = null;
            }
            if (Item.last)
            {
                Item.last = null;
            }			
            if (this.cont)
            {
                while (this.cont.numChildren > 0)
                {
                    
                    this.cont.removeChildAt(0);
                }
            }
			if(tools)tools.clearAll();
			
            data = new Object();
            data.obArr = new Array();
            obArr = new Array();
            objects = new Object();
            this.isDrag = false;
            clearCont2();
            Item.read_deep_array = new Array();
			
            if(editer)editer.clear();
            this.cont.visible = false;
            this.cont2.visible = true;
			
			where_end = null;
            return;
        }// end function

        private function creatRootNode() : void
        {
            root_bt = new Bt("根节点", true);
            root_bt.x = 111;
            root_bt.y = 111;
            Item.read_deep_array = new Array();
            Item.read_deep_array.push(root_bt);
            this.cont.addChild(root_bt);
            root_bt.visible = false;
            root_bt.x = -80;
            root_bt.y = -80;
            return;
        }// end function
		
        public static function update_cont2() : void
        {
			clearCont2();
			if (Item.read_deep_array.length>1) 
			{
				if ((Item.read_deep_array[Item.read_deep_array.length-1] as Bt).data.subs.length==0) 
				{
					Item.read_deep_array.pop();
				}				
			}
			reDrawCont2(Item.read_deep_array)
        }// end function

        public static function reDrawCont2(arr:Array) : void
        {
			draw_where_am_i()
			
			var end_bt:Bt = arr[arr.length - 1];
			if (end_bt) 
			{
				var a_win:WinResize = new WinResize(end_bt.data.id, null);
				Main.themain.cont2.add(a_win);				
			}

			if (Bt.last) searchItemAndOn(Bt.last.data.id);
			
            return;
        }// end function
		public static function searchItemAndOn(id:String):void 
		{
			var isSub:Boolean;
			for (var i:int = 0; i < Main.themain.cont2.numChildren; i++) 
			{
				var it:* = Main.themain.cont2.getChildAt(i);
				if (it is WinResize) 
				{
					var win:WinResize = it as WinResize;
					var len:int = win.item_container.numChildren;
					for (var j:int = 0; j < len; j++) 
					{
						var item:Item = win.item_container.getChildAt(j) as Item;
						if (item)
						{
							if (item.bt.data.id==id) 
							{
								isSub = true;
								item.setOn();
								item.update_to_editer();
							}
						}
					}
				}
			}
			if (!isSub) {
				Item.last = null;
				getBt(id).update_to_editer();
			}
			var item_tool:ItemForTools = tools.getItemtool(id);
			ItemForTools.last = item_tool;
			if (item_tool) {
				trace("======",ItemForTools.last)
				item_tool.setOn();
			}
		}
		static public function draw_where_am_i():void 
		{
			var where_txt0:MySuperText = new MySuperText("你现在所处的位置是:",12,0x555555);
			Main.themain.cont2.addChild(where_txt0);
			where_txt0.x = 10;
			where_txt0.y = 50;
			
			var aColor:uint = 0x5555dd;
			var aColor_gray:uint = 0x009900;
			var lineHeight:Number = 22;
			the_where_y = where_txt0.y + lineHeight;
			for (var i:int = 0; i < Item.read_deep_array.length; i++) 
			{
				var where_txt2:MySuperText = new MySuperText(">>",12,aColor_gray);
				Main.themain.cont2.addChild(where_txt2);
				where_txt2.x = where_txt0.x;
				where_txt2.y = the_where_y;
				
				var btnow:Bt = Item.read_deep_array[i] as Bt;
				if (i==Item.read_deep_array.length-1) 
				{
					aColor = aColor_gray;
				}
				var where_txt:MySuperText = new MySuperText(btnow.data.title,12,aColor);
				Main.themain.cont2.addChild(where_txt);
				
				where_txt.x = where_txt0.x+where_txt2.width;
				where_txt.y = the_where_y;
				
				the_where_y = where_txt2.y + lineHeight;
				
				
				where_txt.buttonMode = true;
				where_txt.data = Item.read_deep_array.slice(0,(i+1));
				where_txt.addEventListener(MouseEvent.CLICK, on_cont2_where_click);				
				if (i!=Item.read_deep_array.length-1) 
				{
					
				}else {
					where_end = where_txt;
				}
			}
		}
        public static function getWin(id:String) : WinResize
        {
            var _loc_2:WinResize = null;
            return _loc_2;
        }// end function

        public static function getBtNow(): Bt
        {
            return Item.read_deep_array[(Item.read_deep_array.length - 1)] as Bt;
        }// end function

        private static function on_cont2_where_click(event:MouseEvent) : void
        {
            Item.read_deep_array = (event.target as MySuperText).data as Array;
			var bt:Bt = Item.read_deep_array[Item.read_deep_array.length - 1] as Bt;
			Bt.last = bt;
			//Item.last = 
			bt.update_to_editer();
            update_cont2();
            return;
        }// end function

        public static function clearCont2() : void
        {
            if (Main.themain.cont2.numChildren)
            {
                while (Main.themain.cont2.numChildren > 0)
                {
                    
                    Main.themain.cont2.removeChildAt(0);
                }
            }
            return;
        }// end function

        public static function update_objects_cache() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:Bt = null;
            objects = new Object();
            if (data.obArr)
            {
                _loc_1 = obArr.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    _loc_3 = obArr[_loc_2] as Bt;
                    objects[_loc_3.data.id] = _loc_3;
                    _loc_2 = _loc_2 + 1;
                }
            }
            else
            {
                trace("data.obArr数据为空");
            }
            return;
        }// end function

        public static function getBt(id:String) : Bt
        {
            return objects[id] as Bt;
        }// end function

    }
}
