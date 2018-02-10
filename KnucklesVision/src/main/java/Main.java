import java.util.ArrayList;

import edu.wpi.first.wpilibj.networktables.*;
import edu.wpi.first.wpilibj.tables.*;
import edu.wpi.cscore.*;
import org.opencv.core.Mat;
import org.opencv.imgproc.Imgproc;
import org.opencv.core.Core;
import org.opencv.core.Mat;
import org.opencv.core.MatOfPoint;
import org.opencv.core.MatOfPoint2f;
import org.opencv.core.Point;
import org.opencv.core.Rect;
import org.opencv.core.Scalar;
import org.opencv.core.Size;

public class Main {
  public static void main(String[] args) {
    // Loads our OpenCV library. This MUST be included
    System.loadLibrary("opencv_java310");

    // Connect NetworkTables, and get access to the publishing table
    NetworkTable.setClientMode();
    // Set your team number here
    NetworkTable.setTeam(670);

    NetworkTable.initialize();
    
    NetworkTable vision_table = NetworkTable.get("vision");

    // This is the network port you want to stream the raw received image to
    // By rules, this has to be between 1180 and 1190, so 1185 is a good choice
    int streamPort = 1185;

    // This stores our reference to our mjpeg server for streaming the input image
    MjpegServer inputStream = new MjpegServer("MJPEG Server", streamPort);

    Scalar lowerHSV = new Scalar(110,101,30)
    Scalar upperHSV = new Scalar(180,255,255)
    // Selecting a Camera
    // Uncomment one of the 2 following camera options
    // The top one receives a stream from another device, and performs operations based on that
    // On windows, this one must be used since USB is not supported
    // The bottom one opens a USB camera, and performs operations on that, along with streaming
    // the input image so other devices can see it.

    // HTTP Camera
    /*
    // This is our camera name from the robot. this can be set in your robot code with the following command
    // CameraServer.getInstance().startAutomaticCapture("YourCameraNameHere");
    // "USB Camera 0" is the default if no string is specified
    String cameraName = "USB Camera 0";
    HttpCamera camera = setHttpCamera(cameraName, inputStream);
    // It is possible for the camera to be null. If it is, that means no camera could
    // be found using NetworkTables to connect to. Create an HttpCamera by giving a specified stream
    // Note if this happens, no restream will be created
    if (camera == null) {
      camera = new HttpCamera("CoprocessorCamera", "YourURLHere");
      inputStream.setSource(camera);
    }
    */
    
      

    /***********************************************/

    // USB Camera
    
    // This gets the image from a USB camera 
    // Usually this will be on device 0, but there are other overloads
    // that can be used
    UsbCamera camera = setUsbCamera(0, inputStream);
    // Set the resolution for our camera, since this is over USB
    camera.setResolution(640,480);

    // This creates a CvSink for us to use. This grabs images from our selected camera, 
    // and will allow us to use those images in opencv
    CvSink imageSink = new CvSink("CV Image Grabber");
    imageSink.setSource(camera);

    // This creates a CvSource to use. This will take in a Mat image that has had OpenCV operations
    // operations 
    CvSource imageSource = new CvSource("CV Image Source", VideoMode.PixelFormat.kMJPEG, 640, 480, 30);
    MjpegServer cvStream = new MjpegServer("CV Image Stream", 1186);
    cvStream.setSource(imageSource);

    // All Mats and Lists should be stored outside the loop to avoid allocations
    // as they are expensive to create
    Mat inputImage = new Mat();
    Mat outputImage = new Mat();
    
    double width = 0;
    double height = 0;
    double angle = 0;
    Rect bounding = new Rect(0,0,0,0);
    
    //Send data in while loop to network tables
    new Thread("Send data") 
	{
	      public void run()
	      {
	    	  String data = "";
	    	  while(true)
				{
	    		  vision_table.putNumber("width", width);
	    		  vision_table.putNumber("height", height);
	    		  vision_table.putNumber("angle", angle);
				}
	      }
	}.start();
    
    // Infinitely process image
    while (true) {
      // Grab a frame. If it has a frame time of 0, there was an error.
      // Just skip and continue
      long frameTime = imageSink.grabFrame(inputImage);
      if (frameTime == 0) continue;

      // Below is where you would do your OpenCV operations on the provided image
      // The sample below just changes color source to HSV

      /*Begin image processing-------------------------------*/
      bounding = getPowerCube(inputImage, lowerHSV, upperHSV);
      width = bounding.width;
      height = bounding.height;
      angle = getAngle(bounding);
      outputImage = drawRectangle(inputImage, bounding);
      /*End image processing---------------------------------*/
      
      imageSource.putFrame(outputImage);
    }
  }

