package cricketish.co.joinmeeting;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatDialogFragment;

public class PopupDialog_Delete extends AppCompatDialogFragment {

    private PopupListner listner;
    ListView dialog;


    //  Popup dialog
    @NonNull
    @Override
    public Dialog onCreateDialog(@Nullable Bundle savedInstanceState) {
        dialog = new ListView();
        AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
        builder.setTitle("Confirmation")
                .setMessage("Do you want to really delete this link?")
                .setNegativeButton("cancel", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {

                    }
                })
                .setPositiveButton("Yes", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        listner.onYesClicked();
                    }
                });
        return builder.create();

    }


    //  If ignore clicked (Continues on the context)
    public interface PopupListner {
        void onYesClicked();
    }


    //  Attaches the popup to the context
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
