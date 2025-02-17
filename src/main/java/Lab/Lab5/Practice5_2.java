package Lab.Lab5;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

public class Practice5_2 {

    public static void main(String[] args) {
        if (args.length != 3)
            System.out.println("Error");

        String fileName = args[2];
        File file = new File(fileName);

        try {
            String fileType = getType(file);
            if (fileType != null) {
                System.out.println("Filename: " + fileName);
                System.out.println("File Header(Hex): " + getFileHeader(file));
                System.out.println("File Type: " + fileType);
            } else
                System.out.println("Error");
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

    private static String getType(File file) throws IOException {
        byte[] header = new byte[4];
        FileInputStream fis = new FileInputStream(file);
        fis.read(header);
        String hexHeader = bytesToHex(header);

        return switch (hexHeader) {
            case "89504E47" -> "png";
            case "504B0304" -> "zip or jar";
            case "CAFEBABE" -> "class";
            default -> null;
        };
    }

    private static String bytesToHex(byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes)
            sb.append(String.format("%02X", b));

        return sb.toString();
    }

    private static String getFileHeader(File file) throws IOException {
        byte[] header = new byte[4];
        FileInputStream fis = new FileInputStream(file);
        fis.read(header);

        StringBuilder sb = new StringBuilder();
        for (byte b : header) {
            sb.append(String.format("%02X", b)).append(", ");
        }
        return sb.substring(0, sb.length() - 2);
    }
}
