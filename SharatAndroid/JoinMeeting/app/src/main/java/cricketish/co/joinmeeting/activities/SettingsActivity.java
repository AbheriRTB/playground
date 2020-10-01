package cricketish.co.joinmeeting.activities;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.CompoundButton;
import android.widget.Switch;

import cricketish.co.joinmeeting.R;

public class SettingsActivity extends AppCompatActivity {

    Switch switchNotify;
    Button btnApply;
    boolean notify;
    public static final String SWITCH1 = "switch1";
    public static final String SHARED_PREFS = "sharedPrefs";
    boolean switchOnOff;


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {

        getMenuInflater().inflate(R.menu.settings, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {

        switch (item.getItemId()) {
            case R.id.btnHome:
                Intent intent = new Intent(getApplicationContext(), ListViewActivity.class);
                startActivity(intent);
                break;

        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_settings);
        final Intent toListIntent = new Intent(SettingsActivity.this, ListViewActivity.class);

        switchNotify = findViewById(R.id.swichNotify);
        btnApply = findViewById(R.id.btnApply);
        switchNotify.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
                if (b) {
                    notify = true;
                } else {
                    notify = false;
                }
            }
        });
        btnApply.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                saveAndLoadData();
                startActivity(toListIntent);
                switchNotify.setChecked(switchOnOff);

            }
        });

    }

    private void saveAndLoadData() {
        final Intent settingsIntent = new Intent(SettingsActivity.this, ListViewActivity.class);
        SharedPreferences sharedPreferences = getSharedPreferences(SHARED_PREFS, MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putBoolean(SWITCH1, switchNotify.isChecked());
        editor.apply();
        settingsIntent.putExtra("notify", notify);

        SharedPreferences sharedPreferences2 = getSharedPreferences(SHARED_PREFS, MODE_PRIVATE);
        switchOnOff = sharedPreferences2.getBoolean(SWITCH1, false);

    }
}