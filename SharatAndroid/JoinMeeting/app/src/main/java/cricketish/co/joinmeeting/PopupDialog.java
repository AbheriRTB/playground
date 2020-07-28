package cricketish.co.joinmeeting;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatDialogFragment;

public class PopupDialog extends AppCompatDialogFragment {

    private PopupListner listner;
    String message;

    public void setMessage(String message2) {
        message = message2;
    }

    @NonNull
    @Override
    public Dialog onCreateDialog(@Nullable Bundle savedInstanceState) {
        AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
        builder.setTitle("Mistake?!")
                .setMessage(message)
                .setNegativeButton("cancel", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {

                    }
                })
                .setPositiveButton("yes", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        listner.onYesClicked();
                    }
                });
        return builder.create();

    }

    public interface PopupListner {
        void onYesClicked();
    }

    @Override
    public void onAttach(@NonNull Context context) {
        super.onAttach(context);
        try {
            listner = (PopupListner) getActivity();
        } catch (ClassCastException e) {
            throw new ClassCastException(context.toString() + "must implement PopupListner");
        }
    }

}
