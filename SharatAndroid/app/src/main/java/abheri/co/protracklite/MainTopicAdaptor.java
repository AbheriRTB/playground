package abheri.co.protracklite;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;

public class MainTopicAdaptor extends RecyclerView.Adapter<MainTopicAdaptor.ViewHolder>{

    private ArrayList<Topic> topic;

    public MainTopicAdaptor(Context context, ArrayList<Topic> list) {
        topic = list;
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        TextView tvTitle;

        public ViewHolder(@NonNull View itemView) {
            super(itemView);

            tvTitle = itemView.findViewById(R.id.tvTitle);

            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {

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
