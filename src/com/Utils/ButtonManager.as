package com.Utils
{
    import flash.display.InteractiveObject;
    import flash.events.MouseEvent;

    public class ButtonManager
    {
        public function ButtonManager()
        {
        }
        
        public static function attach(doc:InteractiveObject, fun:Function, type:String=""):void
        {
            var call:Function = function(event:MouseEvent):void
            {
                if (fun!=null)
                {
                    fun(type, event)
                }
            }
            doc.addEventListener(MouseEvent.CLICK, call);
        }
        
        public static function detach():void
        {
            
        }
    }
}