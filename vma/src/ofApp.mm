#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){	

    ofSetVerticalSync(true);
    ofSetCircleResolution(200);
    ofBackground(24, 24, 24);

    
    int bufferSize = BUFFER_SIZE;
    
    svg.load("trials2.svg");
    
    left.assign(bufferSize, 0.0);
    right.assign(bufferSize, 0.0);
    combine.assign(bufferSize, 0.0);
    
    
    //for some reason on the iphone simulator 256 doesn't work - it comes in as 512!
    //so we do 512 - otherwise we crash
    initialBufferSize = 512;
    sampleRate = 44100;
    drawCounter = 0;
    bufferCounter = 0;
    
    buffer = new float[initialBufferSize];
    memset(buffer, 0, initialBufferSize * sizeof(float));
    
    // 0 output channels,
    // 1 input channels
    // 44100 samples per second
    // 512 samples per buffer
    // 1 buffer
    ofSoundStreamSetup(0, 1, this, sampleRate, initialBufferSize, 1);

    
    centerSVG.set(svg.getWidth()/2,svg.getHeight()/2);
    
    for (unsigned int i = BUFFER_SIZE; i > 0; i--){
        currentLoc[i].x =i*3-centerSVG.x;
        currentLoc[i].y =ofGetHeight()/2-centerSVG.y;
    }
    
    
    ofxAccelerometer.setup();

}

//--------------------------------------------------------------
void ofApp::update(){
    //float accelX, accelY =0.0;
    //float accelX = ofxAccelerometer.getForce().x;
    //float accelY = ofxAccelerometer.getForce().y;
    for (unsigned int i = BUFFER_SIZE; i > 0; i--){
        float speed = 0.1; //the smaller, the faster (if using division)
        currentLoc[i].x-=(currentLoc[i].x-cursor.x)/(speed*(i+1));
        currentLoc[i].y-=(currentLoc[i].y-cursor.y)/(speed*(i+i));

        //currentLoc[i].x+=accelX;
        //currentLoc[i].y-=accelY;

    }
}

//--------------------------------------------------------------
void ofApp::draw(){
	
    ofNoFill();
    
    // draw combines channel:
    ofPushStyle();
    
    ofSetColor(245, 58, 135);
    ofSetLineWidth(3);
    
    ofBeginShape();
    for (unsigned int i = BUFFER_SIZE; i > 0; i--){
        //ofVertex(i*2, 100 -combine[i]*180.0f);
        ofPushMatrix();
        ofTranslate(currentLoc[i]-centerSVG);
        //scaling the SVG to sound volume, multiplied by a multiplier
        float multiplier = 5;
        ofScale(1+combine[i]*multiplier,1+combine[i]*multiplier,1);
        svg.draw();
        ofPopMatrix();
    }
    ofEndShape(false);
    ofPopStyle();
    
    
}

//--------------------------------------------------------------

void ofApp::audioIn(float * input, int bufferSize, int nChannels){
    if(initialBufferSize < bufferSize){
        ofLog(OF_LOG_ERROR, "your buffer size was set to %i - but the stream needs a buffer size of %i", initialBufferSize, bufferSize);
    }
    
    int minBufferSize = MIN(initialBufferSize, bufferSize);
    for(int i=0; i<minBufferSize; i++) {
        combine[i] = input[i];
    }
    bufferCounter++;
}
    
    //lets go through each sample and calculate the root mean square which is a rough way to calculate volume
//    for (int i = 0; i < bufferSize; i++){
//        left[i]     = input[i*2]*0.5;
//        right[i]    = input[i*2+1]*0.5;
//        combine[i]  = left[i] + right[i];
//    }


//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){

    cursor.set(touch);

}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}
