namespace HoldMySteeringReceiver
{
    public partial class Form1 : Form
    {

        private TcpServer server = new();
        private XboxController xbox = new();


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
                ProcessMessage);
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
            Invoke(() =>
            {
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
            });
        }


    }
}
