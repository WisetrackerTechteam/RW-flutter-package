package kr.co.wisetracker.example

import android.os.Bundle
import com.sdk.wisetracker.base.tracker.common.log.WiseLog
import com.sdk.wisetracker.new_dot.open.DOT
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import kr.co.wisetracker.dot.DotPlugin;

class MainActivity:  FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState);

        // DOT.initialization(this)

        DOT.initializationForDeferredCallback(this) { // deferred deeplink  정보는 DOT.getDeferredUrl() 로 사용이 가능하며,
            // 앱에서는 해당 변수를 다음과 같이 사용할 수 있음.
            // 1. callback 이 호출되는 시점에 즉시 __deferredUrl 화면으로 이동 처리. __deferredUrl 값이 nil 이면 메인 화면으로 이동 처리.
            // 2. __deferredUrl 변수값을 어딘가에 저장하고, 회원가입 이후, 로그인이 완료된 이후등과 같이 필요한 시점에 저장된 값을 꺼내서 이동 처리.
            // 3. 사용 가능한 Deferred deeplink 정보가 없는 경우에는, __deferredUrl 값이 널(NULL) 이 될 수 있음을 고려하여 사용.
            val __deferredUrl = "mrcm";
            // val __deferredUrl = DOT.getDeferredUrl()
            WiseLog.d("current deferred url : $__deferredUrl")
            if(__deferredUrl != null){
                // Dart 로 링크 전달
                val flutterChannel = MethodChannel(flutterEngine?.dartExecutor as BinaryMessenger, "dot");
                flutterChannel.invokeMethod("deferredLink", __deferredUrl);
                println("실행 완료")
            }
        }

    }
}
