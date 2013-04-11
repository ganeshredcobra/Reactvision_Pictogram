import TUIO.*;
TuioProcessing tuioClient;
import java.util.Collections;

PImage pic;
float rotation;
float Scale=1;
int id;
float x,xpos,firstx;
float y,ypos,firsty;
int prev_val=0;
PFont f;  

static final Comparator<TuioObject> SENIORITY_ORDER = 
                                        new Comparator<TuioObject>() {
    public int compare(TuioObject e1, TuioObject e2) {
    
        return (e1.getX() < e2.getX() ? -1 :
               (e1.getX() == e2.getX() ? 0 : 1));
    }
};


void setup(){
  f = loadFont( "AgencyFB-Reg-11.vlw" ); 
  tuioClient  = new TuioProcessing(this);
  rotation=0;
  Scale=1;
  x=0;
  y=0;
  size(screen.width, screen.height);
  background(128);
  noStroke();
  smooth();
  pic=loadImage("cat.jpg");
  imageMode(CENTER);
  translate(width/2,height/2);
  image(pic,0,0,width/2,height/2);
}

void draw(){
  background(128);
  translate((width/2)+x,(height/2)+y);
  rotate(radians(rotation));
  scale(Scale);
  image(pic,0,0,width/2,height/2);
  Vector tuioObjectList = tuioClient.getTuioObjects();
  Collections.sort(tuioObjectList,SENIORITY_ORDER);
  
  for (int i=0;i<tuioObjectList.size();i++) {
     TuioObject tobj = (TuioObject)tuioObjectList.elementAt(i);
    // if()
    print(tobj.getSymbolID());
    
    
 /*  if(tobj.getSymbolID() == 5)
     {
        textSize(80);
        fill(400, 0, 400);
        textAlign(CENTER);
        text("C",0,300);

     }
     else if(tobj.getSymbolID() == 0)
     {
        textSize(80);
        fill(400, 0, 400);
        textAlign(LEFT);;
        text("A",25,300);

     }
     else if(tobj.getSymbolID() == 3)
     {
        textSize(80);
        fill(400, 0, 400);
        textAlign(LEFT);
        text("T",75,300);

     }
  }*/
  println("");
}


void addTuioObject(TuioObject tobj) {
 // println("add object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
  id=tobj.getSymbolID();
  firstx=tobj.getX()*width;
  firsty=tobj.getY()*height;
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  //println("remove object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  //println("update object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
          //+" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
          xpos=tobj.getX()*width;
         // ypos=tobj.getY()*height;
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
