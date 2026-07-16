using System.IO;
using System.Net;
using System.Net.Sockets;

namespace HoldMySteeringReceiver
{
    public class TcpServer
    {
        private TcpListener? listener;

        public async Task StartAsync(
            Action<string> onMessage)
        {
            listener =
                new TcpListener(
                    IPAddress.Any,
                    5000);

            listener.Start();

            while (true)
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
        }
    }
}