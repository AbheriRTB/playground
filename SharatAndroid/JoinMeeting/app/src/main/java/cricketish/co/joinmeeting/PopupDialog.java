package cricketish.co.joinmeeting;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatDialogFragment;

public class PopupDialog extends AppCompatDialogFragment {

    private PopupListner listner;
    MainActivity dialog;


    //  Popup dialog
    @NonNull
    @Override
    public Dialog onCreateDialog(@Nullable Bundle savedInstanceState) {
        dialog = new MainActivity();
        AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
        builder.setTitle("Warning!")
                .setMessage("This is not a valid app link, check the link again \n" +
                        "If you you want to continue, press ignore!")
                .setNegativeButton("cancel", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {

                    }
                })
                .setPositiveButton("ignore", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        listner.onIgnoreClicked();
                    }
                });
        return builder.create();

    }


    //  If ignore clicked (Continues on the context)
    public interface PopupListner {
        void onIgnoreClicked();
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
