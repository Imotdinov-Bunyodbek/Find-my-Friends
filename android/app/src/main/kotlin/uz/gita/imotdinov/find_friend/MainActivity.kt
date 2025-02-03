package uz.gita.imotdinov.find_friend

import android.app.Application
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("a0fdb25a-2cf3-46c1-b2cd-aee9a636f4c3")
        super.configureFlutterEngine(flutterEngine)
    }
}
