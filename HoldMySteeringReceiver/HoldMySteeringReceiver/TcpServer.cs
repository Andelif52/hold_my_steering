using System.IO;
using System.Net;
using System.Net.Sockets;

namespace HoldMySteeringReceiver
{
    public class TcpServer
    {
        private TcpListener? listener;

        private bool isRunning = false;


        public async Task StartAsync(Action<string> onMessage)
        {
            listener =
                new TcpListener(
                    IPAddress.Any,
                    5000);

            listener.Start();

            isRunning = true;


            while (isRunning)
            {
                try
                {
                    var client =
                        await listener
                        .AcceptTcpClientAsync();


                    _ = Task.Run(async () =>
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
                                break;

                            onMessage(msg);
                        }

                    });

                }
                catch (SocketException)
                {
                    // This happens when the server
                    // is intentionally closed.

                    break;
                }
            }
        }


        public void StopServer()
        {
            isRunning = false;

            listener?.Stop();
        }

    }
}