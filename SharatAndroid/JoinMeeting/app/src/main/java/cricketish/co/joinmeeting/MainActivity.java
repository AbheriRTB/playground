package cricketish.co.joinmeeting;

import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.app.DatePickerDialog;
import android.app.TimePickerDialog;
import android.content.ClipData;
import android.content.ClipboardManager;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TimePicker;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.Calendar;

public class MainActivity extends AppCompatActivity {

    int year, day, hour, minutes, monthTwo;
    String meet, meetLink, name, link, dateAndTime, strMonth, timeOfDay;
    ImageView btnZoom, btnWebex, btnGMeet, btnJioMeet, btnPaste;
    Button btnOther, btnTime;
    EditText etName = null, etLink = null;
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
                overridePendingTransition(android.R.anim.slide_in_left, android.R.anim.slide_out_right);
                break;
            case R.id.btnHelp:
                intent = new Intent(getApplicationContext(), AboutActivity.class);
                startActivity(intent);
                overridePendingTransition(android.R.anim.slide_in_left, android.R.anim.slide_out_right);
                break;

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
        btnTime = findViewById(R.id.btnTime);
        etName = findViewById(R.id.etName);
        etLink = findViewById(R.id.etLink);
        clipboardManager = (ClipboardManager) getSystemService(CLIPBOARD_SERVICE);
        btnTime.setText(null);

        SharedPreferences prefs = getSharedPreferences("prefs", MODE_PRIVATE);
        boolean firstTime = prefs.getBoolean("firstStart", true);

        ActionBar actionBar = getSupportActionBar();
        actionBar.setTitle("Add");
        actionBar.setDisplayHomeAsUpEnabled(true);


