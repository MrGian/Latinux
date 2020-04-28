package app.latinux.android;

import android.os.Bundle;
import android.provider.Settings.Secure;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugins.GeneratedPluginRegistrant;

import com.google.android.vending.licensing.AESObfuscator;
import com.google.android.vending.licensing.LicenseChecker;
import com.google.android.vending.licensing.LicenseCheckerCallback;
import com.google.android.vending.licensing.Policy;
import com.google.android.vending.licensing.ServerManagedPolicy;

import android.view.WindowManager.LayoutParams;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "flutter.native/helper";
    private static final String BASE64_PUBLIC_KEY = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAm3ya4cleITicae9ssQMNA041Qn4AfN3lrTt46FnrImcK5r19VXMyDL9Xqeut/5ZU2BTv/Wsh/kTj+lnuUWoicOB0tuB0nPCL3drca9RmG41oIzjwwYs7Q8ndVnNgQ4uKxtGm7uVSnxnRx73915EQAncZ810G2iqyL5tfvcxHAsaCDiVp20cNiuDrQK6lpY6ZHBeAc3AiIfuBrKjgfLsfxP0/sroznK26iMv5Nc9G+K3+mnjiA490vSX/EH6SBemFGrydfZXubhEEjYkxTYNwHZNZqoePmRh1R000lCt5+e0m78l/LhtZni2nUsQ6d2vuoJzKvdFJJgEpGUM2JcEPPQIDAQAB";

    private static final byte[] SALT = new byte[] { -32, 12, 20, -111, 43, -77, 94, -14, 53, 58, -25, -15, 97, -127,
            -16, 93, -17, 52, -24, 79 };

    private LicenseChecker mChecker;
    private LicenseCheckerCallback mLicenseCheckerCallback;

    private String license;

    private MethodChannel channel;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        getWindow().addFlags(LayoutParams.FLAG_SECURE); //disable screen capture

        GeneratedPluginRegistrant.registerWith(this);

        channel = new MethodChannel(getFlutterView(), CHANNEL);
        channel.setMethodCallHandler((call, result) -> {
            if (call.method.equals("checkLicense")) {
                checkLicense();
            }
        });
    }

    void checkLicense() {
        String deviceId = Secure.getString(getContentResolver(), Secure.ANDROID_ID);
        mLicenseCheckerCallback = new MyLicenseCheckerCallback();
        mChecker = new LicenseChecker(this,
                new ServerManagedPolicy(this, new AESObfuscator(SALT, getPackageName(), deviceId)), BASE64_PUBLIC_KEY);

        mChecker.checkAccess(mLicenseCheckerCallback);

    }

    private class MyLicenseCheckerCallback implements LicenseCheckerCallback {
        public void allow(int policyReason) {
            if (isFinishing()) {
                return;
            }
            license = "YES " + Integer.toString(policyReason);
            sendLicense(license);
        }

        public void dontAllow(int policyReason) {
            if (isFinishing()) {
                return;
            }
            license = "NO " + Integer.toString(policyReason);
            sendLicense(license);
        }

        public void applicationError(int errorCode, String error) {
            if (isFinishing()) {
                return;
            }
            license = "NO " + Integer.toString(errorCode) + error;
            sendLicense(license);
        }
    }

    void sendLicense(String license) {
        channel.invokeMethod("sendLicense", license);
    }
}
