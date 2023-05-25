package kr.co.wisetracker.example

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import com.sdk.wisetracker.new_dot.open.DOT;

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState);

        DOT.initialization(this)
    }
}
