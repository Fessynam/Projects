import java.util.Scanner;
public class Main {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        System.out.print("Enter the mark for Assignment 1: ");
        double assignment1 = input.nextDouble();
        System.out.print("Enter the mark for Assignment 2: ");
        double assignment2 = input.nextDouble();

        double average = (assignment1 + assignment2) / 2;

        if (average >= 50) {
            System.out.print("Student qualified for exams\n ");
            System.out.print("Enter the mark for the Exam: ");
            double exam = input.nextDouble();

            double finalMark = 0.6 * average + 0.4 * exam;

            String grade;
            if (finalMark >= 80&& finalMark<=100) {
                grade = "A";
            } else if (finalMark >= 60 && finalMark<=79) {
                grade = "B";
            } else if (finalMark >= 50 && finalMark<=69) {
                grade = "C";
            } else {
                grade = "Ungraded";
            }

            System.out.println("Final Mark: " + finalMark);
            System.out.println("Grade: " + grade);
        } else {
            System.out.println("Sorry, the student did not qualify to write the exam.");
        }

        input.close();
    }
}