package abheri.co.protracklite.utils;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.google.android.material.dialog.MaterialAlertDialogBuilder;

import java.util.ArrayList;
import java.util.List;

import abheri.co.protracklite.R;


public class SubjectAdaptor extends RecyclerView.Adapter<SubjectAdaptor.ViewHolder> {

    private List<Subject> subjects;
    MaterialAlertDialogBuilder dialogBuilder;
    Drawable backgroundDialog;
    LayoutInflater inflater;
    Context thisContext;
    RecyclerView recyclerView;


    public SubjectAdaptor(Context context, List<Subject> list, Drawable backgroundForDialog, LayoutInflater inflaterForDialog,
                          RecyclerView recyclerViewForDialog) {
        subjects = list;
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
                            .setItems(getTopicTitles(subjects.get(i)), null)
                            .setPositiveButton("Ok", null)
                            .setBackground(backgroundDialog)
                            .show();
                }
            });

        }
    }

    @NonNull
    @Override
    public SubjectAdaptor.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {

        View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.listview, parent, false);
        return new ViewHolder(v);
    }

    @Override
    public void onBindViewHolder(@NonNull SubjectAdaptor.ViewHolder holder, int i) {
        holder.itemView.setTag(subjects.get(i));
        holder.tvTitle.setText(subjects.get(i).getName());
    }

    @Override
    public int getItemCount() {
        return subjects.size();
    }

    private CharSequence[] getTopicTitles(Subject subject) {
        ArrayList<String> csl = new ArrayList<String>();
        List<Topic> lt = subject.getTopics();
        for (int i = 0; i < lt.size(); ++i ){
            csl.add(lt.get(i).getName());   
        }
        return(CharSequence[]) csl.toArray();
    }
}