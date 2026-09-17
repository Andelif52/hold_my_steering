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


            controller =
                client.CreateXbox360Controller();


            controller.Connect();

        }









        // =========================
        // Racing Controls
        // =========================



        public void SetThrottle(int value)
        {

            byte trigger =
                (byte)((value / 100.0) * 255);


            controller.SetSliderValue(

                Xbox360Slider.RightTrigger,

                trigger

            );

        }







        public void SetBrake(int value)
        {

            byte trigger =
                (byte)((value / 100.0) * 255);


            controller.SetSliderValue(

                Xbox360Slider.LeftTrigger,

                trigger

            );

        }







        public void SetSteering(int value)
        {

            short axis =
                (short)((value / 100.0) * 32767);


            controller.SetAxisValue(

                Xbox360Axis.LeftThumbX,

                axis

            );

        }









        // =========================
        // Analog Sticks
        // =========================



        public void SetLeftStick(
            int x,
            int y
        )
        {

            controller.SetAxisValue(

                Xbox360Axis.LeftThumbX,

                ConvertAxis(x)

            );



            controller.SetAxisValue(

                Xbox360Axis.LeftThumbY,

                ConvertAxis(-y)

            );

        }








        public void SetRightStick(
            int x,
            int y
        )
        {

            controller.SetAxisValue(

                Xbox360Axis.RightThumbX,

                ConvertAxis(x)

            );



            controller.SetAxisValue(

                Xbox360Axis.RightThumbY,

                ConvertAxis(-y)

            );

        }








        private short ConvertAxis(int value)
        {

            value =
                Math.Clamp(
                    value,
                    -100,
                    100
                );


            return (short)(

                value / 100.0 * 32767

            );

        }









        // =========================
        // Buttons
        // =========================



        public void SetButton(
     string button,
     bool pressed
 )
        {

            Xbox360Button? xboxButton = button switch
            {
                "A" =>
                    Xbox360Button.A,

                "B" =>
                    Xbox360Button.B,

                "X" =>
                    Xbox360Button.X,

                "Y" =>
                    Xbox360Button.Y,

                "LB" =>
                    Xbox360Button.LeftShoulder,

                "RB" =>
                    Xbox360Button.RightShoulder,

                "VIEW" =>
                    Xbox360Button.Back,

                "MENU" =>
                    Xbox360Button.Start,

                "LEFT_STICK" =>
    Xbox360Button.LeftThumb,

                "RIGHT_STICK" =>
                    Xbox360Button.RightThumb,

                _ =>
                    null
            };


            if (xboxButton != null)
            {
                controller.SetButtonState(
                    xboxButton.Id,
                    pressed
                );
            }

        }





        public void SetTrigger(
            string trigger,
            bool pressed
        )
        {
            System.Diagnostics.Debug.WriteLine(
                $"Trigger: {trigger} Pressed: {pressed}"
            );


            byte value =
                pressed ? (byte)255 : (byte)0;


            if (trigger == "LT")
            {
                controller.SetSliderValue(
                    Xbox360Slider.LeftTrigger,
                    value
                );
            }


            if (trigger == "RT")
            {
                controller.SetSliderValue(
                    Xbox360Slider.RightTrigger,
                    value
                );
            }
        }







        // =========================
        // D-Pad
        // =========================



        public void SetDPad(
            string direction,
            bool pressed
        )
        {

            Xbox360Button? dpadButton = direction switch
            {

                "UP" =>
                    Xbox360Button.Up,


                "DOWN" =>
                    Xbox360Button.Down,


                "LEFT" =>
                    Xbox360Button.Left,


                "RIGHT" =>
                    Xbox360Button.Right,


                _ =>
                    null

            };




            if (dpadButton != null)
            {

                controller.SetButtonState(

                    dpadButton.Id,

                    pressed

                );

            }


        }






    }

}