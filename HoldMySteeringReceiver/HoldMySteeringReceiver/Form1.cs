namespace HoldMySteeringReceiver
{
    public partial class Form1 : Form
    {

        private TcpServer server = new();

        private XboxController xbox = new();



        private int leftStickX = 0;

        private int leftStickY = 0;


        private int rightStickX = 0;

        private int rightStickY = 0;





        public Form1()
        {
            InitializeComponent();
        }









        private async void btnStart_Click(object sender, EventArgs e)
        {

            btnStart.Enabled = false;

            btnClose.Enabled = true;

            lblStatus.Text = "Listening...";


            await server.StartAsync(
                ProcessMessage
            );

        }









        private void btnClose_Click(object sender, EventArgs e)
        {

            server.StopServer();


            lblStatus.Text = "Server Closed";


            btnClose.Enabled = false;

            btnStart.Enabled = true;

        }









        private void ProcessMessage(string msg)
        {

            System.Diagnostics.Debug.WriteLine("Received: " + msg);

            Invoke(() =>
            {



                // =====================
                // Racing Controls
                // =====================


                if (msg.StartsWith("THROTTLE:"))
                {

                    lblThrottle.Text = msg;


                    int value =
                        int.Parse(
                            msg.Replace(
                                "THROTTLE:",
                                ""));


                    xbox.SetThrottle(value);

                }







                if (msg.StartsWith("BRAKE:"))
                {

                    lblBrake.Text = msg;


                    int value =
                        int.Parse(
                            msg.Replace(
                                "BRAKE:",
                                ""));


                    xbox.SetBrake(value);

                }







                if (msg.StartsWith("STEER:"))
                {

                    lblSteering.Text = msg;


                    int value =
                        int.Parse(
                            msg.Replace(
                                "STEER:",
                                ""));


                    xbox.SetSteering(value);

                }









                // =====================
                // Buttons / Triggers
                // =====================


                string[] parts =
                    msg.Split(':');



                if (parts.Length == 2)
                {

                    string command =
                        parts[0];


                    string value =
                        parts[1];



                    if (value == "1" ||
                        value == "0")
                    {

                        bool pressed =
                            value == "1";



                        switch (command)
                        {


                            case "A":

                            case "B":

                            case "X":

                            case "Y":

                            case "LB":

                            case "RB":

                            case "VIEW":

                            case "MENU":


                                xbox.SetButton(

                                    command,

                                    pressed

                                );

                                break;





                            case "LT":

                            case "RT":


                                xbox.SetTrigger(

                                    command,

                                    pressed

                                );

                                break;







                            case "DPAD_UP":


                                xbox.SetDPad(

                                    "UP",

                                    pressed

                                );

                                break;





                            case "DPAD_DOWN":


                                xbox.SetDPad(

                                    "DOWN",

                                    pressed

                                );

                                break;





                            case "DPAD_LEFT":


                                xbox.SetDPad(

                                    "LEFT",

                                    pressed

                                );

                                break;





                            case "DPAD_RIGHT":


                                xbox.SetDPad(

                                    "RIGHT",

                                    pressed

                                );

                                break;


                        }


                    }


                }









                // =====================
                // Analog Sticks
                // =====================



                if (msg.StartsWith("LEFT_STICK_X:"))
                {

                    leftStickX =
                        int.Parse(
                            msg.Replace(
                                "LEFT_STICK_X:",
                                ""));



                    xbox.SetLeftStick(

                        leftStickX,

                        leftStickY

                    );

                }







                if (msg.StartsWith("LEFT_STICK_Y:"))
                {

                    leftStickY =
                        int.Parse(
                            msg.Replace(
                                "LEFT_STICK_Y:",
                                ""));



                    xbox.SetLeftStick(

                        leftStickX,

                        leftStickY

                    );

                }









                if (msg.StartsWith("RIGHT_STICK_X:"))
                {

                    rightStickX =
                        int.Parse(
                            msg.Replace(
                                "RIGHT_STICK_X:",
                                ""));



                    xbox.SetRightStick(

                        rightStickX,

                        rightStickY

                    );

                }







                if (msg.StartsWith("RIGHT_STICK_Y:"))
                {

                    rightStickY =
                        int.Parse(
                            msg.Replace(
                                "RIGHT_STICK_Y:",
                                ""));



                    xbox.SetRightStick(

                        rightStickX,

                        rightStickY

                    );

                }



            });


        }


    }

}