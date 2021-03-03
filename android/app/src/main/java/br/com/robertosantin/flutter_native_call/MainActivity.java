package br.com.robertosantin.flutter_native_call;

import android.os.Bundle;
import android.os.PersistableBundle;
import android.widget.ImageView;

import com.yhao.floatwindow.FloatWindow;
import com.yhao.floatwindow.Screen;

import androidx.annotation.Nullable;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "floating_button";

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        GeneratedPluginRegistrant.registerWith(getFlutterEngine());

        MethodChannel channel = new  MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL);

        channel.setMethodCallHandler(
                (call, result) ->{
                    switch (call.method){
                        case "create":
                            ImageView img = new ImageView((getApplicationContext()));
                            img.setImageResource(R.drawable.add);

                            FloatWindow.with(getApplicationContext()).setView(img)
                                    .setWidth(Screen.width, 0.15f)
                                    .setHeight(Screen.width, 0.15f)
                                    .setX(Screen.width, 0.8f)
                                    .setY(Screen.height, 0.3f)
                                    .setDesktopShow(true)
                                    .build();

                            img.setOnClickListener(
                                    v -> {
                                        channel.invokeMethod("touch", null);
                                    }
                            );
                            break;
                        case "show":
                            FloatWindow.get().show();
                            break;
                        case "hide":
                            FloatWindow.get().hide();
                            break;

                        case "isShowing":
                            result.success(FloatWindow.get().isShowing());
                            break;
                        default:
                            result.notImplemented();
                    }
                }
        );
    }

    @Override
    protected void onDestroy() {
        FloatWindow.destroy();
        super.onDestroy();
    }
}
