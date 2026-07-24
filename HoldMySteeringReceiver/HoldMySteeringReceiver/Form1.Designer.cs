namespace HoldMySteeringReceiver
{
    partial class Form1
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            btnStart = new Button();
            lblStatus = new Label();
            lblThrottle = new Label();
            lblBrake = new Label();
            lblSteering = new Label();
            btnClose = new Button();
            SuspendLayout();
            // 
            // btnStart
            // 
            btnStart.Location = new Point(188, 379);
            btnStart.Name = "btnStart";
            btnStart.Size = new Size(125, 43);
            btnStart.TabIndex = 0;
            btnStart.Text = "Start Server";
            btnStart.UseVisualStyleBackColor = true;
            btnStart.Click += btnStart_Click;
            // 
            // lblStatus
            // 
            lblStatus.Location = new Point(87, 75);
            lblStatus.Name = "lblStatus";
            lblStatus.Size = new Size(200, 30);
            lblStatus.TabIndex = 1;
            lblStatus.Text = "Status: Waiting...";
            // 
            // lblThrottle
            // 
            lblThrottle.Location = new Point(87, 161);
            lblThrottle.Name = "lblThrottle";
            lblThrottle.Size = new Size(200, 30);
            lblThrottle.TabIndex = 2;
            lblThrottle.Text = "Throttle: 0";
            // 
            // lblBrake
            // 
            lblBrake.Location = new Point(87, 244);
            lblBrake.Name = "lblBrake";
            lblBrake.Size = new Size(200, 30);
            lblBrake.TabIndex = 3;
            lblBrake.Text = "Brake: 0";
            // 
            // lblSteering
            // 
            lblSteering.Location = new Point(87, 319);
            lblSteering.Name = "lblSteering";
            lblSteering.Size = new Size(200, 30);
            lblSteering.TabIndex = 4;
            lblSteering.Text = "Steering: 0";
            // 
            // btnClose
            // 
            btnClose.Enabled = false;
            btnClose.Location = new Point(376, 379);
            btnClose.Name = "btnClose";
            btnClose.Size = new Size(125, 43);
            btnClose.TabIndex = 5;
            btnClose.Text = "Close Server";
            btnClose.UseVisualStyleBackColor = true;
            btnClose.Click += btnClose_Click;
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(btnClose);
            Controls.Add(lblSteering);
            Controls.Add(lblBrake);
            Controls.Add(lblThrottle);
            Controls.Add(lblStatus);
            Controls.Add(btnStart);
            Name = "Form1";
            Text = "Form1";
            ResumeLayout(false);
        }

        #endregion

        private Button btnStart;
        private Label lblStatus;
        private Label lblThrottle;
        private Label lblBrake;
        private Label lblSteering;
        private Button btnClose;
    }
}
