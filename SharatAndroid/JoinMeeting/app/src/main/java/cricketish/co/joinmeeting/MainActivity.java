package cricketish.co.joinmeeting;

import android.annotation.SuppressLint;
import android.app.DatePickerDialog;
import android.app.TimePickerDialog;
import android.content.ClipData;
import android.content.ClipboardManager;
import android.content.Intent;
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

public class MainActivity extends AppCompatActivity implements PopupDialog.PopupListner {


    boolean allDataGiven = false;
    int year, day, hour, minutes;
    ImageView btnZoom, btnWebex, btnGMeet, btnJioMeet, btnPaste;
    Button btnOther, btnTime;
    EditText etName = null, etLink = null;
    String meet, name, link, dateAndTime, strMonth, strMonth2, timeOfDay;
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
        dialog = new PopupDialog();
        clipboardManager = (ClipboardManager) getSystemService(CLIPBOARD_SERVICE);
        btnTime.setText(null);


        ActionBar actionBar = getSupportActionBar();
        actionBar.setTitle("Add");
        actionBar.setDisplayHomeAsUpEnabled(true);


        btnPaste.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                ClipData clipData = clipboardManager.getPrimaryClip();
                ClipData.Item item = clipData.getItemAt(0);
                if ((item.getText() == null) && (item.getText().length() > 0)) {
                    etLink.setText(item.getText());
                    etLink.setTextColor(ContextCompat.getColor(MainActivity.this, R.color.color3rd));
                    Toast.makeText(MainActivity.this, "Pasted", Toast.LENGTH_LONG).show();
                } else {
                    Toast.makeText(MainActivity.this, "No link to paste", Toast.LENGTH_SHORT).show();
                }
            }

        });

        btnTime.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                final Calendar calendar = Calendar.getInstance();
                int YEAR = calendar.get(Calendar.YEAR);
                int MONTH = calendar.get(Calendar.MONTH);
                int DATE = calendar.get(Calendar.DATE);

                TimePickerDialog timePickerDialog = new TimePickerDialog(MainActivity.this, new TimePickerDialog.OnTimeSetListener() {
                    @SuppressLint("SetTextI18n")
                    @Override
                    public void onTimeSet(TimePicker timePicker, int hourThis, int minutesThis) {
                        hour = hourThis;
                        minutes = minutesThis;

                    }
                }, 12, 0, false);
                timePickerDialog.updateTime(hour, minutes);

                DatePickerDialog datePickerDialog = new DatePickerDialog(MainActivity.this, new DatePickerDialog.OnDateSetListener() {
                    @Override
                    public void onDateSet(DatePicker datePicker, int year, int month, int dateThis) {
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

                        String date = dateThis + "th " + strMonth + " " + year + " ";
                        dateAndTime = date;
                        strMonth2 = strMonth;
                        day = dateThis;
                        String total = dateAndTime + hour + ":" + minutes;
                        btnTime.setText(total);

                    }
                }, YEAR, MONTH, DATE);
                datePickerDialog.show();
                timePickerDialog.show();


            }
        });

        btnZoom.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                meet = "zoom";
                name = getName();
                link = getLink();
                allDataGiven = false;
                if ((etName.getText() != null && etName.getText().toString().length() > 0) &&
                        (etLink.getText() != null && etLink.getText().toString().length() > 0) &&
                        (btnTime.getText() != null && btnTime.getText().toString().length() > 0)) {
                    allDataGiven = true;
                }
                if (allDataGiven) {
                    if (link.contains("zoom")) {
                        saveData(name, link, meet, day, strMonth2, year, hour, minutes);
                        Intent intent = new Intent(getApplicationContext(), cricketish.co.joinmeeting.ListView.class);
                        intent.putExtra("meet", meet);
                        intent.putExtra("name", name);
                        intent.putExtra("link", link);
                        intent.putExtra("date", day);
                        intent.putExtra("month", strMonth2);
                        intent.putExtra("year", year);
                        intent.putExtra("hour", hour);
                        intent.putExtra("minutes", minutes);
                        Intent intentToPopup = new Intent(getApplicationContext(), cricketish.co.joinmeeting.PopupDialog.class);
                        intentToPopup.putExtra("meet", meet);
                        startActivity(intentToPopup);
                        startActivity(intent);
                        overridePendingTransition(android.R.anim.slide_in_left, android.R.anim.slide_out_right);

                    } else {
                        openDialog();
                    }
                } else {
                    Toast.makeText(MainActivity.this, "Please enter all fields", Toast.LENGTH_SHORT).show();
                }

            }
        });
        btnWebex.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                meet = "webex";
                name = getName();
                link = getLink();
                allDataGiven = false;
                if ((etName.getText() != null && etName.getText().toString().length() > 0) &&
                        (etLink.getText() != null && etLink.getText().toString().length() > 0) &&
                        (btnTime.getText() != null && btnTime.getText().toString().length() > 0)) {
                    allDataGiven = true;
                }
                if (allDataGiven) {
                    if (link.contains("webex")) {
                        saveData(name, link, meet, day, strMonth2, year, hour, minutes);
                        Intent intent = new Intent(getApplicationContext(), cricketish.co.joinmeeting.ListView.class);
                        intent.putExtra("meet", meet);
                        intent.putExtra("name", name);
                        intent.putExtra("link", link);
                        intent.putExtra("date", day);
                        intent.putExtra("month", strMonth2);
                        intent.putExtra("year", year);
                        intent.putExtra("hour", hour);
                        intent.putExtra("minutes", minutes);
                        Intent intentToPopup = new Intent(getApplicationContext(), cricketish.co.joinmeeting.PopupDialog.class);
                        intentToPopup.putExtra("meet", meet);
                        startActivity(intentToPopup);
                        startActivity(intent);
                        overridePendingTransition(android.R.anim.slide_in_left, android.R.anim.slide_out_right);

                    } else {
                        openDialog();
                    }
                } else {
                    Toast.makeText(MainActivity.this, "Please enter all fields", Toast.LENGTH_SHORT).show();
                }

            }
        });
        btnGMeet.setOnClickListener(new View.OnClickListener() {
            @Override

            public void onClick(View view) {
                meet = "google";
                name = getName();
                link = getLink();
                allDataGiven = false;
                if ((etName.getText() != null && etName.getText().toString().length() > 0) &&
                        (etLink.getText() != null && etLink.getText().toString().length() > 0) &&
                        (btnTime.getText() != null && btnTime.getText().toString().length() > 0)) {
                    allDataGiven = true;
                }
                if (allDataGiven) {
                    if (link.contains("meeting.google")) {
                        saveData(name, link, meet, day, strMonth2, year, hour, minutes);
                        Intent intent = new Intent(getApplicationContext(), cricketish.co.joinmeeting.ListView.class);
                        intent.putExtra("meet", meet);
                        intent.putExtra("name", name);
                        intent.putExtra("link", link);
                        intent.putExtra("date", day);
                        intent.putExtra("month", strMonth2);
                        intent.putExtra("year", year);
                        intent.putExtra("hour", hour);
                        intent.putExtra("minutes", minutes);
                        Intent intentToPopup = new Intent(getApplicationContext(), cricketish.co.joinmeeting.PopupDialog.class);
                        intentToPopup.putExtra("meet", meet);
                        startActivity(intentToPopup);
                        startActivity(intent);
                        overridePendingTransition(android.R.anim.slide_in_left, android.R.anim.slide_out_right);

                    } else {
                        openDialog();
                    }
                } else {
                    Toast.makeText(MainActivity.this, "Please enter all fields", Toast.LENGTH_SHORT).show();
                }

            }
        });
        btnJioMeet.setOnClickListener(new View.OnClickListener() {
            @Override

            public void onClick(View view) {
                meet = "jiomeet";
                name = getName();
                link = getLink();
                allDataGiven = false;
                if ((etName.getText() != null && etName.getText().toString().length() > 0) &&
                        (etLink.getText() != null && etLink.getText().toString().length() > 0) &&
                        (btnTime.getText() != null && btnTime.getText().toString().length() > 0)) {
                    allDataGiven = true;
                }
                if (allDataGiven) {
                    if (link.contains("jio")) {
                        saveData(name, link, meet, day, strMonth2, year, hour, minutes);
                        Intent intent = new Intent(getApplicationContext(), cricketish.co.joinmeeting.ListView.class);
                        intent.putExtra("meet", meet);
                        intent.putExtra("name", name);
                        intent.putExtra("link", link);
                        intent.putExtra("date", day);
                        intent.putExtra("month", strMonth2);
                        intent.putExtra("year", year);
                        intent.putExtra("hour", hour);
                        intent.putExtra("minutes", minutes);
                        Intent intentToPopup = new Intent(getApplicationContext(), cricketish.co.joinmeeting.PopupDialog.class);
                        intentToPopup.putExtra("meet", meet);
                        startActivity(intentToPopup);
                        startActivity(intent);
                        overridePendingTransition(android.R.anim.slide_in_left, android.R.anim.slide_out_right);

                    } else {
                        openDialog();
                    }
                } else {
                    Toast.makeText(MainActivity.this, "Please enter all fields", Toast.LENGTH_SHORT).show();
                }

            }
        });
        btnOther.setOnClickListener(new View.OnClickListener() {
            @Override

            public void onClick(View view) {
                meet = "other";
                name = getName();
                link = getLink();
                allDataGiven = false;
                if ((etName.getText() != null && etName.getText().toString().length() > 0) &&
                        (etLink.getText() != null && etLink.getText().toString().length() > 0) &&
                        (btnTime.getText() != null && btnTime.getText().toString().length() > 0)) {
                    allDataGiven = true;
                }
                if (allDataGiven) {
                    saveData(name, link, meet, day, strMonth2, year, hour, minutes);
                    Intent intent = new Intent(getApplicationContext(), cricketish.co.joinmeeting.ListView.class);
                    intent.putExtra("meet", meet);
                    intent.putExtra("name", name);
                    intent.putExtra("link", link);
                    intent.putExtra("date", day);
                    intent.putExtra("month", strMonth2);
                    intent.putExtra("year", year);
                    intent.putExtra("hour", hour);
                    intent.putExtra("minutes", minutes);
                    Intent intentToPopup = new Intent(getApplicationContext(), cricketish.co.joinmeeting.PopupDialog.class);
                    intentToPopup.putExtra("meet", meet);
                    startActivity(intentToPopup);
                    startActivity(intent);
                    overridePendingTransition(android.R.anim.slide_in_left, android.R.anim.slide_out_right);
                } else {
                    Toast.makeText(MainActivity.this, "Please enter all fields", Toast.LENGTH_SHORT).show();
                }

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
    void saveData(String name, String link, String meet, int day, String strMonth2, int year, int hour, int minutes) {

        try {
            FileOutputStream file = openFileOutput("cricketish.data.txt", MODE_PRIVATE | MODE_APPEND);
            OutputStreamWriter outputFile = new OutputStreamWriter(file);

            outputFile.write(name + "," + link + "," + meet + "," + day + "," + strMonth2 + "," + year + "," + hour + "," + minutes + "\n");
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
        PopupDialog dialog = new PopupDialog();
        dialog.show(getSupportFragmentManager(), "example.dialog");

    }

    //If the user clicks ignore & proceeds to the list
    @Override
    public void onIgnoreClicked() {
        name = getName();
        link = getLink();
        saveData(name, link, meet, day, strMonth2, year, hour, minutes);
        Intent intentTwo = new Intent(getApplicationContext(), cricketish.co.joinmeeting.ListView.class);
        intentTwo.putExtra("meet", meet);
        intentTwo.putExtra("name", name);
        intentTwo.putExtra("link", link);
        intentTwo.putExtra("date", day);
        intentTwo.putExtra("month", strMonth2);
        intentTwo.putExtra("year", year);
        intentTwo.putExtra("hour", hour);
        intentTwo.putExtra("minutes", minutes);
        startActivity(intentTwo);
    }


    public String getAmORpm(String amOrpm) {
        amOrpm = timeOfDay;
        return amOrpm;

    }

}