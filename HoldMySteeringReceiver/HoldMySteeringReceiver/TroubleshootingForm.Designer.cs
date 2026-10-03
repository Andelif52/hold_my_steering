namespace HoldMySteeringReceiver
{
    partial class TroubleshootingForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
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
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            lblTitle = new Label();
            btnVigem = new Button();
            btnFirewall = new Button();
            btnConnection = new Button();
            btnServer = new Button();
            btnController = new Button();
            SuspendLayout();
            // 
            // lblTitle
            // 
            lblTitle.AutoSize = true;
            lblTitle.Font = new Font("Segoe UI", 12F);
            lblTitle.Location = new Point(29, 50);
            lblTitle.Name = "lblTitle";
            lblTitle.Size = new Size(269, 21);
            lblTitle.TabIndex = 0;
            lblTitle.Text = "Select a problem to view the solution:";
            // 
            // btnVigem
            // 
            btnVigem.Location = new Point(29, 126);
            btnVigem.Name = "btnVigem";
            btnVigem.Size = new Size(150, 23);
            btnVigem.TabIndex = 1;
            btnVigem.Text = "ViGEmBus Problems";
            btnVigem.UseVisualStyleBackColor = true;
            btnVigem.Click += btnVigem_Click;
            // 
            // btnFirewall
            // 
            btnFirewall.Location = new Point(29, 189);
            btnFirewall.Name = "btnFirewall";
            btnFirewall.Size = new Size(150, 23);
            btnFirewall.TabIndex = 2;
            btnFirewall.Text = "Firewall Problems";
            btnFirewall.UseVisualStyleBackColor = true;
            btnFirewall.Click += btnFirewall_Click;
            // 
            // btnConnection
            // 
            btnConnection.Location = new Point(29, 252);
            btnConnection.Name = "btnConnection";
            btnConnection.Size = new Size(150, 23);
            btnConnection.TabIndex = 3;
            btnConnection.Text = "Connection Problems";
            btnConnection.UseVisualStyleBackColor = true;
            btnConnection.Click += btnConnection_Click;
            // 
            // btnServer
            // 
            btnServer.Location = new Point(29, 317);
            btnServer.Name = "btnServer";
            btnServer.Size = new Size(150, 23);
            btnServer.TabIndex = 4;
            btnServer.Text = "Server Problems";
            btnServer.UseVisualStyleBackColor = true;
            btnServer.Click += btnServer_Click;
            // 
            // btnController
            // 
            btnController.Location = new Point(29, 388);
            btnController.Name = "btnController";
            btnController.Size = new Size(150, 23);
            btnController.TabIndex = 5;
            btnController.Text = "Controller Problems";
            btnController.UseVisualStyleBackColor = true;
            btnController.Click += btnController_Click;
            // 
            // TroubleshootingForm
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(584, 461);
            Controls.Add(btnController);
            Controls.Add(btnServer);
            Controls.Add(btnConnection);
            Controls.Add(btnFirewall);
            Controls.Add(btnVigem);
            Controls.Add(lblTitle);
            Name = "TroubleshootingForm";
            Text = "Hold My Steering Troubleshooting";
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Label lblTitle;
        private Button btnVigem;
        private Button btnFirewall;
        private Button btnConnection;
        private Button btnServer;
        private Button btnController;
    }
}