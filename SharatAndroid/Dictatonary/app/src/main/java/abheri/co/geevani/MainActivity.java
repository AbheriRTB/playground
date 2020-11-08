package abheri.co.geevani;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;

import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;

import com.google.android.material.bottomnavigation.BottomNavigationView;

import abheri.co.geevani.fragments.AboutFragment;
import abheri.co.geevani.fragments.DictionaryFragment;
import abheri.co.geevani.fragments.SubashitaFragment;
import abheri.co.geevani.fragments.TopicsFragment;

public class MainActivity extends AppCompatActivity {

    BottomNavigationView navigationMenu;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        navigationMenu = findViewById(R.id.bottomNav);

        if (savedInstanceState == null) {
            getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container,
                    new SubashitaFragment()).commit();
        }

        navigationMenu.setOnNavigationItemSelectedListener(new BottomNavigationView.OnNavigationItemSelectedListener() {
            @Override
            public boolean onNavigationItemSelected(@NonNull MenuItem item) {
                Fragment selectedFragment = null;
                switch (item.getItemId()) {
                    case R.id.subashita:
                        selectedFragment = new SubashitaFragment();
                        break;
                    case R.id.topics:
                        selectedFragment = new TopicsFragment();
                        break;
                    case R.id.dictionary:
                        selectedFragment = new DictionaryFragment();
                        break;
                    case R.id.about:
                        selectedFragment = new AboutFragment();
                        break;
                }
                getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container,
                        selectedFragment).commit();
                return true;
            }
        });

    }
}