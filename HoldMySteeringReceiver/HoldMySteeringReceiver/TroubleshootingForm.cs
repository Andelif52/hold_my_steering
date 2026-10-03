namespace HoldMySteeringReceiver
{
    public partial class TroubleshootingForm : Form
    {

        public TroubleshootingForm()
        {
            InitializeComponent();
        }



        private void ShowMessage(string message)
        {
            MessageBox.Show(
                message,
                "Hold My Steering Troubleshooting",
                MessageBoxButtons.OK,
                MessageBoxIcon.Information
            );
        }



        private void btnVigem_Click(object sender, EventArgs e)
        {
            ShowMessage(ErrorMessages.Vigem);
        }



        private void btnFirewall_Click(object sender, EventArgs e)
        {
            ShowMessage(ErrorMessages.Firewall);
        }



        private void btnConnection_Click(object sender, EventArgs e)
        {
            ShowMessage(ErrorMessages.Connection);
        }



        private void btnServer_Click(object sender, EventArgs e)
        {
            ShowMessage(ErrorMessages.Server);
        }



        private void btnController_Click(object sender, EventArgs e)
        {
            ShowMessage(ErrorMessages.Controller);
        }

    }
}