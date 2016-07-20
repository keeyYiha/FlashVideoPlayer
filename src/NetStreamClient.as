package
{
    import flash.media.Video;
    import flash.net.NetConnection;
    import flash.net.NetStream;

    public class NetStreamClient extends NetStream
    {
        private var _video:Video;
        public function NetStreamClient(connection:NetConnection, video:Video, peerID:String="connectToFMS")
        {
            _video = video;
            super(connection, peerID);
        }
        
        public function onMetaData(data:Object):void
        {
            trace(data.duration);
            var h:int = int(data.height);
            var w:int = int(data.width);
            if (!h) return;
            if((w/h) < (4/3))
            {
                _video.width = w/(h/300);
                _video.height = 300
                return;
            }
            if((w/h) > (4/3))
            {
                _video.width = 400;
                _video.height = h/(w/400);
                return;
            }
            _video.width = 400;
            _video.height = 300
        }
    }
}