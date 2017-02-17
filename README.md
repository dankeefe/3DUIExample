# MinVR 3DUI Example Application:  PaintBlobs

This example program is meant to illustrate how to create a MinVR program
that includes an interesting 3D user interface.  Here, the user interface
assumes that each hand holds a 6 DOF tracker with one button on it.  A
3D cursor follows each hand -- the right hand cursor is a paintbrush, and
the left hand is a cube.  When the right hand button is pressed and held
then the brush begins to paint a trail of multi-colored spherical "3D paint
blobs".  When the left hand button is pressed and held, this "grabs onto"
the entire 3D painting so that the user can then translate and rotate
the scene.  The interface is a super-simplified version of the CavePainting
tool (Keefe et al., 2001) and recently seen in TiltBrush and similar tools.

Desktop Controls:

SPACE -- paint
G     -- grab
MOUSE -- move the trackers
R     -- rotate the trackers
1     -- toggle tracker 1 (paintbrush) on/off
2     -- toggle tracker 2 (left hand) on/off


## Getting Started

### Install MinVR Dependency

#### Download MinVR Repository

  ```
  git clone http://github.com/MinVR/MinVR
  git checkout beta
  ```
  
#### Build and Install MinVR

* Linux and Mac (command line)

  ```
  cd MinVR
  mkdir build
  cd build
  cmake ..
  make
  make install
  cd ../..
  ```

* Mac (Xcode)

  ```
  mkdir build
  cd build
  cmake .. -G Xcode
  # Open project in Xcode - build and install
  cd ../..
  ```
    
* Windows (Visual Studio)

  ```
  mkdir build
  cd build
  cmake .. -G "Visual Studio 12 Win64"
  # Open project in Visual Studio - build and install
  cd ../..
  ```

### Build Application

#### Download Application

  ```
  git clone http://github.com/MinVR/MinVRStandAloneApp
  cd MinVRStandAloneApp

  ```

#### Build Application

* Linux and Mac (command line)

  ```
  make
  ```

* Mac (Xcode)

  ```
  mkdir build
  cd build
  cmake .. -G Xcode
  # Open project in Xcode - build
  cd ../..
  ```
    
* Windows (Visual Studio)

  ```
  mkdir build
  cd build
  cmake .. -G "Visual Studio 12 Win64"
  # Open project in Visual Studio - build
  cd ../..
  ```

#### Run Application

  ```
  ./build/bin/3DUIExample desktop.xml
  ```

