using System.IO;
using System.Net;
using System.Net.Sockets;

namespace HoldMySteeringReceiver
{
    public class TcpServer
    {
        private TcpClient? connectedClient;

        private TcpListener? listener;

        private bool isRunning = false;


        public event Action<string>? StatusChanged;


        private void ReportStatus(string message)
        {
            StatusChanged?.Invoke(message);
        }


        public async Task StartAsync(Action<string> onMessage)
        {
            try
            {
                listener =
                    new TcpListener(
                        IPAddress.Any,
                        5000);

                listener.Start();

                isRunning = true;


                ReportStatus(
                    "Server started.\nWaiting for mobile connection..."
                );


                while (isRunning)
                {
                    try
                    {
                        var client =
                            await listener
                            .AcceptTcpClientAsync();


                        connectedClient = client;


                        ReportStatus(
                            "Mobile device connected."
                        );


                        _ = Task.Run(async () =>
                        {
                            try
                            {
                                var stream =
                                    client.GetStream();


                                StreamReader reader =
                                    new StreamReader(stream);



                                while (true)
                                {
                                    string? msg =
                                        await reader
                                        .ReadLineAsync();


                                    if (msg == null)
                                    {
                                        break;
                                    }


                                    Console.WriteLine(
                                        "RAW TCP MESSAGE LENGTH: "
                                        + msg.Length
                                    );


                                    Console.WriteLine(
                                        "RAW TCP MESSAGE CONTENT: ["
                                        + msg + "]"
                                    );


                                    onMessage(msg);
                                }

                            }
                            catch
                            {

                            }
                            finally
                            {
                                connectedClient = null;

                                ReportStatus(
                                    "Mobile device disconnected."
                                );
                            }

                        });

                    }
                    catch (SocketException ex)
                    {
                        if (isRunning)
                        {
                            ReportStatus(
                                "Network error: " + ex.Message
                            );
                        }

                        break;
                    }

                }

            }
            catch (SocketException ex)
            {
                ReportStatus(
                    "Server could not start.\n\n" +
                    "Possible causes:\n" +
                    "• Another application is using the port.\n" +
                    "• Windows Firewall blocked the application.\n\n" +
                    ex.Message
                );
            }

        }



        public void SendMessage(string message)
        {
            if (connectedClient == null)
                return;


            try
            {
                var stream =
                    connectedClient.GetStream();


                StreamWriter writer =
                    new StreamWriter(stream);


                writer.WriteLine(message);

                writer.Flush();

            }
            catch
            {
                ReportStatus(
                    "Failed to send data to mobile device."
                );
            }
        }



        public void StopServer()
        {
            isRunning = false;

            listener?.Stop();


            connectedClient?.Close();

            connectedClient = null;


            ReportStatus(
                "Server stopped."
            );
        }

    }
}