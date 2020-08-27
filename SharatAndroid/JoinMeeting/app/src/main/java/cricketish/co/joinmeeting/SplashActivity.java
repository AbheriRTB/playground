package cricketish.co.joinmeeting;

import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.ImageView;

import java.util.Timer;
import java.util.TimerTask;

public class SplashActivity extends AppCompatActivity {

    ImageView ivSplash;
    Animation animation;
    public static Context c;
    Activity self;
    long Delay = 3000;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        requestWindowFeature(Window.FEATURE_NO_TITLE);
        View decorView = getWindow().getDecorView();

        int uiOptions = View.SYSTEM_UI_FLAG_HIDE_NAVIGATION;
        decorView.setSystemUiVisibility(uiOptions);

        setContentView(R.layout.activity_splash);




        //Intent intent = new Intent(this, ListView.class);
        //startActivity(intent);

        self = this;

        // Create a Timer
        Timer RunSplash = new Timer();

        // Task to do when the timer ends
        TimerTask ShowSplash = new TimerTask() {
            @Override
            public void run() {
                //Create database by invoking get topics
                /*TopicDataSource ts = new TopicDataSource(c);
                ts.open();
                ts.getAllTopics();
                ts.close(); */
                int i = 0;


                Intent myIntent;
                myIntent = new Intent(self, ListView.class);

                // Close SplashScreenActivity.class
                finish();


                // Start MainActivity.class
                startActivity(myIntent);
                overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out);

            }
        };

        // Start the timer
        RunSplash.schedule(ShowSplash, Delay);
    }

    public static Context getAppContext()
    {
        return c;
    }

}