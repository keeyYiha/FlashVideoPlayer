package com.Utils
{
    public class TimeTool
    {
        public function TimeTool()
        {
            
        }
        
        public static function secondFormat(second:Number):String
        {
            return frontZeroFill(second/60) + ":" + frontZeroFill(second%60);
        }
        
        private static function frontZeroFill(n:int):String
        {
            if (String(n).length<2)
                return "0" + n;
            return String(n);
        }
    }
}