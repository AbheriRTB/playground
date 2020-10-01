package cricketish.co.joinmeeting.activities;

import android.app.AlarmManager;
import android.app.AlertDialog;
import android.app.DatePickerDialog;
import android.app.PendingIntent;
import android.app.TimePickerDialog;
import android.content.ClipData;
import android.content.ClipboardManager;
import android.content.Context;
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
import android.widget.TextView;
import android.widget.TimePicker;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;

import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.Calendar;

import cricketish.co.joinmeeting.R;
import cricketish.co.joinmeeting.utils.AlertReceiver;
import cricketish.co.joinmeeting.utils.ListAdaptor;

public class AddActivity extends AppCompatActivity {

    int years, day, hour, minutes, month, amOrPm, auto;
    boolean notify;
    String meet, meetLink, name, link, strMonth, timeOfDay, finalTime;
    ImageView btnZoom, btnWebex, btnGoogleMeet, btnJioMeet, btnPaste, btnOther, btnBack;
    TextView tvAutoIndicate;
    Button btnTime;
    FloatingActionButton btnAdd;
    EditText etName = null, etLink = null;
    ClipboardManager clipboardManager;
    Calendar calendar2 = Calendar.getInstance();


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
                Intent intent = new Intent(getApplicationContext(), ListViewActivity.class);
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
        setContentView(R.layout.activity_add);
        btnZoom = findViewById(R.id.btnZoom);
        btnGoogleMeet = findViewById(R.id.btnGMeet);
        btnOther = findViewById(R.id.btnOther);
        btnWebex = findViewById(R.id.btnWebex);
        btnPaste = findViewById(R.id.btnPaste);
        btnJioMeet = findViewById(R.id.btnJioMeet);
        btnTime = findViewById(R.id.btnTime);
        etName = findViewById(R.id.etName);
        etLink = findViewById(R.id.etLink);
        btnAdd = findViewById(R.id.btnAdd);
        btnBack = findViewById(R.id.btnBack);
        tvAutoIndicate = findViewById(R.id.tvAutoIndicate);
        clipboardManager = (ClipboardManager) getSystemService(CLIPBOARD_SERVICE);


        notify = getIntent().getBooleanExtra("notify", true);

        // For the auto permission dialog to popup only once or to never show again
        SharedPreferences prefs1 = getSharedPreferences("prefs1", MODE_PRIVATE);
        boolean firstTime1 = prefs1.getBoolean("firstStart1", true);
        //if (firstTime1)
        ///autoPermissionDialog();

        //ActionBar actionBar = getSupportActionBar();
        //actionBar.setTitle("Add");
        //actionBar.setDisplayHomeAsUpEnabled(true);

