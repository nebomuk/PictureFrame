package de.vitecvisual.java;
 
public class MyJavaClass
{
    // this method will be called from C/C++
    public static int fibonacci(int n)
    {
        if (n < 2)
            return n;
        return fibonacci(n-1) + fibonacci(n-2);
    }
}