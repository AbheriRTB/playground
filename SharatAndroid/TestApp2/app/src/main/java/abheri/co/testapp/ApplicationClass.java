package abheri.co.testapp;

import android.app.Application;

import com.backendless.Backendless;

public class ApplicationClass extends Application {

    public static final String APPLICATION_ID = "7AF16FAF-6762-6580-FFE7-755622175800";
    public static final String API_KEY = "0DAF38F1-E69E-4131-B28D-D40AA1A78F5C";
    public static final String SERVER_URL = "api.backendless.com";

    @Override
    public void onCreate() {
        super.onCreate();

        Backendless.setUrl(SERVER_URL);
        Backendless.initApp(getApplicationContext(),
                APPLICATION_ID,
                API_KEY);
    }
}