        btnPaste.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                clipData();
            }

        });

        btnTime.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                setDateAndTime();
            }
        });

        btnZoom.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                meet = "zoom";
                meetLink = "zoom";
                btnPackage(meet, meetLink);
            }
        });


        btnWebex.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                meet = "webex";
                meetLink = "webex";
                btnPackage(meet, meetLink);
            }
        });


        btnGMeet.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                meet = "google";
                meetLink = "meet.google";
                btnPackage(meet, meetLink);
            }
        });


        btnJioMeet.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                meet = "jiomeet";
                meetLink = "jio";
                btnPackage(meet, meetLink);
            }
        });


        btnOther.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                meet = "other";
                name = getName();
                link = getLink();
                if (isValidInput()) {
                    saveData(name, link, meet, day, monthTwo, year, hour, minutes);
                    passIntent();
                } else {
                    Toast.makeText(MainActivity.this, "Please enter all fields", Toast.LENGTH_SHORT).show();
                }                /*name = getName();
                link = getLink();
                if (isValidInput()) {
                    saveData(name, link, meet, day, monthTwo, year, hour, minutes);
                    passIntent();
                } else {
                    Toast.makeText(MainActivity.this, "Please enter all fields", Toast.LENGTH_SHORT).show();
                }*/
            }
        });

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
    void saveData(String name, String link, String meet,
                  int day, int month, int year, int hour, int minutes) {

        try {
            FileOutputStream file = openFileOutput("cricketish.data.txt", MODE_PRIVATE | MODE_APPEND);
            OutputStreamWriter outputFile = new OutputStreamWriter(file);

            outputFile.write(name + "," + link + "," + meet + "," + day + "," + month + "," + year + "," + hour + "," + minutes + "\n");
            outputFile.close();
            Toast.makeText(MainActivity.this, "Successfully Saved", Toast.LENGTH_SHORT).show();
        } catch (IOException e) {
            Toast.makeText(MainActivity.this, e.getMessage(), Toast.LENGTH_SHORT).show();
        }
        Intent intentForAdaptor = new Intent(getApplicationContext(), ListAdaptor.class);
        intentForAdaptor.putExtra("timeOfDay", timeOfDay);

    }


    //This is the popup-dialog
    public void openDialog() {
        AlertDialog.Builder linkDialog = new AlertDialog.Builder(MainActivity.this);
        linkDialog.setTitle("Warning!")
                .setMessage("This might not be a valid app link, check the link again. " +
                        "If this is an error please click ignore to continue")

                .setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                    }
                })

                .setPositiveButton("Ignore", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        name = getName();
                        link = getLink();
                        saveData(name, link, meet, day, monthTwo, year, hour, minutes);
                        Intent intentTwo = new Intent(getApplicationContext(), cricketish.co.joinmeeting.ListView.class);
                        intentTwo.putExtra("meet", meet);
                        intentTwo.putExtra("name", name);
                        intentTwo.putExtra("link", link);
                        intentTwo.putExtra("date", day);
                        intentTwo.putExtra("month", monthTwo);
                        intentTwo.putExtra("year", year);
                        intentTwo.putExtra("hour", hour);
                        intentTwo.putExtra("minutes", minutes);
                        startActivity(intentTwo);
                    }
                })

                .create().show();

    }


    // Method for converting month value to a printable format (eg 0 - Jan, 1 - Feb...)
    private void setMonth(int month) {
        switch (month) {
            case 0:
                strMonth = "Jan";
                break;
            case 1:
                strMonth = "Feb";
                break;
            case 2:
                strMonth = "Mar";
                break;
            case 3:
                strMonth = "Apr";
                break;
            case 4:
                strMonth = "May";
                break;
            case 5:
                strMonth = "Jun";
                break;
            case 6:
                strMonth = "Jul";
                break;
            case 7:
                strMonth = "Aug";
                break;
            case 8:
                strMonth = "Sep";
                break;
            case 9:
                strMonth = "Oct";
                break;
            case 10:
                strMonth = "Nov";
                break;
            case 11:
                strMonth = "Dec";
                break;
        }
    }

    // This is the date and time picker dialog
    private void setDateAndTime() {
        final Calendar calendar = Calendar.getInstance();
        int YEAR = calendar.get(Calendar.YEAR);
        int MONTH = calendar.get(Calendar.MONTH);
        int DATE = calendar.get(Calendar.DATE);
        int HOUR = calendar.get(Calendar.HOUR_OF_DAY);
        int MINUTE = calendar.get(Calendar.MINUTE);

        TimePickerDialog timePickerDialog = new TimePickerDialog(MainActivity.this, new TimePickerDialog.OnTimeSetListener() {
            @SuppressLint("SetTextI18n")
            @Override
            public void onTimeSet(TimePicker timePicker, int hourThis, int minutesThis) {

                hour = hourThis;
                minutes = minutesThis;

            }
        }, HOUR, MINUTE, false);
        timePickerDialog.updateTime(hour, minutes);

        DatePickerDialog datePickerDialog = new DatePickerDialog(MainActivity.this, new DatePickerDialog.OnDateSetListener() {
            @Override
            public void onDateSet(DatePicker datePicker, int year, int month, int dateThis) {

                setMonth(month);
                String date = dateThis + "th " + strMonth + " " + year + " ";
                dateAndTime = date;
                monthTwo = month;
                day = dateThis;
                String strMinutes = "00";
                if (minutes == 1) {
                    strMinutes = "0" + minutes;
                }
                String total = dateAndTime + hour + ":" + strMinutes;
                btnTime.setText(total);

            }
        }, YEAR, MONTH, DATE);
        datePickerDialog.show();
        timePickerDialog.show();
    }

    // This method passes Intent values from this activity to the Adaptor
    private void passIntent() {
        Intent intent = new Intent(getApplicationContext(), cricketish.co.joinmeeting.ListView.class);
        intent.putExtra("meet", meet);
        intent.putExtra("name", name);
        intent.putExtra("link", link);
        intent.putExtra("date", day);
        intent.putExtra("month", monthTwo);
        intent.putExtra("year", year);
        intent.putExtra("hour", hour);
        intent.putExtra("minutes", minutes);
        /*Intent intentToPopup = new Intent(getApplicationContext(), cricketish.co.joinmeeting.PopupDialog.class);
        intentToPopup.putExtra("meet", meet);
        startActivity(intentToPopup);*/
        startActivity(intent);
        overridePendingTransition(android.R.anim.slide_in_left, android.R.anim.slide_out_right);
    }

    // Checks if all the fields are complete
    private boolean isValidInput() {
        return (etName.getText() != null && etName.getText().toString().length() > 0) &&
                (etLink.getText() != null && etLink.getText().toString().length() > 0) &&
                (btnTime.getText() != null && btnTime.getText().toString().length() > 0);
    }

    // This method passes the intent, saves the data and moves to the List View
    private void btnPackage(String meet, String meetLink) {
        name = getName();
        link = getLink();
        if (isValidInput()) {
            if (link.contains(meetLink)) {
                saveData(name, link, meet, day, monthTwo, year, hour, minutes);
                passIntent();

            } else {
                openDialog();
            }

        } else {
            Toast.makeText(MainActivity.this, "Please enter all fields", Toast.LENGTH_SHORT).show();
        }
    }

    // This is the clipboard Data
    private void clipData() {
        ClipData clipData = clipboardManager.getPrimaryClip();
        ClipData.Item item = null;
        try {
            item = clipData.getItemAt(0);
        }
        catch (NullPointerException e){
            Toast.makeText(this, e.getMessage(), Toast.LENGTH_SHORT).show();
        }
        etLink.setText(item.getText());
        etLink.setTextColor(ContextCompat.getColor(MainActivity.this, R.color.color3rd));
        Toast.makeText(MainActivity.this, "Pasted", Toast.LENGTH_LONG).show();

    }

}