package cricketish.co.sqlite;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.TextView;

public class Data extends AppCompatActivity {


    TextView tvData;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_data);
        tvData = findViewById(R.id.tvData);

        ContactsDB db = new ContactsDB(Data.this);
        db.open();
        tvData.setText(db.getData());
        db.close();
    }
}