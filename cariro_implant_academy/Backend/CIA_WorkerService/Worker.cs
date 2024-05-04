using Hardware.Info;
using System.IO.Pipes;
using System.Management;
using System.Security.Cryptography;
using System.Text;
namespace CIA_WorkerService
{
    public class Worker : BackgroundService
    {
        private readonly ILogger<Worker> _logger;

        public Worker(ILogger<Worker> logger)
        {
            _logger = logger;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                using (var server = new NamedPipeServerStream("mypipe", PipeDirection.InOut))
                {
                    server.WaitForConnection();

                    // Perform mutual authentication
                    // Example: Server sends a challenge to the client
                    var challenge = GenerateChallenge();
                    await SendAsync(server, challenge, stoppingToken);

                    // Client response
                    var clientResponse = await ReceiveAsync(server, stoppingToken);

                    // Verify client's response
                    if (!SolveChallenge(clientResponse, challenge))
                    {
                        server.Close();
                    }
                    await SendAsync(server, Encrypt("Ok"), stoppingToken);

                    // Communication is now authenticated

                    // Read message from client and decrypt it

                    var receivedMessage = await ReceiveAsync(server, stoppingToken);
                    var message = Decrypt(receivedMessage);
                    long ticks = 0 ;
                    try
                    {
                        //extract the long value of the message
                        String tempString = Encoding.UTF8.GetString(message);
                        ticks = long.Parse(tempString);
                        DateTime value = new DateTime(ticks);
                        if (value.AddSeconds(1) > DateTime.Now)
                        {
                            server.Close();
                        }


                    }
                    catch (Exception ex)
                    {
                        server.Close();
                    }

                    
                    string cpuInfo = GetCpuInfo();
                    string ramInfo = GetRamInfo();

                    // Combine CPU and RAM information
                    string machineInfo = cpuInfo + ramInfo;

                    // Create fingerprint from combined information
                    string fingerprint = GetHash(machineInfo);




                    // Send encrypted response back to client
                    var response = $"Data is totaly Fine {Encrypt(ticks.ToString())}";
                    await SendAsync(server, Encrypt(response), stoppingToken);

                    // Close named pipe
                    server.Close();
                }

                await Task.Delay(1000, stoppingToken); // Example delay before accepting another connection
            }
        }

        static byte[] GenerateChallenge()
        {
            // Generate a random challenge
            byte[] challenge = new byte[16];
            using (var rng = new RNGCryptoServiceProvider())
            {
                rng.GetBytes(challenge);
            }
            return challenge;
        }

        static bool SolveChallenge(byte[] response, byte[] challenge)
        {
            // Hash the challenge using SHA256
            byte[] hashedChallenge;
            using (var sha256 = SHA256.Create())
            {
                hashedChallenge = sha256.ComputeHash(challenge);
            }

            // Compare the client's response with the hashed challenge
            return CryptographicOperations.FixedTimeEquals(hashedChallenge, response);
        }

        static async Task SendAsync(NamedPipeServerStream pipe, byte[] data, CancellationToken cancellationToken)
        {
            await pipe.WriteAsync(data, 0, data.Length, cancellationToken);
            pipe.WaitForPipeDrain();
        }

        static async Task<byte[]> ReceiveAsync(NamedPipeServerStream pipe, CancellationToken cancellationToken)
        {
            var buffer = new byte[4096];
            var bytesRead = await pipe.ReadAsync(buffer, 0, buffer.Length, cancellationToken);
            var data = new byte[bytesRead];
            Array.Copy(buffer, data, bytesRead);
            return data;
        }

        static byte[] Encrypt(string message)
        {
            // Perform encryption using symmetric cryptography (AES)
            using (var aes = Aes.Create())
            {
                aes.GenerateKey();
                aes.GenerateIV();
                aes.Padding = PaddingMode.PKCS7; 
                var encryptor = aes.CreateEncryptor();
                byte[] encryptedData = encryptor.TransformFinalBlock(Encoding.UTF8.GetBytes(message), 0, message.Length);
                return encryptedData;
            }
        }
        static byte[] Decrypt(byte[] encryptedData)
        {
            // Perform decryption using symmetric cryptography (AES)
            using (var aes = Aes.Create())
            {
                aes.GenerateKey();
                aes.GenerateIV();
                aes.Padding = PaddingMode.PKCS7; 
                var decryptor = aes.CreateDecryptor();
                byte[] decryptedData = decryptor.TransformFinalBlock(encryptedData, 0, encryptedData.Length);
                return decryptedData;
            }
        }
        static string GetCpuInfo()
        {
            HardwareInfo hardware = new HardwareInfo();
            var cpuList = hardware.CpuList;

            StringBuilder cpuInfoBuilder = new StringBuilder();
            foreach (var cpuInfo in cpuList)
            {
                cpuInfoBuilder.AppendLine($"Processor: {cpuInfo.Name}");
                cpuInfoBuilder.AppendLine($"Cores: {cpuInfo.NumberOfCores}");
                cpuInfoBuilder.AppendLine($"Threads: {cpuInfo.NumberOfLogicalProcessors}");
                cpuInfoBuilder.AppendLine($"Clock Speed: {cpuInfo.MaxClockSpeed} MHz");
                cpuInfoBuilder.AppendLine($"Manufacturer: {cpuInfo.Manufacturer}");
                cpuInfoBuilder.AppendLine($"Socket: {cpuInfo.SocketDesignation}");
                cpuInfoBuilder.AppendLine($"Id: {cpuInfo.ProcessorId}");
                cpuInfoBuilder.AppendLine();
            }

            return cpuInfoBuilder.ToString();
        }

        static string GetRamInfo()
        {
            ManagementObjectSearcher searcher = new ManagementObjectSearcher("SELECT * FROM Win32_PhysicalMemory");
            StringBuilder ramInfoBuilder = new StringBuilder();

            foreach (ManagementObject obj in searcher.Get())
            {
                ulong capacity = Convert.ToUInt64(obj["Capacity"]);
                string capacityGB = $"{capacity / (1024 * 1024 * 1024)} GB";

                ramInfoBuilder.AppendLine($"Capacity: {capacityGB}");
                ramInfoBuilder.AppendLine($"Manufacturer: {obj["Manufacturer"]}");
                ramInfoBuilder.AppendLine($"Speed: {obj["Speed"]} MHz");
                ramInfoBuilder.AppendLine();
            }

            return ramInfoBuilder.ToString();
        }

        static string GetHash(string input)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(input));
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }
    }
}