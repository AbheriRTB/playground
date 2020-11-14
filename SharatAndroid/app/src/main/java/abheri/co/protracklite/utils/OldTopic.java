package abheri.co.protracklite.utils;

public class OldTopic {
    private String Title;
    private CharSequence[] Portions;

    public OldTopic(String title, CharSequence[] portions) {
        Title = title;
        Portions = portions;
    }

    public CharSequence[] getPortions() {
        return Portions;
    }

    public void setPortions(CharSequence[] portions) {
        Portions = portions;
    }

    public String getTitle() {
        return Title;
    }

    public void setTitle(String title) {
        Title = title;
    }
}
