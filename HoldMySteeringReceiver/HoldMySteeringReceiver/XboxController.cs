using Nefarius.ViGEm.Client;
using Nefarius.ViGEm.Client.Targets;
using Nefarius.ViGEm.Client.Targets.Xbox360;

namespace HoldMySteeringReceiver
{
    public class XboxController
    {
        private ViGEmClient client;
        private IXbox360Controller controller;

        public XboxController()
        {
            client = new ViGEmClient();

            controller = client.CreateXbox360Controller();

            controller.Connect();
        }

        public void SetThrottle(int value)
        {
            byte trigger =
                (byte)((value / 100.0) * 255);

            controller.SetSliderValue(
                Xbox360Slider.RightTrigger,
                trigger);
        }

        public void SetBrake(int value)
        {
            byte trigger =
                (byte)((value / 100.0) * 255);

            controller.SetSliderValue(
                Xbox360Slider.LeftTrigger,
                trigger);
        }

        public void SetSteering(int value)
        {
            short axis =
                (short)((value / 100.0) * 32767);

            controller.SetAxisValue(
                Xbox360Axis.LeftThumbX,
                axis);
        }
    }
}