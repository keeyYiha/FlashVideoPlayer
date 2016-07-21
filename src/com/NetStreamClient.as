package com
{
    import flash.media.Video;
    import flash.net.NetConnection;
    import flash.net.NetStream;

    public class NetStreamClient extends NetStream
    {
        private var _video:Video;
        private var _duration:Number;
        private var callFun:Function = null;
        
        public function NetStreamClient(connection:NetConnection, video:Video, fun:Function, peerID:String="connectToFMS")
        {
            callFun = fun;
            _video = video;
            super(connection, peerID);
        }
        
        public function onMetaData(info:Object):void
        {
            _duration = info.duration;
            var h:int = int(info.height);
            var w:int = int(info.width);
            if((w/h) < (4/3))
            {
                _video.width = w/(h/300);
                _video.height = 300;
            }
            else if((w/h) > (4/3))
            {
                _video.width = 400;
                _video.height = h/(w/400);
            }
            else
            {
                _video.width = 400;
                _video.height = 300;
            }
            
            if (callFun)
            {
                callFun();
            }
        }
        
        public function onPlayStatus(info:Object):void
        {
            trace(info);
        }
        
        public function onCuePoint(info:Object):void
        {
            trace(info);
        }
        
        public function setSeek(offset:Number=0):void
        {
            if (offset > _duration)
                offset = _duration;
            if (offset < 0)
                offset = 0;
            
            trace("setSeek: " + offset);
            
            this.seek(offset);
        }
        
        public function get duration():Number
        {
            return this._duration;
        }
    }
}