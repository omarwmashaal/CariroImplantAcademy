using System;
using System.Collections.Generic;
using System.IO.Pipes;
using System.Linq;
using System.Management;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using BenchmarkDotNet.Portability.Cpu;
using Hardware.Info;

namespace CIA_Service
{
    internal static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        static void Main()
        {
            ServiceBase[] ServicesToRun;
            ServicesToRun = new ServiceBase[]
            {
                new Service1()
            };
            ServiceBase.Run(ServicesToRun);

            using (var server = new NamedPipeServerStream("mypipe", PipeDirection.InOut, 1, PipeTransmissionMode.Message, PipeOptions.Asynchronous, 4096, 4096))
            {
                server.WaitForConnection();

                // Perform mutual authentication
                // Example: Server sends a challenge to the client
                var challenge = GenerateChallenge();
                Send(server, challenge);

                // Client response
                var challengeResponse = Receive(server);

                // Verify client's response
                if (!VerifyResponse(challengeResponse, challenge))
                {
                    server.Close();
                    throw new Exception();
                }

                Send(server,challenge);

                // Communication is now authenticated

                // Read Request
                var requestMessage = Receive(server);

                var message = Decrypt(requestMessage, Encoding.UTF8.GetString(challengeResponse));

                long ticks;
                try
                {
                    //extract the long value of the message
                    String tempString = Encoding.UTF8.GetString(message);
                    ticks = long.Parse(tempString);
                    DateTime value = new DateTime(ticks);
                    if (value.AddSeconds(1) > DateTime.Now)
                    {
                        server.Close();
                        throw new Exception();
                    }


                }
                catch (Exception ex)
                {
                    server.Close();
                    throw new Exception();
                }

                string cpuInfo = GetCpuInfo();
                string ramInfo = GetRamInfo();

                // Combine CPU and RAM information
                string machineInfo = cpuInfo + ramInfo;

                // Create fingerprint from combined information
                string fingerprint = GetHash(machineInfo);


                if(fingerprint!= "5e634b26342cc2c9e6c4167b85b2248f9753a58f6c2613fa5cd1dbc544cccbb7")
                {
                    server.Close();
                    throw new Exception();
                }
                //Send FingerPrint
                Send(server, Encrypt(fingerprint, ticks.ToString()));



                // Close named pipe
                server.Close();
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

        static bool VerifyResponse(byte[] response, byte[] challenge)
        {
            using (var sha256 = SHA256.Create())
            {
                byte[] solution = sha256.ComputeHash(challenge);

                if (response.Length != solution.Length)
                    return false;

                // Initialize a variable to keep track of the result of the comparison
                byte result = 0;

                // Perform a bitwise comparison of each byte in the arrays
                for (int i = 0; i < response.Length; i++)
                {
                    result |= (byte)(response[i] ^ solution[i]);
                }

                // If the result is 0, the arrays are equal; otherwise, they are not
                return result == 0;



            }

        }


        static void Send(NamedPipeServerStream pipe, byte[] data)
        {
            pipe.Write(data, 0, data.Length);
            pipe.WaitForPipeDrain();
        }

        static byte[] Receive(NamedPipeServerStream pipe)
        {
            var buffer = new byte[4096];
            var bytesRead = pipe.Read(buffer, 0, buffer.Length);
            var data = new byte[bytesRead];
            Array.Copy(buffer, data, bytesRead);
            return data;
        }
        private static byte[] Decrypt(byte[] encryptedData, String temp)
        {
            // Perform decryption using symmetric cryptography (AES)
            using (var aes = Aes.Create())
            {

                aes.Key = GenerateAESKey($"Power{temp}User.97");
                aes.IV = GenerateAESIV($"Power{temp}User.97");
                aes.Padding = PaddingMode.PKCS7;
                var decryptor = aes.CreateDecryptor();
                byte[] decryptedData = decryptor.TransformFinalBlock(encryptedData, 0, encryptedData.Length);
                return decryptedData;
            }
        }
        private static byte[] Encrypt(string message, String temp)
        {
            // Perform encryption using symmetric or asymmetric cryptography
            // Example using AES encryption:
            using (var aes = Aes.Create())
            {

                aes.Key = GenerateAESKey($"Power{temp}User.97");
                aes.IV = GenerateAESIV($"Power{temp}User.97");
                aes.Padding = PaddingMode.PKCS7;
                var encryptor = aes.CreateEncryptor();
                return encryptor.TransformFinalBlock(Encoding.UTF8.GetBytes(message), 0, message.Length);
            }
        }

        private static byte[] GenerateAESKey(string password)
        {
            // Convert password to byte array
            byte[] passwordBytes = Encoding.UTF8.GetBytes(password);

            // Use PBKDF2 with SHA256 for key derivation
            using (var deriveBytes = new Rfc2898DeriveBytes(passwordBytes, salt: new byte[16], iterations: 10000, HashAlgorithmName.SHA256))
            {
                // Generate 256-bit key
                return deriveBytes.GetBytes(32);
            }
        }

        private static byte[] GenerateAESIV(string password)
        {
            // Convert password to byte array
            byte[] passwordBytes = Encoding.UTF8.GetBytes(password);

            // Use PBKDF2 with SHA256 for key derivation
            using (var deriveBytes = new Rfc2898DeriveBytes(passwordBytes, salt: new byte[16], iterations: 10000, HashAlgorithmName.SHA256))
            {
                // Generate 128-bit IV
                return deriveBytes.GetBytes(16);
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
