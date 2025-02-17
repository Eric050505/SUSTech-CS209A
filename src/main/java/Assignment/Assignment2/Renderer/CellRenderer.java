package Assignment.Assignment2.Renderer;

import javafx.scene.image.Image;
import javafx.scene.image.ImageView;

public class CellRenderer {
    private static final String EMPTY_IMAGE = "/src/main/resources/Assignment/Assignment2/images/0.png";
    private static final String[] IMAGE_PATH = {
            "/src/main/resources/Assignment/Assignment2/images/1.png",
            "/src/main/resources/Assignment/Assignment2/images/2.png",
            "/src/main/resources/Assignment/Assignment2/images/3.png",
            "/src/main/resources/Assignment/Assignment2/images/4.png",
            "/src/main/resources/Assignment/Assignment2/images/5.png",
            "/src/main/resources/Assignment/Assignment2/images/6.png",
            "/src/main/resources/Assignment/Assignment2/images/7.png",
            "/src/main/resources/Assignment/Assignment2/images/8.png",
            "/src/main/resources/Assignment/Assignment2/images/9.png",
            "/src/main/resources/Assignment/Assignment2/images/10.png",
            "/src/main/resources/Assignment/Assignment2/images/11.png",
            "/src/main/resources/Assignment/Assignment2/images/12.png",
            "/src/main/resources/Assignment/Assignment2/images/13.png",
            "/src/main/resources/Assignment/Assignment2/images/14.png",
            "/src/main/resources/Assignment/Assignment2/images/15.png",
            "/src/main/resources/Assignment/Assignment2/images/16.png",
            "/src/main/resources/Assignment/Assignment2/images/17.png",
            "/src/main/resources/Assignment/Assignment2/images/18.png",
            "/src/main/resources/Assignment/Assignment2/images/19.png",
            "/src/main/resources/Assignment/Assignment2/images/20.png"

    };

    public static ImageView renderCell(int cellValue) {
        if (cellValue == 0) return new ImageView(new Image("file:" + System.getProperty("user.dir") + EMPTY_IMAGE));
        String imagePath;
        imagePath = IMAGE_PATH[cellValue - 1];
        Image image = new Image("file:" + System.getProperty("user.dir") + imagePath);
        ImageView imageView = new ImageView(image);
        imageView.setPreserveRatio(true);

        return imageView;
    }

}
