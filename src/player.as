package
{
    import com.AssetsUI.AssetsTimeProgressBar.AssetsTimeProgressBar;
    import com.NetStreamClient;
    
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.NetStatusEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.TouchEvent;
    import flash.media.*;
    import flash.net.NetConnection;
    import flash.net.NetStream;
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    
    public class player extends Sprite
    {
        private var videoUrl:String = "video/AbsoluteDuo.mp4";
//        private var videoUrl:String = "video/video.flv";
        private var connection:NetConnection;
        private var stream:NetStreamClient;
        private var video:Video;
        private var _loader:Loader;
        
        public function player()
        {
            this.init()
        }
        
        public function init():void
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
        
        private var soundTrans:SoundTransform;
        private var _timeProgressBar:AssetsTimeProgressBar;
        private function connectStream():void 
        {
            var Fun:Function = function()
            {
                //音量
                soundTrans = new SoundTransform();
                soundTrans.volume = 1;
                SoundMixer.soundTransform = soundTrans;
                
                _timeProgressBar = new AssetsTimeProgressBar(stream.duration);
                addChild(_timeProgressBar);
                _timeProgressBar.y = 300;
                
                stage.addEventListener(MouseEvent.CLICK, videoClick);
                addEventListener(Event.ENTER_FRAME, onEnterFrame);
            }
            video = new Video();
            stream = new NetStreamClient(connection, video, Fun);
            stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
//            stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
            stream.play(videoUrl);
            video.attachNetStream(stream);
            addChild(video);
        }
        
        private function videoClick(event:MouseEvent):void
        {
            stream.togglePause();
        }
        
        private function onEnterFrame(event:Event):void
        {
            _timeProgressBar.setTimeBar(stream.time);
        }
    }
}