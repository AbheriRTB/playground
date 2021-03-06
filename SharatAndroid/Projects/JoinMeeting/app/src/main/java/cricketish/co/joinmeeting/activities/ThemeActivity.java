package cricketish.co.joinmeeting.activities;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;

import cricketish.co.joinmeeting.R;

public class ThemeActivity extends AppCompatActivity {

    ImageView btnBack;
    boolean activityBoolean;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_theme);

        btnBack = findViewById(R.id.btnBack);

        activityBoolean = getIntent().getBooleanExtra("activity", true);
        if (activityBoolean) {
            btnBack.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent backIntent = new Intent(getApplicationContext(), ListViewActivity.class);
                    startActivity(backIntent);
                }
            });
        } else {
            btnBack.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent backIntent = new Intent(getApplicationContext(), AboutActivity.class);
                    startActivity(backIntent);
                }
            });
        }
    }

}