        /*if (auto == 1) {
            btnGoogleMeet.setVisibility(View.INVISIBLE);
            btnJioMeet.setVisibility(View.INVISIBLE);
            btnOther.setVisibility(View.INVISIBLE);
            btnWebex.setVisibility(View.INVISIBLE);
            btnZoom.setVisibility(View.INVISIBLE);
        } else if (auto == 2){
            btnAdd.setVisibility(View.INVISIBLE);
        }*/


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
                String meeting;
                if (isValidInput()){
                    meeting = "Valid Meeting";
                }else {
                    meeting = "Invalid Meeting";
                }
                String forAutoIndicate = "It is a "+meeting;
                tvAutoIndicate.setText(forAutoIndicate);
            }
        });

        btnBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent backToHomeIntent = new Intent(AddActivity.this, ListViewActivity.class);
                startActivity(backToHomeIntent);
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


        btnGoogleMeet.setOnClickListener(new View.OnClickListener() {
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
                btnPackage(meet);
            }
        });


        btnAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                automatedBtn();

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
            FileOutputStream file = openFileOutput("join.meeting.data.txt", MODE_PRIVATE | MODE_APPEND);
            OutputStreamWriter outputFile = new OutputStreamWriter(file);

            outputFile.write(name + "," + link + "," + meet + "," + day + "," + month + "," + year + "," + hour + "," + minutes + "\n");
            outputFile.close();
            Toast.makeText(AddActivity.this, "Successfully Saved", Toast.LENGTH_SHORT).show();
        } catch (IOException e) {
            Toast.makeText(AddActivity.this, e.getMessage(), Toast.LENGTH_SHORT).show();
        }
        Intent intentForAdaptor = new Intent(getApplicationContext(), ListAdaptor.class);
        //intentForAdaptor.putExtra("timeOfDay", timeOfDay);

    }

    //This is the popup-dialog
    public void openValidDialog() {
        AlertDialog.Builder linkDialog = new AlertDialog.Builder(AddActivity.this);
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
                        saveData(name, link, meet, day, month, years, hour, minutes);
                        Intent intentTwo = new Intent(getApplicationContext(), ListViewActivity.class);
                        intentTwo.putExtra("meet", meet);
                        intentTwo.putExtra("name", name);
                        intentTwo.putExtra("link", link);
                        intentTwo.putExtra("date", day);
                        intentTwo.putExtra("month", month);
                        intentTwo.putExtra("year", years);
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

    /* This is the date and time picker dialog
    private void setDateAndTimeOld() {
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
    }*/

    // This is the date and time picker dialog
    private void setDateAndTime() {
        final Calendar calendar = Calendar.getInstance();
        DatePickerDialog.OnDateSetListener dateSetListener = new DatePickerDialog.OnDateSetListener() {
            @Override
            public void onDateSet(DatePicker datePicker, int year, int ThisMonth, int dayOfMonth) {
                day = dayOfMonth;
                years = year;
                setMonth(ThisMonth);
                month = ThisMonth;
                calendar2 = calendar;

                calendar.set(Calendar.YEAR, year);
                calendar.set(Calendar.MONTH, ThisMonth);
                calendar.set(Calendar.DATE, dayOfMonth);

                TimePickerDialog.OnTimeSetListener timeSetListener = new TimePickerDialog.OnTimeSetListener() {
                    @Override
                    public void onTimeSet(TimePicker timePicker, int hourOfDay, int minute) {
                        hour = hourOfDay;
                        minutes = minute;

                        calendar.set(Calendar.HOUR, hourOfDay);
                        calendar.set(Calendar.MINUTE, minute);
                        setTimeOfDay(hourOfDay);

                        finalTime = day + "th " + strMonth + " " + years + " "
                                + hour + ":" + minutes + timeOfDay;
                        btnTime.setText(finalTime);
                        amOrPm = calendar.get(Calendar.AM_PM);
                    }
                };

                new TimePickerDialog(AddActivity.this, timeSetListener, calendar.get(Calendar.HOUR_OF_DAY),
                        calendar.get(Calendar.MINUTE), false).show();

            }
        };
        new DatePickerDialog(AddActivity.this, dateSetListener, calendar.get(Calendar.YEAR),
                calendar.get(Calendar.MONTH), calendar.get(Calendar.DAY_OF_MONTH)).show();

    }

    // This method passes Intent values from this activity to the Adaptor
    private void passIntent() {
        Intent intent = new Intent(getApplicationContext(), ListViewActivity.class);
        intent.putExtra("meet", meet);
        intent.putExtra("name", name);
        intent.putExtra("link", link);
        intent.putExtra("date", day);
        intent.putExtra("month", month);
        intent.putExtra("year", years);
        intent.putExtra("hour", hour);
        intent.putExtra("minutes", minutes);
        Intent adaptorIntent = new Intent(AddActivity.this, ListAdaptor.class);
        adaptorIntent.putExtra("AM_PM", amOrPm);
        startActivity(intent);
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
        String address = "http";
        String address2 = "://";
        if (isValidInput()) {
            if (link.contains(meetLink) && link.contains(address) && link.contains(address2)) {
                saveData(name, link, meet, day, month, years, hour, minutes);
                passIntent();

            } else {
                openValidDialog();
            }

        } else {
            Toast.makeText(AddActivity.this, "Please enter all fields", Toast.LENGTH_SHORT).show();
        }
    }

    // This method passes the intent, saves the data and moves to the List View (For Other)
    private void btnPackage(String meet) {
        name = getName();
        link = getLink();
        if (isValidInput()) {
            saveData(name, link, meet, day, month, years, hour, minutes);
            passIntent();
            Intent intent3 = new Intent(AddActivity.this, ListViewActivity.class);
            startAlarm(calendar2);

        } else {
            Toast.makeText(AddActivity.this, "Please enter all fields", Toast.LENGTH_SHORT).show();
        }
    }

    // This is the clipboard Data
    private void clipData() {
        ClipData clipData = clipboardManager.getPrimaryClip();
        ClipData.Item item = null;
        item = clipData.getItemAt(0);
        if (item == null || item.getText().length() == 0) {
            Toast.makeText(this, "Nothing in the clipboard", Toast.LENGTH_SHORT).show();
        } else {
            etLink.setText(item.getText());
            etLink.setTextColor(ContextCompat.getColor(AddActivity.this, R.color.color3rd));
            Toast.makeText(AddActivity.this, "Pasted", Toast.LENGTH_LONG).show();
        }


    }

    // Start scheduled notification
    private void startAlarm(Calendar c) {
        AlarmManager alarmManager = (AlarmManager) getSystemService(Context.ALARM_SERVICE);
        Intent intent = new Intent(this, AlertReceiver.class);
        PendingIntent pendingIntent = PendingIntent.getBroadcast(this, 1, intent, 0);
        if (c.before(Calendar.getInstance())) {
            c.add(Calendar.DATE, 1);
        }
        alarmManager.setExact(AlarmManager.RTC_WAKEUP, c.getTimeInMillis(), pendingIntent);
    }

    // AM Or PM?
    private void setTimeOfDay(int hourOfDay) {
        if (hourOfDay >= 0 && hourOfDay < 12) {
            timeOfDay = "AM";
        } else {
            if (hourOfDay == 12) {
                timeOfDay = "PM";
            } else {
                hourOfDay = hourOfDay - 12;
                timeOfDay = "PM";
            }
        }
    }

    // For the automated add btn
    private void automatedBtn() {
        name = getName();
        link = getLink();
        String address = "http";
        String address2 = "://";


        if (isValidInput()) {
            if (link.contains("zoom") && link.contains(address) && link.contains(address2)) {
                meetLink = "zoom";
                meet = "zoom";
            } else if (link.contains("webex") && link.contains(address) && link.contains(address2)) {
                meetLink = "webex";
                meet = "webex";
            } else if (link.contains("meet.google") && link.contains(address) && link.contains(address2)) {
                meetLink = "meet.google";
                meet = "google";
            } else if (link.contains("jio") && link.contains(address) && link.contains(address2)) {
                meetLink = "jio";
                meet = "jiomeet";
            } else if (link.contains(address) && link.contains(address2)) {
                meet = "other";
            } else {
                openValidDialog();
            }
            saveData(name, link, meet, day, month, years, hour, minutes);
            passIntent();

        } else {
            Toast.makeText(AddActivity.this, "Please enter all fields", Toast.LENGTH_SHORT).show();
        }
    }

    // Automated btn permission
    private void autoPermissionDialog() {
        final androidx.appcompat.app.AlertDialog.Builder permitDialog =
                new androidx.appcompat.app.AlertDialog.Builder(AddActivity.this);
        permitDialog.setTitle("Automated Link")

                .setMessage("Our new feature allows you to add a meet without mentioning " +
                        "the meeting host, dou you want to enable it? For now you cant change it later.")

                .setPositiveButton("enable", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        auto = 1;

                    }
                })

                .setNegativeButton("later", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        auto = 2;
                    }
                });
        SharedPreferences prefs1 = getSharedPreferences("prefs1", MODE_PRIVATE);
        SharedPreferences.Editor editor1 = prefs1.edit();
        editor1.putBoolean("firstTime1", false);
        editor1.apply();
        permitDialog.create().show();
    }

}