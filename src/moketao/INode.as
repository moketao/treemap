package moketao
{

    public class INode extends Object
    {
        public var title:String;
        public var txt:String;
        public var classtype:int;
        public var x:int;
        public var y:int;
        public var id:String;
        public var fid:String;
        public var mod:String;
        public var subs:Array;
        public var read_pos_x:Number;
        public var read_pos_y:Number;
        public var tool_pos_x:Number;
        public var tool_pos_y:Number;
        public var win:Object;
        public var root_bt_winlinks_arr:Array;
        public var root_bt_tools_arr:Array;

        public function INode()
        {
            this.win = {x:0, y:0, w:0, h:0};
            this.root_bt_winlinks_arr = [];
            this.root_bt_tools_arr = [];
            return;
        }// end function

    }
}
