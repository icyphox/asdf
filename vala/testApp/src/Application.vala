public class MyApp : Gtk.Application {

    public MyApp () {
        Object (
            application_id: "com.github.yourusername.yourrepositoryname",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
		var grid = new Gtk.Grid ();
		grid.orientation = Gtk.Orientation.VERTICAL;
		grid.row_spacing = 6;

		var button = new Gtk.Button.with_label ("Click me!");
		var label  = new Gtk.Label (null);

		grid.add (button);
		grid.add (label);

        var main_window = new Gtk.ApplicationWindow (this);
        main_window.default_height = 300;
        main_window.default_width = 300;
        main_window.title = "Hello World";
		main_window.add (grid);
        main_window.show_all ();

		button.clicked.connect (() => {
			label.label = "Hello World!";
			button.sensitive = false;
		});
    }

    public static int main (string[] args) {
        var app = new MyApp ();
        return app.run (args);
    }
}


