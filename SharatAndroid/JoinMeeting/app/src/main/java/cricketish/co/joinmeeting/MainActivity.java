package cricketish.co.joinmeeting;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.ClipData;
import android.content.ClipboardManager;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;

public class MainActivity extends AppCompatActivity implements PopupDialog.PopupListner {


    ImageView btnZoom, btnWebex, btnGMeet, btnJioMeet;
    Button btnPaste, btnOther;
    EditText etName = null, etLink = null;
    String meet, name, link;
    ArrayList<List> events;
    PopupDialog dialog;
    ClipboardManager clipboardManager;


    // This function is to bring the button on the Action Bar (Till 56)
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {

        getMenuInflater().inflate(R.menu.main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {

        switch (item.getItemId()) {
            case R.id.btnList:
                Intent intent = new Intent(getApplicationContext(), cricketish.co.joinmeeting.ListView.class);
                startActivity(intent);
            case R.id.btnHelp:
                intent = new Intent(getApplicationContext(), cricketish.co.joinmeeting.HelpActivity.class);
                startActivity(intent);

        }

        return super.onOptionsItemSelected(item);
    }


    //  App is created here
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        btnZoom = findViewById(R.id.btnZoom);
        btnGMeet = findViewById(R.id.btnGMeet);
        btnOther = findViewById(R.id.btnOther);
        btnWebex = findViewById(R.id.btnWebex);
        btnPaste = findViewById(R.id.btnPaste);
        btnJioMeet = findViewById(R.id.btnJioMeet);
        etName = findViewById(R.id.etName);
        etLink = findViewById(R.id.etLink);
        dialog = new PopupDialog();
        clipboardManager = (ClipboardManager) getSystemService(CLIPBOARD_SERVICE);


        btnPaste.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                ClipData clipData = clipboardManager.getPrimaryClip();
                ClipData.Item item = clipData.getItemAt(0);
                link = item.toString().trim();
                Toast.makeText(MainActivity.this, "Pasted" + link, Toast.LENGTH_LONG).show();

            }

        });
        if (etName == null || etLink == null) {
            Toast.makeText(this, "", Toast.LENGTH_SHORT).show();

        } else {

            btnZoom.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    meet = "zoom";
                    name = getName();
                    link = getLink();
                    if (link.contains("zoom")) {
                        saveData(name, link, meet);
                        Intent intent = new Intent(getApplicationContext(), cricketish.co.joinmeeting.ListView.class);
                        intent.putExtra("meet", meet);
                        intent.putExtra("name", name);
                        intent.putExtra("link", link);
                        Intent intentToPopup = new Intent(getApplicationContext(), cricketish.co.joinmeeting.PopupDialog.class);
                        intentToPopup.putExtra("meet", meet);
                        startActivity(intentToPopup);
                        startActivity(intent);
                    } else {
                        openDialog();

                    }

                }
            });
            btnWebex.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    meet = "webex";
                    name = getName();
                    //link = getLink();
                    if (link.contains("webex")) {
                        saveData(name, link, meet);
                        Intent intent = new Intent(getApplicationContext(), cricketish.co.joinmeeting.ListView.class);
                        intent.putExtra("meet", meet);
                        intent.putExtra("name", name);
                        intent.putExtra("link", link);
                        startActivity(intent);
                        Intent intentToPopup = new Intent(getApplicationContext(), cricketish.co.joinmeeting.PopupDialog.class);
                        intentToPopup.putExtra("meet", meet);
                        startActivity(intentToPopup);
                    } else {
                        openDialog();
                    }


                }
            });
            btnGMeet.setOnClickListener(new View.OnClickListener() {
                @Override

                public void onClick(View view) {
                    meet = "google";
                    name = getName();
                    link = getLink();
                    if (link.contains("meet.google")) {
                        saveData(name, link, meet);
                        Intent intent = new Intent(getApplicationContext(), cricketish.co.joinmeeting.ListView.class);
                        intent.putExtra("meet", meet);
                        intent.putExtra("name", name);
                        intent.putExtra("link", link);
                        startActivity(intent);
                        Intent intentToPopup = new Intent(getApplicationContext(), cricketish.co.joinmeeting.PopupDialog.class);
                        intentToPopup.putExtra("meet", meet);
                        startActivity(intentToPopup);
                    } else {
                        openDialog();

                    }

                }
            });
            btnJioMeet.setOnClickListener(new View.OnClickListener() {
                @Override

                public void onClick(View view) {
                    meet = "jiomeet";
                    name = getName();
                    link = getLink();
                    if (link.contains("jio")) {
                        saveData(name, link, meet);
                        Intent intent = new Intent(getApplicationContext(), cricketish.co.joinmeeting.ListView.class);
                        intent.putExtra("meet", meet);
                        intent.putExtra("name", name);
                        intent.putExtra("link", link);
                        startActivity(intent);
                        Intent intentToPopup = new Intent(getApplicationContext(), cricketish.co.joinmeeting.PopupDialog.class);
                        intentToPopup.putExtra("meet", meet);
                        startActivity(intentToPopup);
                    } else {
                        openDialog();

                    }

                }
            });
            btnOther.setOnClickListener(new View.OnClickListener() {
                @Override

                public void onClick(View view) {
                    meet = "other";
                    name = getName();
                    link = getLink();
                    saveData(name, link, meet);
                    Intent intent = new Intent(getApplicationContext(), cricketish.co.joinmeeting.ListView.class);
                    intent.putExtra("meet", meet);
                    intent.putExtra("name", name);
                    intent.putExtra("link", link);
                    startActivity(intent);
                    Intent intentToPopup = new Intent(getApplicationContext(), cricketish.co.joinmeeting.PopupDialog.class);
                    intentToPopup.putExtra("meet", meet);
                    startActivity(intentToPopup);


                }
            });

        }

    }


    //  Name is extracted here from etName
    String getName() {
        final String name = etName.getText().toString().trim();
        return name;
    }

    //  Name is extracted here from etName
    String getLink() {
        final String link = etLink.getText().toString().trim();
        return link;
    }

    //  This is the method to save the data in the .txt file
    void saveData(String name, String link, String meet) {

        try {
            FileOutputStream file = openFileOutput("cricketish.data.txt", MODE_PRIVATE | MODE_APPEND);
            OutputStreamWriter outputFile = new OutputStreamWriter(file);

            outputFile.write(name + "," + link + "," + meet + "\n");
            outputFile.close();
            Toast.makeText(MainActivity.this, "Successfully Saved", Toast.LENGTH_SHORT).show();
        } catch (IOException e) {
            Toast.makeText(MainActivity.this, e.getMessage(), Toast.LENGTH_SHORT).show();
        }

    }


    //This is the popup-dialog
    public void openDialog() {
        PopupDialog dialog = new PopupDialog();
        dialog.show(getSupportFragmentManager(), "example.dialog");

    }

    //If the user clicks ignore & proceeds to the list
    @Override
    public void onIgnoreClicked() {
        name = getName();
        link = getLink();
        saveData(name, link, meet);
        Intent intentTwo = new Intent(getApplicationContext(), cricketish.co.joinmeeting.ListView.class);
        intentTwo.putExtra("meet", meet);
        intentTwo.putExtra("name", name);
        intentTwo.putExtra("link", link);
        startActivity(intentTwo);
    }

}