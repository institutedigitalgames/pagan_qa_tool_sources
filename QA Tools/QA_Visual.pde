float green;
import com.hamoid.*;  //import library
VideoExport videoExport;  //declare
Table table;

void setup (){
//videoExport.forgetFfmpegPath();
size(1280,720);
background(20,150,12);
videoExport = new VideoExport(this, "green_video.mp4");  //define
videoExport.setFrameRate(60);
videoExport.startMovie();  //intialize 

table = new Table();

table.addColumn("Value");
table.addColumn("Frame");
table.addColumn("Seconds");

}


void draw(){
  //200 frames
  if(frameCount < 200){
  green += 0.5;
  }
  // wait 3 seconds 
  //510 frames
  if(frameCount>290 && frameCount<700){
   green -= 0.5;
  }
  //wait 5 seconds
  //240 frames
  if(frameCount>900 && frameCount<1140){
    green += 0.5;
  }
  //wait 3 seconds
  //280 frames
  if(frameCount>1320 && frameCount<1500){
   green -= 0.5;
  }
  //wait 1 second
  //100 frames
  if(frameCount>1660 && frameCount<1760){
   green -= 0.5;
  }
  //wait 3 second
  //360 frames
  if(frameCount>1940 && frameCount<2300){
   green += 0.5;
  }
  //wait 2 seconds
  //100 frames
  if(frameCount>2420 && frameCount<2520){
   green += 0.5;
  }
  // wait 5 seconds
  //180 frames
  if(frameCount>2820 && frameCount<3000){
   green -= 0.5;
  }
  // wait 2 seconds 
  // 240 frames
  if(frameCount>3120 && frameCount<3360){
   green -= 0.5;
  }
  // wait 4 seconds
  if(frameCount > 3600){
  saveTable(table, "data/new.csv");
  videoExport.endMovie(); 
  exit(); 
  }
  background(20,150+green,12);
  println(150+green, frameCount, frameCount/60);
  TableRow newRow = table.addRow();
  newRow.setFloat("Value", 150+green);
  newRow.setInt("Frame", frameCount);
  newRow.setInt("Seconds", int(frameCount/60));
  videoExport.saveFrame();
}
