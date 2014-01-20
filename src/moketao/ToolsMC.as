package moketao
{
	import com.adobe.utils.ArrayUtil;
    import flash.display.*;
    import flash.events.*;

    public class ToolsMC extends Sprite
    {
        private var hander:MovieClip;
        private var item_container:MovieClip;

        public function ToolsMC()
        {
            this.item_container = new MovieClip();
            var _loc_1:* = new Tools();
            addChild(_loc_1);
            this.hander = _loc_1.mover;
            this.hander.addEventListener(MouseEvent.MOUSE_DOWN, this.on_down);
            this.hander.addEventListener(MouseEvent.MOUSE_UP, this.on_up);
            addChild(this.item_container);
            this.item_container.x = 12;
            this.item_container.y = 35;
            return;
        }// end function
		public function getItemtool(id:String):ItemForTools 
		{
			var it:ItemForTools;
			var len:int = item_container.numChildren;
			for (var i:int = 0; i < len; i++) 
			{
				var it2:ItemForTools = item_container.getChildAt(i) as ItemForTools;
				if (it2.bt.data.id == id) {
					it = it2;
				}else {
					it2.off();
				}
			}
			return it;
		}
        public function add_all_tools_from_root_bt_data() : void
        {
            var len:int = 0;
            var i:int = 0;
            var arr:Array = Main.root_bt.data.root_bt_tools_arr;
			if (arr) 
			{
				
				for (var j:int = 0; j < arr.length; j++) 
				{
					var bt:Bt = Main.getBt(arr[i]);
					if (!bt) 
					{
						arr[i] = "aa";
					}
				}
				arr = ArrayUtil.createUniqueCopy(arr);
			}
			ArrayUtil.removeValueFromArray(arr,"aa");
			Main.root_bt.data.root_bt_tools_arr = arr;
            if (arr)
            {
                len = arr.length;
                i = 0;
                while (i < len)
                {
                    
                    this.add(arr[i]);
                    i = i + 1;
                }
            }
            return;
        }// end function
		
		public function clearAll():void 
		{
			while (item_container.numChildren) 
			{
				item_container.removeChildAt(0);
			}
		}

        private function on_up(event:MouseEvent) : void
        {
            stopDrag();
            return;
        }// end function

        private function on_down(event:MouseEvent) : void
        {
            startDrag();
            return;
        }// end function

        public function add(btid:String) : void
        {
            var has:Boolean = false;
            var item_in_con2:ItemForTools = null;
            var _loc_5:ItemForTools = null;
            var _loc_3:int = 0;
            while (_loc_3 < this.item_container.numChildren)
            {
                
                item_in_con2 = this.item_container.getChildAt(_loc_3) as ItemForTools;
                if (item_in_con2.bt.data.id == btid)
                {
                    has = true;
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            if (!has)
            {
				var bt:Bt = Main.getBt(btid);
				if (bt)
				{
					_loc_5 = new ItemForTools(btid);
					if(!ArrayUtil.arrayContainsValue(Main.root_bt.data.root_bt_tools_arr,btid))Main.root_bt.data.root_bt_tools_arr.push(btid);
					this.item_container.addChild(_loc_5);
					if (_loc_5.bt.data.tool_pos_x > 0)
					{
						_loc_5.x = _loc_5.bt.data.tool_pos_x;
						_loc_5.y = _loc_5.bt.data.tool_pos_y;
					}
					else
					{
						_loc_5.x = 0 + 30 * Math.random();
						_loc_5.y = 0 + 30 * Math.random();
						_loc_5.bt.data.tool_pos_x = _loc_5.x;
						_loc_5.bt.data.tool_pos_y = _loc_5.y;
					}					
				}else
				{
					trace("不存在:", btid, "不能添加，将删除");
					ArrayUtil.removeValueFromArray(Main.root_bt.data.root_bt_tools_arr, btid);
				}
				
            }
            return;
        }// end function

        public function remove(i:ItemForTools) : void
        {
			ArrayUtil.removeValueFromArray(Main.root_bt.data.root_bt_tools_arr, i.bt.data.id);
            this.item_container.removeChild(i);
            i = null;
            return;
        }// end function

    }
}
