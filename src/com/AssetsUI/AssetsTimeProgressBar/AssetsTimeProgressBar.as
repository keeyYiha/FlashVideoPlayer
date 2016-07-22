package com.AssetsUI.AssetsTimeProgressBar
{
    import com.AssetsUI.AssetsUI;
    import com.NetStreamClient;
    import com.Utils.ButtonManager;
    import com.Utils.TimeTool;
    
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.system.ApplicationDomain;
    
    public class AssetsTimeProgressBar extends AssetsUI 
    {
        private static var instance:AssetsTimeProgressBar;
        private const UI_CLASS_NAME:String = "AssetsTimeProgressBar";
        private var timeBar:Sprite;
        private var bar:Sprite;
        private var stream:NetStreamClient;
        private var pause:SimpleButton;
        private var resume:SimpleButton;
        
        public function AssetsTimeProgressBar(stream:NetStreamClient)
        {
            this.stream = stream;
            super();
        }
        
//        public static function getInstance():AssetsTimeProgressBar
//        {
//            if (!instance)
//                instance = new AssetsTimeProgressBar();
//            return instance;
//        }
        
        override protected function helderComplete():void
        {
            var appDomain:ApplicationDomain = this._swfBaseUI.applicationDomain as ApplicationDomain;
            
            UIObject = new (appDomain.getDefinition(UI_CLASS_NAME) as Class);
            if (!UIObject) return;
            addChild(UIObject);
            
            timeBar = UIObject["timeBar"];
            bar = timeBar["bar"];
            resume = UIObject["resume"];
            pause = UIObject["pause"];
            resume.visible = false;
            
            UIObject["totalTime"].text = TimeTool.secondFormat(stream.duration);
            
            ButtonManager.attach(timeBar, this.onClick)
            ButtonManager.attach(pause, this.onClick, "pause");
            ButtonManager.attach(resume, this.onClick, "resume");
        }

        public function onClick(t:String="", event:MouseEvent=null):void
        {
            switch(t)
            {
                case "pause":
                    stream.pause();
                    pause.visible = false;
                    resume.visible = true;
                    break;
                case "resume":
                    stream.resume()
                    pause.visible = true;
                    resume.visible = false;
                    break;
                default:
                    var percent:Number = event.currentTarget.mouseX/timeBar.width;
                    setPlayTime(percent);
                    break;
            }
            if (event && event.hasOwnProperty("stopPropagation"))
            {
                event.stopPropagation();
            }
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
        }
    }
}