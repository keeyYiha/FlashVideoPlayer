package AssetsUI.AssetsTimeProgressBar
{
    import AssetsUI.AssetsUI;
    
    import flash.display.Sprite;
    import flash.system.ApplicationDomain;
    
    public class AssetsTimeProgressBar extends AssetsUI 
    {
        private const UI_CLASS_NAME:String = "AssetsTimeProgressBar";
        private var timeBar:Sprite;
        private var bar:Sprite;
        
        public function AssetsTimeProgressBar()
        {
            super();
        }
        
        override protected function helderComplete():void
        {
            var appDomain:ApplicationDomain = this._swfBaseUI.applicationDomain as ApplicationDomain;
            
            UIObject = new (appDomain.getDefinition(UI_CLASS_NAME) as Class);
            if (!UIObject) return;
            addChild(UIObject);
            UIObject.width = 700;
            
            timeBar = UIObject["timeBar"];
            bar = timeBar["bar"];
        }
        
        public function setTimeBar(percent:Number):void
        {
            if (percent < 0) percent = 0;
            if (percent > 1) percent = 1;
            if (bar)
            {
                bar.width = timeBar.width*percent;
            }
        }
    }
}