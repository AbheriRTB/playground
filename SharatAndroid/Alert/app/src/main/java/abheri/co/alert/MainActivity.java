package abheri.co.alert;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.widget.CompoundButton;
import android.widget.RadioButton;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    boolean code;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent intent2 = getIntent();
        code = intent2.getBooleanExtra("code", false);
        setContentView(R.layout.activity_main);
        Intent intent = new Intent(Intent.ACTION_CALL);
        String no = "9845544209", tel = "tel:" + no;
        intent.setData(Uri.parse(tel));
        startActivity(intent);
    }

    @Override
    protected void onRestart() {
        super.onRestart();
            finish();
            System.exit(0);
    }
}