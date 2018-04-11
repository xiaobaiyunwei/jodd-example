package jodd.example.action;

import jodd.madvoc.meta.Action;
import jodd.madvoc.meta.In;
import jodd.madvoc.meta.MadvocAction;
import jodd.madvoc.meta.Out;

@MadvocAction("foo/boo")
public class AliasAction {
	  @In
      String name;

      @Out
      String value; 	 	

      @Action
      public String world() {
          System.out.println("AliasAction.world " + name);
          value = "Hello World!";
          return "ok";
      }
      
      @Action("test/world")
      public String china() {
          System.out.println("AliasAction.China " + name);
          value = "Hello World!";
          return "ok";
      }
      
      @Action(extension=Action.NONE,method="Post")
      public String suffix() {
    	  System.out.println("AliasAction.suffix " + name);
    	  value = "Hello World!";
    	  return "ok";
      }

      @Action("/welcome..")    
      public String root() {
    	  System.out.println("welcome to  " + name);
    	  value = "Hello World!";
    	  return "ok";
      }
      
}
