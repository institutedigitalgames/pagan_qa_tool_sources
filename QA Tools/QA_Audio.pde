/**
  * This sketch demonstrates how to create synthesized sound with Minim 
  * using an AudioOutput and an Oscil. An Oscil is a UGen object, 
  * one of many different types included with Minim. By using 
  * the numbers 1 thru 5, you can change the waveform being used
  * by the Oscil to make sound. These basic waveforms are the 
  * basis of much audio synthesis. 
  * 
  * For many more examples of UGens included with Minim, 
  * have a look in the Synthesis folder of the Minim examples.
  * <p>
  * For more information about Minim and additional features, 
  * visit http://code.compartmental.net/minim/
  */

import ddf.minim.*;
import ddf.minim.ugens.*;

Minim       minim;
AudioOutput out;
Oscil       wave;
AudioRecorder recorder;

Table table;
float freq = 225;
int frame = 0;

void setup()
{
  size(512, 200, P3D);
  
  minim = new Minim(this);
  
  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();
  
    // create a recorder that will record from the output to the filename specified
  // the file will be located in the sketch's root folder.
  recorder = minim.createRecorder(out, "myrecording.wav");
  
  // create a sine wave Oscil, set to 440 Hz, at 0.5 amplitude
  wave = new Oscil( 440, 0.5f, Waves.TRIANGLE );
  // patch the Oscil to the output
  wave.patch( out );
  
  table = new Table();

  table.addColumn("Value");
  table.addColumn("Frame");
  table.addColumn("Seconds");
  
}

void draw()
{
  background(0);
  stroke(255);
  strokeWeight(1);
  
  // draw the waveform of the output
  //println(out.bufferSize());
  for(int i = 0; i < out.bufferSize() - 1; i++)
  {
    line( i, 50  - out.left.get(i)*50,  i+1, 50  - out.left.get(i+1)*50 );
    line( i, 150 - out.right.get(i)*50, i+1, 150 - out.right.get(i+1)*50 );
  }

  // draw the waveform we are using in the oscillator
  stroke( 128, 0, 0 );
  strokeWeight(4);
  for( int i = 0; i < width-1; ++i )
  {
    point( i, height/2 - (height*0.49) * wave.getWaveform().value( (float)i / width ) );
  }
  
  
  if ( recorder.isRecording() )
  {
    text("Currently recording...", 5, 15);
    frame+=1;
    TableRow newRow = table.addRow();
    newRow.setFloat("Value", freq);
    newRow.setInt("Frame", frame);
    newRow.setInt("Seconds", int(frame/60));
  }
  else
  {
    text("Not recording.", 5, 15);
  }
  
  println(frame,frameCount,freq);
  
  if(frameCount>100 && frameCount<350){
   freq -= 0.7;
  }
  
  if(frameCount>470 && frameCount<670){
    freq += 0.7;
  }
  
  if(frameCount>800 && frameCount<1000){
    freq += 0.7;
  }
  
  if(frameCount>1100 && frameCount<1300){
    freq += 0.7;
  }
  
  if(frameCount>1360 && frameCount<1560){
    freq -= 0.5;
  }
  
  if(frameCount>1600 && frameCount<1800){
    freq -= 0.5;
  }
  
  
  
  wave.setFrequency( freq );
}


//void mouseMoved()
//{
//  // usually when setting the amplitude and frequency of an Oscil
//  // you will want to patch something to the amplitude and frequency inputs
//  // but this is a quick and easy way to turn the screen into
//  // an x-y control for them.
  
//  float amp = map( mouseY, 0, height, 1, 0 );
//  wave.setAmplitude( amp );
  
//  freq = map( mouseX, 0, width, 100, 450 );
//  wave.setFrequency( freq );
//}

void keyPressed()
{ 
  switch( key )
  {
    case '1': 
      wave.setWaveform( Waves.SINE );
      break;
     
    case '2':
      wave.setWaveform( Waves.TRIANGLE );
      break;
     
    case '3':
      wave.setWaveform( Waves.SAW );
      break;
    
    case '4':
      wave.setWaveform( Waves.SQUARE );
      break;
      
    case '5':
      wave.setWaveform( Waves.QUARTERPULSE );
      break;
     
    default: break; 
  }
}

void keyReleased()
{
  if ( key == 'r' ) 
  {
    // to indicate that you want to start or stop capturing audio data, you must call
    // beginRecord() and endRecord() on the AudioRecorder object. You can start and stop
    // as many times as you like, the audio data will be appended to the end of the buffer 
    // (in the case of buffered recording) or to the end of the file (in the case of streamed recording). 
    if ( recorder.isRecording() ) 
    {
      recorder.endRecord();
    }
    else 
    {
      recorder.beginRecord();
    }
  }
  if ( key == 's' )
  {
    // we've filled the file out buffer, 
    // now write it to the file we specified in createRecorder
    // in the case of buffered recording, if the buffer is large, 
    // this will appear to freeze the sketch for sometime
    // in the case of streamed recording, 
    // it will not freeze as the data is already in the file and all that is being done
    // is closing the file.
    // the method returns the recorded audio as an AudioRecording, 
    // see the example  AudioRecorder >> RecordAndPlayback for more about that
    recorder.save();
    saveTable(table, "data/new.csv");
    println("Done saving.");
    //exit();
  }
}
