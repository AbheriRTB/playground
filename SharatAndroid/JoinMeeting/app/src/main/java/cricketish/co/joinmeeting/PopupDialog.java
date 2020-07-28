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
    String message, meet;
    MainActivity dialog;


    @NonNull
    @Override
    public Dialog onCreateDialog(@Nullable Bundle savedInstanceState) {
        dialog = new MainActivity();
        dialog.setMessage(meet);
        switch (meet) {
            case "zoom":
                message = "This is not a Zoom link, check the link again \n" +
                        "If you you want to continue, press ignore!";
            case "webex":
                message = "This is not a Webex link, check the link again \n" +
                        "If you you want to continue, press ignore!";
            case "google":
                message = "This is not a Google Meet link, check the link again \n" +
                        "If you you want to continue, press ignore!";
            case "jiomeet":
                message = "This is not a Jio Meet link, check the link again \n" +
                        "If you you want to continue, press ignore!";
        }
        AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
        builder.setTitle("Warning!")
                .setMessage(message)
                .setNegativeButton("cancel", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {

                    }
                })
                .setPositiveButton("ignore", new DialogInterface.OnClickListener() {
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
