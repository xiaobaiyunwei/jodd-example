package test;

import java.math.BigInteger;

public class DiguiTest {
    public static void main(String[] args) {

//    	System.out.println(123%10);  
//    	System.out.println(123/10);  
//    	System.out.println(fun(1234));  //倒序输出一串数字；
//		1-10=3628800，11-20=7374868300800，21-30=2289574359072000,
//    	31-40=95355706244198400,41-50=1528317763955136000
//		51-60=273589847231500800，61-70=1439561377475020800，71-80=5974790569203456000
//		81-90=20759078324729606400	91-100=62815650955529472000
    	//共24个0；
    	//System.out.println(Mutil(1,100));  //倒序输出一串数字；
    	//2的16次方：65536	

    	long a=1024;
    	long b=1024;
    	long c=1024;
    	System.out.println(a*b*c*2);
    	System.out.println(65536*1024*16);
    	//16+10+4
    }  
    public static BigInteger Mutil(int start,int end){
    	BigInteger result = new BigInteger(String.valueOf(1));
		for(int i=start;i<=end;i++){
			result=result.multiply(new BigInteger(String.valueOf(i)));
			System.out.println("result==="+i+":"+result);
		}
		return result;   
    }  
    
    public static String fun(int num){  
        if(num>=10){  
            return (num%10)+fun(num/10);  
            //3+2+
        }else{  
//            return String.valueOf(num);  
        	return Integer.toString(num);
        }  
    }  
	
      
}
