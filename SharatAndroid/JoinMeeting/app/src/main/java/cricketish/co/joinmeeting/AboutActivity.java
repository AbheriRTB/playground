package cricketish.co.joinmeeting;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;

public class AboutActivity extends AppCompatActivity {


    ImageView ivMail, ivPlay;


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

        ivPlay.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(android.content.Intent.ACTION_VIEW,
                        Uri.parse("https://www.youtube.com"));
                AboutActivity.this.startActivity(intent);
            }
        });

        ivMail.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(android.content.Intent.ACTION_VIEW,
                        Uri.parse("https://www.gmail.com"));
                AboutActivity.this.startActivity(intent);
            }
        });

    }
}