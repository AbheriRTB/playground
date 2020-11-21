package cricketish.co.sqlite;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import java.sql.SQLException;

public class MainActivity extends AppCompatActivity {

    EditText etName, etEmail, etCell;
    Button btnSave, btnSee, btnEdit, btnDelete;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        etName = findViewById(R.id.etName);
        etEmail = findViewById(R.id.etMail);
        etCell = findViewById(R.id.etCell);
        btnSave = findViewById(R.id.btnSave);
        btnSee = findViewById(R.id.btnSee);
        btnEdit = findViewById(R.id.btnEdit);
        btnDelete = findViewById(R.id.btnDelete);


        btnSave.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String name = etName.getText().toString().trim();
                String cell = etCell.getText().toString().trim();

                ContactsDB db = new ContactsDB(MainActivity.this);
                db.open();
                db.createEntry(name,cell);
                db.close();
                Toast.makeText(MainActivity.this, "Successfully Saved", Toast.LENGTH_SHORT).show();
                etName.setText("");
                etCell.setText("");
            }
        });


        btnSee.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(MainActivity.this, Data.class);
                startActivity(intent);
            }
        });


        btnEdit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                ContactsDB db = new ContactsDB(MainActivity.this);
                db.open();
                db.updateEntry("","","");
                db.close();
                Toast.makeText(MainActivity.this, "Successfully Saved", Toast.LENGTH_SHORT).show();
                //etName.setText("");
                //etCell.setText("");

            }
        });


        btnDelete.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                ContactsDB db = new ContactsDB(MainActivity.this);
                db.open();
                db.deleteEntry("1");
                db.close();
                Toast.makeText(MainActivity.this, "Successfully Deleted", Toast.LENGTH_SHORT).show();
            }
        });


    }
}