  private static HttpCamera setHttpCamera(String cameraName, MjpegServer server) {
    // Start by grabbing the camera from NetworkTables
    NetworkTable publishingTable = NetworkTable.getTable("CameraPublisher");
    // Wait for robot to connect. Allow this to be attempted indefinitely
    while (true) {
      try {
        if (publishingTable.getSubTables().size() > 0) {
          break;
        }
        Thread.sleep(500);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }


    HttpCamera camera = null;
    if (!publishingTable.containsSubTable(cameraName)) {
      return null;
    }
    ITable cameraTable = publishingTable.getSubTable(cameraName);
    String[] urls = cameraTable.getStringArray("streams", null);
    if (urls == null) {
      return null;
    }
    ArrayList<String> fixedUrls = new ArrayList<String>();
    for (String url : urls) {
      if (url.startsWith("mjpg")) {
        fixedUrls.add(url.split(":", 2)[1]);
      }
    }
    camera = new HttpCamera("CoprocessorCamera", fixedUrls.toArray(new String[0]));
    server.setSource(camera);
    return camera;
  }

  private static UsbCamera setUsbCamera(int cameraId, MjpegServer server) {
    // This gets the image from a USB camera 
    // Usually this will be on device 0, but there are other overloads
    // that can be used
    UsbCamera camera = new UsbCamera("CoprocessorCamera", cameraId);
    server.setSource(camera);
    return camera;
  }
  
  /**
   * Vision stuff
   */
  
  public static double getAngle(Rect r) {
		//Camera is 1280x720, view angle is 61 degrees horizontal
		//1280/61 = 0.04765625
		double degreesPerPixel = 0.04765625; //Should be a final field (Degrees per pixel for the camera, see above)
		double targetPointX = 640; //Should be a final field (The midpoint x value of the camera, see above)
		double rads;
		double rectMidpointX = r.x+(r.width/2);

		rads = degreesPerPixel * (targetPointX - rectMidpointX);
		return rads;
	}
  
	public static Mat drawRectangle(Mat frame, Rect boundingBox) {
		if(!boundingBox.equals(new Rect(0,0,0,0)) && boundingBox != null)
			Imgproc.rectangle(frame, new Point(boundingBox.x, boundingBox.y), new Point(boundingBox.x+boundingBox.width, boundingBox.y+boundingBox.height), new Scalar(255, 0, 0));
		return frame;
	}

	public static Rect getPowerCube(Mat matrix, Scalar lowerHSV, Scalar upperHSV)
	{
		Mat input = matrix.clone(), mHier = new Mat();
		Imgproc.cvtColor(input, input, Imgproc.COLOR_BGR2HSV);
		Imgproc.GaussianBlur(input, input, new Size(5, 5) ,5 ,5);
		//Detect up-->down, to find color of Scale
		ArrayList<Rect> boxes = new ArrayList<Rect>();

		Core.inRange(input, lowerHSV, upperHSV, input);
		List<MatOfPoint> contours = new ArrayList<MatOfPoint>();
		Imgproc.findContours(input, contours, mHier, Imgproc.RETR_LIST,Imgproc.CHAIN_APPROX_SIMPLE);
		MatOfPoint2f approxCurve = new MatOfPoint2f();
		Rect box = new Rect(0,0,0,0);
		MatOfPoint p = null;
		for (int i = 0; i < contours.size(); i++)
		{
			MatOfPoint2f contour2f = new
					MatOfPoint2f(contours.get(i).toArray());
			double approxDistance = Imgproc.arcLength(contour2f, true)*0.02;
			Imgproc.approxPolyDP(contour2f, approxCurve, approxDistance, true);
			MatOfPoint points = new MatOfPoint( approxCurve.toArray() );
			Rect r = Imgproc.boundingRect(points);			
			if(r.area()>=box.area())
			{
				box = r;
				p = points;
			}
		}
		return box;
	}
}