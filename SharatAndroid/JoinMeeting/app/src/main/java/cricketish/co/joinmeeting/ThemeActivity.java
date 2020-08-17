package cricketish.co.joinmeeting;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;

public class ThemeActivity extends AppCompatActivity {

    ImageView btnBack, ivLogoTheme;
    boolean activityBoolean;

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        View decorView = getWindow().getDecorView();
        int uiOptions = View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN;
        decorView.setSystemUiVisibility(uiOptions);

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_theme);

        btnBack = findViewById(R.id.btnBack);
        ivLogoTheme = findViewById(R.id.ivLogoTheme);

        activityBoolean = getIntent().getBooleanExtra("activity", true);
        if (activityBoolean) {
            btnBack.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent backIntent = new Intent(getApplicationContext(), ListView.class);
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