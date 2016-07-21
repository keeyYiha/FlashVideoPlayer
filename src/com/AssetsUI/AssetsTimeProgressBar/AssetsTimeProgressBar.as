package com.AssetsUI.AssetsTimeProgressBar
{
    import com.AssetsUI.AssetsUI;
    import com.Utils.TimeTool;
    
    import flash.display.Sprite;
    import flash.system.ApplicationDomain;
    
    public class AssetsTimeProgressBar extends AssetsUI 
    {
        private const UI_CLASS_NAME:String = "AssetsTimeProgressBar";
        private var timeBar:Sprite;
        private var bar:Sprite;
        private var durationTime:Number;
        
        public function AssetsTimeProgressBar(durationT:Number)
        {
            durationTime = durationT;
            super();
        }
        
        override protected function helderComplete():void
        {
            var appDomain:ApplicationDomain = this._swfBaseUI.applicationDomain as ApplicationDomain;
            
            UIObject = new (appDomain.getDefinition(UI_CLASS_NAME) as Class);
            if (!UIObject) return;
            addChild(UIObject);
            
            timeBar = UIObject["timeBar"];
            bar = timeBar["bar"];
            UIObject["totalTime"].text = TimeTool.secondFormat(durationTime);
        }
        
        public function setTimeBar(currT:Number):void
        {
            var percent:Number = currT/durationTime;
            if (percent < 0) percent = 0;
            if (percent > 1) percent = 1;
            if (bar)
            {
                bar.width = timeBar.width*percent;
                UIObject["currTime"].text = TimeTool.secondFormat(currT);
            }
        }
    }
}