package abheri.co.alert;

import androidx.appcompat.app.AppCompatActivity;

import android.app.PendingIntent;
import android.appwidget.AppWidgetManager;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RemoteViews;

public class AssistanceWidgetConfig extends AppCompatActivity {

    public static final String SHARED_PREFS = "prefs";
    public static final String KEY_BUTTON_TEXT = "keyButtonText";
    private int appWidgetId = AppWidgetManager.INVALID_APPWIDGET_ID;

    EditText etName, etNumber;
    Button btnConfirm;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_assistance_widget_config);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_assistance_widget_config);
        Intent configIntent = getIntent();
        Bundle extras = configIntent.getExtras();
        if (extras != null) {
            appWidgetId = extras.getInt(AppWidgetManager.EXTRA_APPWIDGET_ID,
                    AppWidgetManager.INVALID_APPWIDGET_ID);
        }
        Intent resultValue = new Intent();
        resultValue.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId);
        setResult(RESULT_CANCELED, resultValue);
        if (appWidgetId == AppWidgetManager.INVALID_APPWIDGET_ID) {
            finish();
        }
        etName = findViewById(R.id.etName);
        etNumber = findViewById(R.id.etNumber);
    }

    public void confirmConfiguration(View v) {
        AppWidgetManager appWidgetManager = AppWidgetManager.getInstance(this);
        Intent intent = new Intent(this, MainActivity.class);
        PendingIntent pendingIntent = PendingIntent.getActivity(this, 0, intent, 0);
        String buttonText = etName.getText().toString();
        RemoteViews views = new RemoteViews(this.getPackageName(), R.layout.widget);
        views.setOnClickPendingIntent(R.id.button, pendingIntent);
        views.setCharSequence(R.id.button, "setText", buttonText);
        appWidgetManager.updateAppWidget(appWidgetId, views);
        SharedPreferences prefs = getSharedPreferences(SHARED_PREFS, MODE_PRIVATE);
        SharedPreferences.Editor editor = prefs.edit();
        editor.putString(KEY_BUTTON_TEXT + appWidgetId, buttonText);
        editor.apply();
        Intent resultValue = new Intent();
        resultValue.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId);
        setResult(RESULT_OK, resultValue);
        finish();
    }
}
