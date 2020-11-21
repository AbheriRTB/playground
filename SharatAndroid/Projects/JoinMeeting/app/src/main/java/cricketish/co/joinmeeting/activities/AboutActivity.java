package cricketish.co.joinmeeting.activities;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.Toast;

import cricketish.co.joinmeeting.R;

public class AboutActivity extends AppCompatActivity {


    ImageView ivMail, ivPlay, btnBack2;
    String to, subject, message;
    boolean response;

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.about, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        if (item.getItemId() == R.id.btnThemeAction) {
            //Intent intent = new Intent(getApplicationContext(), ThemeActivity.class);
            //startActivity(intent);
            Toast.makeText(this, "No Themes available now", Toast.LENGTH_SHORT).show();
        }

        return super.onOptionsItemSelected(item);
    }

    // App is created here
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_about);


        //ActionBar actionBar = getSupportActionBar();
        //actionBar.setTitle("About");
        //actionBar.setDisplayHomeAsUpEnabled(true);


        ivMail = findViewById(R.id.ivMail);
        ivPlay = findViewById(R.id.ivPlay);
        btnBack2 = findViewById(R.id.btnBack2);
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
                feedbackDialog();
            }
        });
        btnBack2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent backToHomeIntent = new Intent(AboutActivity.this, ListViewActivity.class);
                startActivity(backToHomeIntent);
            }
        });
    }

    private void feedbackDialog() {
        AlertDialog.Builder settingsDialog = new AlertDialog.Builder(AboutActivity.this);
        settingsDialog.setTitle("FeedBack")
                .setMessage("You can now fill your feedback in a form," +
                        "do you want to fill the form or just email it?")
                .setNegativeButton("Email it", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        Intent email = new Intent(Intent.ACTION_SEND);
                        email.setType("plain/text");
                        email.putExtra(Intent.EXTRA_EMAIL, new String[]{to});
                        email.putExtra(Intent.EXTRA_SUBJECT, subject);
                        email.putExtra(Intent.EXTRA_TEXT, message);
                        startActivity(Intent.createChooser(email, ""));

                    }
                })
                .setPositiveButton("Forms", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        final String formsLink = "https://forms.gle/8QbJZHrGxQMNHFnX9";
                        Intent forms = new Intent(android.content.Intent.ACTION_VIEW,
                                Uri.parse(formsLink));
                        AboutActivity.this.startActivity(forms);
                    }
                })
                .create().show();
    }
}