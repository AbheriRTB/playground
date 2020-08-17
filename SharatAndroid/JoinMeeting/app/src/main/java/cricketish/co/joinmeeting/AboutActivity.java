package cricketish.co.joinmeeting;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Toast;

public class AboutActivity extends AppCompatActivity {


    ImageView ivMail, ivPlay;
    String to, subject, message;
    boolean activityIntent;

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.about, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {

        switch (item.getItemId()) {
            case R.id.btnThemeAction:
                Intent menueIntent = new Intent(getApplicationContext(), ThemeActivity.class);
                activityIntent = false;
                menueIntent.putExtra("activity", menueIntent);
                startActivity(menueIntent);
                break;
        }

        return super.onOptionsItemSelected(item);
    }

    // App is created here
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_about);


        ActionBar actionBar = getSupportActionBar();
        actionBar.setTitle("About");
        actionBar.setDisplayHomeAsUpEnabled(true);


        ivMail = findViewById(R.id.ivMail);
        ivPlay = findViewById(R.id.ivPlay);
        to = "sharatchandrats@gmail.com";
        subject = "Feedback on Join app";
        message = "This is a feedback on my experience on Join v1.02.2.2 Beta";

        ivPlay.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(android.content.Intent.ACTION_VIEW,
                        Uri.parse("https://sites.google.com/view/downloadjoin/home"));
                AboutActivity.this.startActivity(intent);
            }
        });

        ivMail.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent email = new Intent(Intent.ACTION_SEND);
                email.setType("plain/text");
                email.putExtra(Intent.EXTRA_EMAIL, new String[]{to});
                email.putExtra(Intent.EXTRA_SUBJECT, subject);
                email.putExtra(Intent.EXTRA_TEXT, message);
                startActivity(Intent.createChooser(email, ""));
            }
        });

    }
}