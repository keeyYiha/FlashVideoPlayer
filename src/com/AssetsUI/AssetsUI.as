package com.AssetsUI
{
    import flash.display.Loader;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.net.URLRequest;

    public class AssetsUI  extends Sprite
    {
        private var _loader:Loader;
        private var _swfBaseUIUrl:String = "swf/BaseUI.swf";
        protected var _swfBaseUI:Object;
        public var UIObject:Sprite;
        
        public function AssetsUI()
        {
            this._loader = new Loader();
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onComplete)
            this._loader.load(new URLRequest(this._swfBaseUIUrl));
        }
        
        private function onComplete(event:Event):void
        {
            this._swfBaseUI = this._loader.contentLoaderInfo;
            helderComplete();
        }
        
        protected function helderComplete():void
        {
        }
    }
}