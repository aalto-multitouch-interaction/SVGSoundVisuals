#pragma once

#include "ofxiOS.h"
#include "ofxSvg.h"

#define BUFFER_SIZE 256


class ofApp : public ofxiOSApp {
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);

    void audioIn(float * input, int bufferSize, int nChannels);
    
    int    initialBufferSize;
    int    sampleRate;
    int    drawCounter;
    int bufferCounter;
    float * buffer;
    
    vector <float> left;
    vector <float> right;
    vector <float> combine;
    
    ofSoundStream soundStream;
    
    ofxSVG svg;
    ofPoint currentLoc[BUFFER_SIZE], cursor, centerSVG;
};


