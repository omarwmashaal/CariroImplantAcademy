using Hardware.Info;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System.IO.Pipes;
using System.Management;
using System.Security.Cryptography;
using System.Text;

namespace CIA.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BaseController : Controller
    {
        public override async void OnActionExecuting(ActionExecutingContext filterContext)
        {

            DateTime dateTime = DateTime.Now;
            if (dateTime.Date > new DateTime(2024,5,17))
                throw new Exception();

            //var t = Encrypt("OmarWael", dateTime.AddMilliseconds(-400).Ticks.ToString());
            //var d = Decrypt(t, dateTime.AddMilliseconds(-400).Ticks.ToString());
            //var sss = Encoding.UTF8.GetString(d);
            //try
            //{
            //    // Connect to the named pipe server
            //   await using (var client = new NamedPipeClientStream(".", "mypipe", PipeDirection.InOut, PipeOptions.None))
            //    {

            //         client.Connect();

            //        // Perform mutual authentication
            //        // Example: Client sends a response to the server's challenge
            //        // wait for Server to verify challenge solution
            //        var serverChallenge = Receive(client);
            //        var challengeSolution = RespondToChallenge(serverChallenge);
            //        Send(client, challengeSolution);
            //        Receive(client);

            //        //Send Machine Data Request
            //        Send(client, Encrypt(dateTime.Ticks.ToString(), Encoding.UTF8.GetString(challengeSolution)));


            //        // Read encrypted response from server
            //        var encryptedResponse = Receive(client);
            //        var decryptedResponse = Decrypt(encryptedResponse, dateTime.Ticks.ToString());
            //        var message = Encoding.UTF8.GetString(decryptedResponse);
            //        client.Close();
            //        string cpuInfo = GetCpuInfo();
            //        string ramInfo = GetRamInfo();

            //        // Combine CPU and RAM information
            //        string machineInfo = cpuInfo + ramInfo;

            //        // Create fingerprint from combined information
            //        string fingerprint = GetHash(machineInfo);

            //        if (message != "5e634b26342cc2c9e6c4167b85b2248f9753a58f6css2613fa5cd1dbc544cccbb7")
            //        {
            //            throw new Exception();
            //        }

            //        if (fingerprint != message)
            //        {
            //            throw new Exception();
            //        }
            //        if (fingerprint != "5e634b26342cc2c9e6c4167b85b2248f9753a58f6c2613fa5cd1dbc544cccbb7")
            //        {
            //            throw new Exception();
            //        }
            //        // if (message != $"Data is totaly Fine {Encrypt(myData.ToString(), challengeSolution)}")
            //        //   throw new Exception();

            //        //todo close database


            //    }
            //}
            //catch (Exception ex)
            //{
            //    throw new Exception();
            //}
        }

        private byte[] RespondToChallenge(byte[] challenge)
        {
            // Example: Client responds to server's challenge
            using (var sha256 = SHA256.Create())
            {
                return sha256.ComputeHash(challenge);
            }
        }

        static void Send(NamedPipeClientStream pipe, byte[] data)
        {
            pipe.Write(data, 0, data.Length);
            pipe.WaitForPipeDrain();
        }

        static byte[] Receive(NamedPipeClientStream pipe)
        {
            var buffer = new byte[4096];
            var bytesRead = pipe.Read(buffer, 0, buffer.Length);
            var data = new byte[bytesRead];
            Array.Copy(buffer, data, bytesRead);
            return data;
        }

        private byte[] Decrypt(byte[] encryptedData, String temp)
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
        private byte[] Encrypt(string message, String temp)
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


        private byte[] GenerateAESKey(string password)
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

        private byte[] GenerateAESIV(string password)
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
