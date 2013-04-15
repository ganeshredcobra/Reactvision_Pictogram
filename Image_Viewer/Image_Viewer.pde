import TUIO.*;
TuioProcessing tuioClient;
import java.util.Collections;
import java.util.Iterator;
import java.util.Map;

import ddf.minim.* ;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioSample awesome;
AudioSample check_answer;

PImage pic;
float rotation;
float Scale=1;
int data_length;
int k=0;
float x,y;
int prev_val=0;
PFont f; 
String[] data_list;
String string_name;
String name;

static final Comparator<TuioObject> SENIORITY_ORDER = 
                                        new Comparator<TuioObject>() {
    public int compare(TuioObject e1, TuioObject e2) {
    
        return (e1.getX() < e2.getX() ? -1 :
               (e1.getX() == e2.getX() ? 0 : 1));
    }
};


void setup(){
  f = loadFont( "font/AgencyFB-Reg-11.vlw" ); 
  tuioClient  = new TuioProcessing(this);
  
 
  File dir = new File("/home/ganesh/Documents/kinect/processing-2.0b3/sketchbook/Image_Viewer/data");
  data_list = dir.list();
  data_length=data_list.length;
  if (data_list == null) {
    println("Folder does not exist or cannot be accessed.");
  } else {
    //println(data_list[0]);
    //println(data_length);
  } 
 
   minim = new Minim(this) ;
   awesome = minim.loadSample("audio/awesome.wav");
   check_answer = minim.loadSample("audio/check_answer.wav");
 
  rotation=0;
  Scale=1;
  x=0;
  y=0;
  size(screen.width, screen.height);
  background(128);
  noStroke();
  smooth();
  imageMode(CENTER);
  translate(width/2,height/2);
/*  pic=loadImage("CAT.jpg");
  imageMode(CENTER);
  translate(width/2,height/2);
  image(pic,0,0,width/2,height/2);*/
}

void draw(){
  //Iterator i = hm.entrySet().iterator();
  HashMap hm = new HashMap();

  
  hm.put("0","C");
  hm.put("2","A");
  hm.put("3","P");
  hm.put("4","R");
  hm.put("5","T");;

 // Iterator j = hm.entrySet().iterator();  
  
  
   showimage();
   
    
  Vector tuioObjectList = tuioClient.getTuioObjects();
  Collections.sort(tuioObjectList,SENIORITY_ORDER);
  String string_name=new String();
  
  for (int i=0;i<tuioObjectList.size();i++) {
     TuioObject tobj = (TuioObject)tuioObjectList.elementAt(i);   
    string_name=string_name.concat((String)hm.get(new Integer(tobj.getSymbolID()).toString()));     
  }
  //println(string_name);
  textSize(80);
  fill(400, 0, 400);
  textAlign(CENTER);
  text(string_name,0,300);
  //println(name);
  if(string_name.length()==name.length())
  {
    if(string_name.equals(name))
    {
      //println("sucess");
      awesome.trigger();
      k=k+1; 
    }
    else
    {
     // check_answer.trigger();
    }
  }

   
}//end of loop


void addTuioObject(TuioObject tobj) {
 // println("add object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
  
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  //println("remove object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  //println("update object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
          //+" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
          
}

// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  //println("add cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
 // println("update cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
  //        +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  //println("remove cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
}

// called after each message bundle
// representing the end of an image frame
void refresh(TuioTime bundleTime) { 
  //redraw();
}

void showimage(){
 
 background(128);
 translate((width/2)+x,(height/2)+y);
 rotate(radians(rotation));
 scale(Scale);
 //println(data_list[k]);
 //for(int j=0;j<data_length;j++){
 pic=loadImage(data_list[k]);
 imageMode(CENTER);
 
 //translate(width/2,height/2);    
 image(pic,0,0,width/2,height/2);
 name=data_list[k].substring(0, data_list[k].length()-4);
 // println(name);
 //println(data_list[j]); 
}

void stop()
{
 // awesome.close();
  minim.stop();

  super.stop();  
}
