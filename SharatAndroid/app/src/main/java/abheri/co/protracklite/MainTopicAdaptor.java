package abheri.co.protracklite;

import android.content.Context;
import android.content.DialogInterface;
import android.graphics.drawable.Drawable;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.google.android.material.dialog.MaterialAlertDialogBuilder;

import java.util.ArrayList;


public class MainTopicAdaptor extends RecyclerView.Adapter<MainTopicAdaptor.ViewHolder> {

    private ArrayList<Topic> topic;
    MaterialAlertDialogBuilder dialogBuilder;
    Drawable backgroundDialog;
    LayoutInflater inflater;
    Context thisContext;
    RecyclerView recyclerView;


    public MainTopicAdaptor(Context context, ArrayList<Topic> list, Drawable backgroundForDialog, LayoutInflater inflaterForDialog,
                            RecyclerView recyclerViewForDialog) {
        topic = list;
        dialogBuilder = new MaterialAlertDialogBuilder(context);
        backgroundDialog = backgroundForDialog;
        inflater = inflaterForDialog;
        thisContext = context;
        recyclerView = recyclerViewForDialog;

    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        TextView tvTitle;

        public ViewHolder(@NonNull View itemView) {
            super(itemView);

            tvTitle = itemView.findViewById(R.id.tvTitle);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {

                    final int i = recyclerView.getChildLayoutPosition(v);
                    dialogBuilder.setTitle("Portions")
                            // TODO: Remove the comment after finishing addPage
                            /*.setMultiChoiceItems(chapters, bool, new DialogInterface.OnMultiChoiceClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which, boolean isChecked) {

                        }
                    })*/
                            .setItems(topic.get(i).getPortions(), null)
                            .setPositiveButton("Ok", null)
                            .setBackground(backgroundDialog)
                            .show();
                }
            });

        }
    }

    @NonNull
    @Override
    public MainTopicAdaptor.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {

        View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.listview, parent, false);
        return new ViewHolder(v);
    }

    @Override
    public void onBindViewHolder(@NonNull MainTopicAdaptor.ViewHolder holder, int i) {
        holder.itemView.setTag(topic.get(i));
        holder.tvTitle.setText(topic.get(i).getTitle());
    }

    @Override
    public int getItemCount() {
        return topic.size();
    }
}
