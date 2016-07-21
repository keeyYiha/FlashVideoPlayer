package com.AssetsUI.AssetsTimeProgressBar
{
    import com.AssetsUI.AssetsUI;
    import com.NetStreamClient;
    import com.Utils.TimeTool;
    
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.system.ApplicationDomain;
    
    public class AssetsTimeProgressBar extends AssetsUI 
    {
        private const UI_CLASS_NAME:String = "AssetsTimeProgressBar";
        private var timeBar:Sprite;
        private var bar:Sprite;
        private var stream:NetStreamClient;
        
        public function AssetsTimeProgressBar(stream:NetStreamClient)
        {
            this.stream = stream;
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
            UIObject["totalTime"].text = TimeTool.secondFormat(stream.duration);
            
            timeBar.addEventListener(MouseEvent.CLICK, onClickTimeBar);
        }

        private function onClickTimeBar(event:MouseEvent):void
        {
            var percent:Number = event.currentTarget.mouseX/timeBar.width;
            setPlayTime(percent);
            event.stopPropagation();
//            trace(event.currentTarget.mouseX, event.currentTarget.mouseY);
//            trace(event);
        }
        
        public function setTimeBar(currT:Number):void
        {
            var percent:Number = currT/stream.duration;
            if (percent < 0) percent = 0;
            if (percent > 1) percent = 1;
            if (bar)
            {
                bar.width = timeBar.width*percent;
                UIObject["currTime"].text = TimeTool.secondFormat(currT);
            }
        }
        
        public function setPlayTime(percent:Number):void
        {
            var currTime:Number = stream.duration*percent;
            stream.setSeek(currTime);
            setTimeBar(currTime);
        }
    }
}