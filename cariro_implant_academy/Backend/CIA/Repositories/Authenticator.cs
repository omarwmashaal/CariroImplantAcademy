


using System;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using CIA.Repositories.Interfaces;
using Hardware.Info;
using Microsoft.IdentityModel.Tokens;


//public sealed class Authenticator : IAuthenticator
//{
//    private readonly byte[] _validationKey;

   
//    private string GetCpuInfo()
//    {
//        HardwareInfo hardware = new HardwareInfo();
//        var cpuList = hardware.CpuList;

//        StringBuilder cpuInfoBuilder = new StringBuilder();
//        foreach (var cpuInfo in cpuList)
//        {
//            cpuInfoBuilder.AppendLine($"Processor: {cpuInfo.Name}");
//            cpuInfoBuilder.AppendLine($"Cores: {cpuInfo.NumberOfCores}");
//            cpuInfoBuilder.AppendLine($"Threads: {cpuInfo.NumberOfLogicalProcessors}");
//            cpuInfoBuilder.AppendLine($"Clock Speed: {cpuInfo.MaxClockSpeed} MHz");
//            cpuInfoBuilder.AppendLine($"Manufacturer: {cpuInfo.Manufacturer}");
//            cpuInfoBuilder.AppendLine($"Socket: {cpuInfo.SocketDesignation}");
//            cpuInfoBuilder.AppendLine($"Id: {cpuInfo.ProcessorId}");
//            cpuInfoBuilder.AppendLine();
//        }

//        return cpuInfoBuilder.ToString();
//    }

//    private string GetRamInfo()
//    {
//        ManagementObjectSearcher searcher = new ManagementObjectSearcher("SELECT * FROM Win32_PhysicalMemory");
//        StringBuilder ramInfoBuilder = new StringBuilder();

//        foreach (ManagementObject obj in searcher.Get())
//        {
//            ulong capacity = Convert.ToUInt64(obj["Capacity"]);
//            string capacityGB = $"{capacity / (1024 * 1024 * 1024)} GB";

//            ramInfoBuilder.AppendLine($"Capacity: {capacityGB}");
//            ramInfoBuilder.AppendLine($"Manufacturer: {obj["Manufacturer"]}");
//            ramInfoBuilder.AppendLine($"Speed: {obj["Speed"]} MHz");
//            ramInfoBuilder.AppendLine();
//        }

//        return ramInfoBuilder.ToString();
//    }

//    private string GetHash(string input)
//    {
//        using (SHA256 sha256Hash = SHA256.Create())
//        {
//            byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(input));
//            StringBuilder builder = new StringBuilder();
//            for (int i = 0; i < bytes.Length; i++)
//            {
//                builder.Append(bytes[i].ToString("x2"));
//            }
//            return builder.ToString();
//        }
//    }

//    public string getFingerPrint()
//    {
//        string cpuInfo = GetCpuInfo();
//        string ramInfo = GetRamInfo();

//        // Combine CPU and RAM information
//        string machineInfo = cpuInfo + ramInfo;

//        // Create fingerprint from combined information
//        return  Encoding.UTF8.GetBytes(GetHash(machineInfo));

//    }
//}
