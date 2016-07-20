package
{
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.events.NetStatusEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.TouchEvent;
    import flash.media.*;
    import flash.net.NetConnection;
    import flash.net.NetStream;
    
    public class player extends Sprite
    {
//        private var videoUrl:String = "video/AbsoluteDuo.mp4";
        private var videoUrl:String = "video/video.flv";
        private var connection:NetConnection;
        private var stream:NetStreamClient;
        private var video:Video;
        public function player()
        {
            connection = new NetConnection();
            connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            connection.connect(null);
        }
        
        private function netStatusHandler(event:NetStatusEvent):void
        {
            if (event.info.code == "NetConnection.Connect.Success")
            {
                connectStream();
                return;
            }
            if (event.info.code == "NetStream.Play.Start") {
                //开始播放
            }
            if (event.info.code == "NetStream.Play.Stop") {
                //播放完成
            }
            if (event.info.code == "NetStream.Buffer.Full") {
                //缓冲完成
            }
            if (event.info.code == "NetStream.Pause.Notify") {
                //暂停
            }
            if (event.info.code == "NetStream.Unpause.Notify") {
                //恢复
            }
            trace("player.netStatusHandler: " + event.info.code);
        }
        
        private function securityErrorHandler(event:SecurityErrorEvent):void
        {
            
        }
        
        private function connectStream():void
        {
            video = new Video();
            stream = new NetStreamClient(connection, video);
            stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
//            stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
            stream.play(videoUrl);
            video.attachNetStream(stream);
            addChild(video);
            
            var spr:Sprite = new Sprite();
            stage.addEventListener(MouseEvent.CLICK, this.videoClick);
        }
        
        private function videoClick(event:MouseEvent):void
        {
            trace(event);
            stream.togglePause();
        }
    }
}