package moketao
{
    import flash.display.*;

    public class Cont2 extends Sprite
    {

        public function Cont2()
        {
            return;
        }// end function

        public function add(i:*) : void
        {
            var _loc_2:WinResize = null;
            if (i is WinResize)
            {
                _loc_2 = i as WinResize;
                addChild(_loc_2);
            }
            return;
        }// end function

    }
}
