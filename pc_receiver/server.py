import socket

HOST = "0.0.0.0"
PORT = 5000

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

server.bind((HOST, PORT))
server.listen(1)

print("=" * 40)
print("HOLD MY STEERING SERVER")
print("=" * 40)
print(f"Listening on Port {PORT}...")
print()

client, address = server.accept()

print(f"Client Connected: {address}")

client.send(
    "CONNECTED SUCCESSFULLY".encode()
)


while True:
    try:
        data = client.recv(1024)

        if not data:
            break

        message = data.decode()

        print("Received:")
        print(message)

    except Exception as e:
        print(e)
        break

client.close()
server.close()