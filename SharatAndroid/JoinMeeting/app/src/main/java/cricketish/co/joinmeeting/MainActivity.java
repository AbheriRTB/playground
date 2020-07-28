package cricketish.co.joinmeeting;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    Button btnZoom, btnWebex, btnGMeet, btnJMeet;
    EditText etName, etLink;
    String meet, name, link;
    ArrayList<List> events;

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

        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        btnZoom = findViewById(R.id.btnZoom);
        btnGMeet = findViewById(R.id.btnGMeet);
        btnWebex = findViewById(R.id.btnWebex);
        etName = findViewById(R.id.etName);
        etLink = findViewById(R.id.etLink);


        if (etName != null & etLink != null) {
            btnZoom.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    meet = "zoom";
                    name = getName();
                    link = getLink();
                    saveData(name, link, meet);
                    Intent intent = new Intent(getApplicationContext(), cricketish.co.joinmeeting.ListView.class);
                    intent.putExtra("meet", meet);
                    intent.putExtra("name", name);
                    intent.putExtra("link", link);
                    startActivity(intent);


                }
            });
            btnWebex.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    meet = "webex";
                    name = getName();
                    link = getLink();
                    saveData(name, link, meet);
                    Intent intent = new Intent(getApplicationContext(), cricketish.co.joinmeeting.ListView.class);
                    intent.putExtra("meet", meet);
                    intent.putExtra("name", name);
                    intent.putExtra("link", link);
                    startActivity(intent);


                }
            });
            btnGMeet.setOnClickListener(new View.OnClickListener() {
                @Override

                public void onClick(View view) {
                    meet = "google";
                    name = getName();
                    link = getLink();
                    saveData(name, link, meet);
                    Intent intent = new Intent(getApplicationContext(), cricketish.co.joinmeeting.ListView.class);
                    intent.putExtra("meet", meet);
                    intent.putExtra("name", name);
                    intent.putExtra("link", link);
                    startActivity(intent);

                }
            });/*btnJMeet.setOnClickListener(new View.OnClickListener() {
                @Override

                public void onClick(View view) {
                    meet = "jiomeet";
                    name = getName();
                    link = getLink();
                    saveData(name, link, meet);
                    Intent intent = new Intent(getApplicationContext(), cricketish.co.joinmeeting.ListView.class);
                    intent.putExtra("meet", meet);
                    intent.putExtra("name", name);
                    intent.putExtra("link", link);
                    startActivity(intent);

                }
            });*/

        }
        else {
            Toast.makeText(this, "Enter all fields", Toast.LENGTH_SHORT).show();

        }
    }


    String getName(){
        final String name = etName.getText().toString().trim();
        return name;
    }

    String getLink(){
        final String link = etLink.getText().toString().trim();
        return link;
    }
    void saveData(String name, String link, String meet){

        try {
            FileOutputStream file = openFileOutput("cricketish.data.txt", MODE_PRIVATE|MODE_APPEND);
            OutputStreamWriter outputFile = new OutputStreamWriter(file);

            outputFile.write(name + "," + link + "," + meet + "\n");
            outputFile.close();
            Toast.makeText(MainActivity.this, "Successfully Saved", Toast.LENGTH_SHORT).show();
        }
        catch (IOException e){
            Toast.makeText(MainActivity.this, e.getMessage(), Toast.LENGTH_SHORT).show();
        }

    }

}