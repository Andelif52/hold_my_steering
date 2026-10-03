namespace HoldMySteeringReceiver
{
    public static class ErrorMessages
    {

        public static string Vigem =
@"ViGEmBus Driver Problem

Hold My Steering Receiver requires ViGEmBus to create a virtual Xbox controller.

Possible problems:

1. ViGEmBus is not installed.
2. ViGEmBus installation is corrupted.
3. The ViGEmBus service is not running.

Fix:

1. Open the ViGEmBus installer included with Hold My Steering.

2. Install ViGEmBus.

3. Restart Windows.

4. Open Hold My Steering Receiver again.

If the problem continues:

1. Open Command Prompt as Administrator.

2. Run:

sc query ViGEmBus

3. If the service does not appear, reinstall ViGEmBus.";





        public static string Firewall =
@"Windows Firewall Problem

A device tried to connect but could not reach the Receiver.

This is usually caused by Windows Firewall blocking incoming TCP connections.

Fix:

1. Open Windows Security.

2. Go to:

Firewall & network protection

3. Select:

Allow an app through firewall

4. Click:

Change settings

5. Find:

Hold My Steering Receiver

6. Enable it for:

Private networks

7. Restart the Receiver application.

8. Start the server again.";





        public static string Connection =
@"Connection Problem

The mobile app cannot connect to the Receiver.

Check the following:

1. Make sure the phone and computer are connected to the same WiFi network.

2. Check the IP address shown in the Receiver.

3. Enter the same IP address in the mobile app.

4. Make sure the Receiver server is running.

5. Disable mobile data on the phone temporarily and try again.

6. Restart both applications.";





        public static string Server =
        @"Server Problem

The Receiver server cannot start.

Possible causes:

1. Another application is already using port 5000.

2. The application does not have required permissions.

Fix:

1. Close Hold My Steering Receiver.

2. Restart the application.

3. Run the application as Administrator.

4. Check if another application is using port 5000.

To check:

1. Open Command Prompt.

2. Run:

netstat -ano | findstr :5000

3. If you see a result like:

TCP    0.0.0.0:5000    0.0.0.0:0    LISTENING    1234

The last number is the Process ID (PID).

4. Find the application using that PID.

Run:

tasklist | findstr 1234

Replace 1234 with the PID you found.

5. If the application is not required, terminate the process.

To terminate it:

1. Open Command Prompt as Administrator.

2. Run:

taskkill /PID 1234 /F

Replace 1234 with the actual PID.

3. Start Hold My Steering Receiver again.

Note:
Do not delete the application files. Only terminate the running process that is using port 5000.";






        public static string Controller =
@"Controller Problem

The virtual Xbox controller is not working.

Fix:

1. Make sure ViGEmBus is installed.

2. Restart Windows.

3. Close and reopen Hold My Steering Receiver.

4. Connect the phone again.

5. Check if the game detects an Xbox controller.";

    }
}