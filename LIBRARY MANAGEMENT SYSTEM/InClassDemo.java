import java.io.File;
import java.util.Scanner;
public class InClassDemo {
    public static void main(String[] args) {
        Scanner x = new Scanner(System.in);
        String pathname;
        System.out.println("Please enter your pathname: ");
        pathname = x.next();
        try {
            File file = new File(pathname);
            Scanner y = new Scanner(file);

            while (y.hasNextLine())
                System.out.println(y.nextLine());
        }catch (Exception e){
            System.out.println("Invalid file : "+pathname+" could not be found in current directory");
        }
    }
}

